# vips-alpine

Alpine Linux based VIPS Docker image.

Compiles [libvips](https://github.com/libvips/libvips) from source, and includes most VIPS features except ImageMagick/GraphicsMagick, OpenSlide, matio, cfitsio, and OpenEXR.

## Usage

To build the image:

```sh
docker build -t jramos/vips:8.15.0 .
```

Optional build arguments can be used to change the Alpine or libvips version.

```sh
docker build \
  --build-arg ALPINE_VERSION=3.18.4 \
  --build-arg VIPS_VERSION=8.15.0 \
  -t jramos/vips:8.15.0 .
```

The tagged version can then be run with:

```sh
docker run jramos/vips:8.15.0
```

`/usr/bin/vips` is the entrypoint, so all arguments are passed directly to it.
