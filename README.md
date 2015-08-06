# Hosting BaseX Web Applications with Docker

Dockerfile (c) 2015 Jens Erat, email@jenserat.de  
Licensed under BSD license

> [BaseX](http://www.basex.org) is both a light-weight, high-performance and scalable XML Database and an XQuery 3.0 Processor with full support for the W3C Update and Full Text extensions.

This Dockerfile provides an image for hosting BaseX web applications. Currently, BaseX 8.0 nightly builds are shipped, this will change to a stable tag-based versioning with the release of BaseX 8.

## Usage

The BaseX home directory is `/srv`. For persisting databases, link or provide a volume `/srv/BaseXData`. Custom XQuery modules can be stored in `/srv/BaseXRepo`, web applications modules in `/srv/BaseXWeb`.

Repo and web modules can either be linked/provided as containers or included as child image `FROM jenserat/basex`.

BaseX runs under the internal user `basex`, which has user ID 1984. Make sure appropriate read (`BaseXRepo` and `BaseXWeb`) and write (`BaseXData`) permissions are granted!

Exposed ports are:

- 1984 (`basexclient` / BaseX API)
- 1985 (event port)
- 8984 (BaseX Web / HTTP)
- 9895 (BaseX Web stop port)

Remember to change BaseX' `admin` credentials after setup away from its default `admin` password!

## Administration and Maintenance

For administration and maintenance work, it is possible to connect a `basexclient` through port 1984. Alternatively, use the `DBA`, which is available in another Docker image `jenserat/basex-dba`.

To enter the container for various reasons, use `docker exec`, for example as `docker exec -ti [container-name] /bin/bash`.

