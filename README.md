# Raspberry Pi bazel cross compilation rules #

This contains a set of rules to use for cross compiling C++ to a
Raspberry Pi using clang.  It includes a minimal sysroot, and only
needs a functioning clang compiler.

 * travis-ci [![Build Status](https://travis-ci.org/mjbots/rpi_bazel.svg?branch=master)](https://travis-ci.org/mjbots/rpi_bazel)

## Example Usage ##

In `tools/workspace/rpi_bazel/repository.bzl`

```
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")


def rpi_bazel_repository(name):
    commit = "XXX"
    http_archive(
        name = name,
        url = "https://github.com/mjbots/rpi_bazel/archive/{}.zip".format(commit),
        sha256 = "XXX",
        strip_prefix = "rpi_bazel-{}".format(commit),
    )

```

At least an empty `tools/workspace/rpi_bazel/BUILD` is required.

In `tools/workspace/default.bzl`:

```
load("//tools/workspace/rpi_bazel:repository.bzl", "rpi_bazel_repository")

def add_default_repositories(excludes = []):
    if "rpi_bazel" not in excludes:
        rpi_bazel_repository(name = "rpi_bazel")
```

At least an empty `tools/workspace/BUILD` is required.

In WORKSPACE:

```
load("//tools/workspace:default.bzl", "add_default_repositories")

add_default_repositories()

load("@rpi_bazel//tools/workspace:default.bzl",
     rpi_bazel_add = "add_default_repositories")
rpi_bazel_add()
```


In `.bazelrc`, if using Bazel's platforms (preferred):

```
# This is the default as of Bazel 7.
build --incompatible_enable_cc_toolchain_resolution

build --extra_toolchains=@rpi_bazel//tools/cc_toolchain:all
build:pi --platforms=@rpi_bazel//:rpi-armv7-clang
# See the top BUILD file for other platforms for different kinds of Pi.
```

In `.bazelrc`, if using the old crosstool method (deprecated in Bazel):

```
build --crosstool_top=@rpi_bazel//tools/cc_toolchain:toolchain
test --crosstool_top=@rpi_bazel//tools/cc_toolchain:toolchain

build:pi --cpu=armeabihf
test:pi --cpu=armeabihf

build:pi --compiler=clang
test:pi --compiler=clang
```

Then you can build with:

```
bazel build --config=pi //...
```
