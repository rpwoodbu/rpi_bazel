# -*- python -*-
# Copyright 2018-2022 Josh Pieper, jjp@pobox.com.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

package(default_visibility = ["//visibility:public"])

load(":cc_toolchain_config.bzl", "cc_toolchain_config", "ORG_LLVM_CLANG", "RASPBERRY_PI_AARCH64", "RASPBERRY_PI_ARMEABIHF")

# Legacy suite for use with `--noincompatible_enable_cc_toolchain_resolution`
# (default before Bazel 7), `--cpu`, and `--compiler` flags.
cc_toolchain_suite(
    name = "toolchain",
    toolchains = {
        "k8|clang": "cc_toolchain_linux",
        "armeabihf|clang": "cc_toolchain_armeabihf",
        "aarch64|clang": "cc_toolchain_aarch64",
    },
    # This prevents wildcards from trying to evaluate this, which will not work
    # when using `--incompatible_enable_cc_toolchain_resolution`.
    tags = ["manual"],
)

toolchain(
    name = "toolchain_x86_64",
    exec_compatible_with = [
        "@platforms//cpu:x86_64",
        "@platforms//os:linux",
    ],
    target_compatible_with = [
        ":clang",
        ":rpi",
        "@platforms//cpu:x86_64",
        "@platforms//os:linux",
    ],
    toolchain = ":cc_toolchain_linux",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)

toolchain(
    name = "toolchain_armv6",
    exec_compatible_with = [
        "@platforms//cpu:x86_64",
        "@platforms//os:linux",
    ],
    target_compatible_with = [
        ":armv6",
        ":clang",
        ":rpi",
        "@platforms//cpu:arm",
        "@platforms//os:linux",
    ],
    toolchain = ":cc_toolchain_armv6_armeabihf",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)

toolchain(
    name = "toolchain_armv7",
    exec_compatible_with = [
        "@platforms//cpu:x86_64",
        "@platforms//os:linux",
    ],
    target_compatible_with = [
        ":armv7",
        ":clang",
        ":rpi",
        "@platforms//cpu:arm",
        "@platforms//os:linux",
    ],
    toolchain = ":cc_toolchain_armeabihf",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)

toolchain(
    name = "toolchain_aarch64",
    exec_compatible_with = [
        "@platforms//cpu:x86_64",
        "@platforms//os:linux",
    ],
    target_compatible_with = [
        ":clang",
        ":rpi",
        "@platforms//cpu:aarch64",
        "@platforms//os:linux",
    ],
    toolchain = ":cc_toolchain_aarch64",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)

constraint_setting(name = "compiler")

constraint_value(
    name = "clang",
    constraint_setting = ":compiler",
)

constraint_setting(name = "sysroot")

constraint_value(
    name = "rpi",
    constraint_setting = ":sysroot",
)

constraint_setting(name = "arm_version")

constraint_value(
    name = "armv6",
    constraint_setting = ":arm_version",
)

constraint_value(
    name = "armv7",
    constraint_setting = ":arm_version",
)

filegroup(
    name = "empty",
    srcs = [],
    visibility = ["//visibility:private"],
)

filegroup(
    name = "everything",
    srcs = [],
    visibility = ["//visibility:private"],
)

filegroup(
    name = "clang_wrappers",
    srcs = glob(["wrapper/clang-*"]) + [
        "@org_llvm_clang//:binaries",
        "@org_llvm_clang//:clang_libs",
    ],
)

filegroup(
    name = "clang_all",
    srcs = [
        ":clang_wrappers",
        "@org_llvm_clang//:includes",
        "@org_llvm_clang//:runtime_libs",
        "@org_llvm_clang//:static_libs",
        "@org_llvm_libcxx//:raw_headers",
        "@org_llvm_libcxxabi//:raw_headers",
    ],
)


cc_toolchain_config(
    name = "clang-k8",
    toolchain_identifier = "clang-k8",
    cpu = "k8",
    target_cpu = "k8",
    target_system_name = "k8",
    builtin_include_directories = [
        "{}/include/".format(ORG_LLVM_CLANG),
        "{}/lib/clang/7.0.0/include/".format(ORG_LLVM_CLANG),
        "/usr/include/",
    ],
    host_compiler_prefix = "wrapper",
    host_compiler_path = "wrapper/clang-clang",
)


cc_toolchain(
    name = "cc_toolchain_linux",
    toolchain_identifier = "clang-x86_64",
    all_files = ":clang_all",
    compiler_files = ":clang_all",
    dwp_files = ":clang_wrappers",
    linker_files = ":clang_wrappers",
    ar_files = ":clang_wrappers",
    as_files = ":clang_wrappers",
    objcopy_files = ":clang_wrappers",
    strip_files = ":clang_wrappers",
    supports_param_files = True,
    toolchain_config = ":clang-k8",
)

