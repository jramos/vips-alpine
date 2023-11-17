ARG ALPINE_VERSION=3.18
ARG VIPS_VERSION=8.15.0

FROM alpine:${ALPINE_VERSION}

ARG VIPS_VERSION

RUN set -x -o pipefail \
    && wget -qO- https://github.com/libvips/libvips/releases/download/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.xz | tar xJC /tmp \
    && apk update \
    && apk upgrade \
    && apk add \
        cgif \
        fftw \
        giflib \
        glib \
        highway \
        lcms2 \
        libarchive \
        libexif \
        libgsf \
        libheif \
        libimagequant \
        libimagequant \
        libjpeg-turbo \
        libjxl \
        libpng \
        librsvg \
        libspng \
        libwebp \
        libxml2 \
        openjpeg \
        orc \
        pango \
        poppler-glib \
        tiff \
        zlib \
    && apk add --virtual vips-build-dependencies \
        build-base \
        cgif-dev \
        cmake \
        fftw-dev \
        giflib-dev \
        glib-dev \
        highway-dev \
        lcms2-dev \
        libarchive-dev \
        libexif-dev \
        libgsf-dev \
        libheif-dev \
        libimagequant-dev \
        libjpeg-turbo-dev \
        libjxl-dev \
        libpng-dev \
        librsvg-dev \
        libspng-dev \
        libwebp-dev \
        libxml2-dev \
        meson \
        ninja-build \
        openjpeg-dev \
        orc-dev \
        pango-dev \
        poppler-dev \
        tiff-dev \
        zlib-dev \
    && cd /tmp/vips-${VIPS_VERSION} \
    && meson setup build --prefix /usr \
        && cd build \
        && meson compile \
        && meson test \
        && meson install \
    && cd $OLDPWD \
    && rm -rf /tmp/vips-${VIPS_VERSION} \
    && apk del --purge vips-build-dependencies \
    && rm -rf /var/cache/apk/*

ENTRYPOINT ["/usr/bin/vips"]