filegroup(
    name = "clang_arm_all",
    srcs = [
        ":clang_all",
        "//tools/cc_toolchain/raspberry_pi_sysroot:everything",
    ],
)

cc_toolchain_config(
    name = "clang-armv6-armeabihf",
    toolchain_identifier = "clang-armv6-armeabihf",
    cpu = "k8",
    target_cpu = "armeabihf",
    target_system_name = "armeabihf",
    builtin_include_directories = [
        "{}/sysroot/usr/include/arm-linux-gnueabihf".format(RASPBERRY_PI_ARMEABIHF),
        "{}/sysroot/usr/include".format(RASPBERRY_PI_ARMEABIHF),
        "{}/include/".format(ORG_LLVM_CLANG),
        "{}/lib/clang/7.0.0/include/".format(ORG_LLVM_CLANG),
        "/usr/include/",
    ],
    host_compiler_prefix = "wrapper",
    host_compiler_path = "wrapper/clang-clang",
    extra_features = [
        "armv6_armeabihf",
    ],
    linker_bin_path = "{}/bin".format(ORG_LLVM_CLANG),
)

cc_toolchain(
    name = "cc_toolchain_armv6_armeabihf",
    toolchain_identifier = "clang-armv6-armeabihf",
    all_files = ":clang_arm_all",
    compiler_files = ":clang_arm_all",
    dwp_files = ":clang_wrappers",
    linker_files = ":clang_arm_all",
    ar_files = ":clang_arm_all",
    as_files = ":clang_arm_all",
    objcopy_files = ":clang_wrappers",
    strip_files = ":clang_wrappers",
    supports_param_files = True,
    toolchain_config = ":clang-armv6-armeabihf",
)

cc_toolchain_config(
    name = "clang-armeabihf",
    toolchain_identifier = "clang-armeabihf",
    cpu = "k8",
    target_cpu = "armeabihf",
    target_system_name = "armeabihf",
    builtin_include_directories = [
        "{}/sysroot/usr/include/arm-linux-gnueabihf".format(RASPBERRY_PI_ARMEABIHF),
        "{}/sysroot/usr/include".format(RASPBERRY_PI_ARMEABIHF),
        "{}/include/".format(ORG_LLVM_CLANG),
        "{}/lib/clang/7.0.0/include/".format(ORG_LLVM_CLANG),
        "/usr/include/",
    ],
    host_compiler_prefix = "wrapper",
    host_compiler_path = "wrapper/clang-clang",
    extra_features = [
        "armeabihf",
    ],
    linker_bin_path = "{}/bin".format(ORG_LLVM_CLANG),
)

cc_toolchain(
    name = "cc_toolchain_armeabihf",
    toolchain_identifier = "clang-armeabihf",
    all_files = ":clang_arm_all",
    compiler_files = ":clang_arm_all",
    dwp_files = ":clang_wrappers",
    linker_files = ":clang_arm_all",
    ar_files = ":clang_arm_all",
    as_files = ":clang_arm_all",
    objcopy_files = ":clang_wrappers",
    strip_files = ":clang_wrappers",
    supports_param_files = True,
    toolchain_config = ":clang-armeabihf",
)

cc_toolchain_config(
    name = "clang-aarch64",
    toolchain_identifier = "clang-aarch64",
    cpu = "k8",
    target_cpu = "aarch64",
    target_system_name = "aarch64",
    builtin_include_directories = [
        "{}/sysroot/usr/include/arm-linux-aarch64".format(RASPBERRY_PI_AARCH64),
        "{}/sysroot/usr/include".format(RASPBERRY_PI_AARCH64),
        "{}/include/".format(ORG_LLVM_CLANG),
        "{}/lib/clang/7.0.0/include/".format(ORG_LLVM_CLANG),
        "/usr/include/",
    ],
    host_compiler_prefix = "wrapper",
    host_compiler_path = "wrapper/clang-clang",
    extra_features = [
        "aarch64",
    ],
    linker_bin_path = "{}/bin".format(ORG_LLVM_CLANG),
)

cc_toolchain(
    name = "cc_toolchain_aarch64",
    toolchain_identifier = "clang-aarch64",
    all_files = ":clang_arm_all",
    compiler_files = ":clang_arm_all",
    dwp_files = ":clang_wrappers",
    linker_files = ":clang_arm_all",
    ar_files = ":clang_arm_all",
    as_files = ":clang_arm_all",
    objcopy_files = ":clang_wrappers",
    strip_files = ":clang_wrappers",
    supports_param_files = True,
    toolchain_config = ":clang-aarch64",
)
