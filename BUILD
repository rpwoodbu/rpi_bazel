# For testing.
platform(
    name = "rpi-x86_64-clang",
    constraint_values = [
        "@platforms//os:linux",
        "@platforms//cpu:x86_64",
        "//tools/cc_toolchain:clang",
        "//tools/cc_toolchain:rpi",
    ],
)

# For the original Raspberry Pi.
platform(
    name = "rpi-armv6-clang",
    constraint_values = [
        "@platforms//os:linux",
        "@platforms//cpu:arm",
        "//tools/cc_toolchain:armv6",
        "//tools/cc_toolchain:clang",
        "//tools/cc_toolchain:rpi",
    ],
)

# For 32-bit Raspberry Pi 2 or 3.
platform(
    name = "rpi-armv7-clang",
    constraint_values = [
        "@platforms//os:linux",
        "@platforms//cpu:arm",
        "//tools/cc_toolchain:armv7",
        "//tools/cc_toolchain:clang",
        "//tools/cc_toolchain:rpi",
    ],
)

# For 64-bit Raspberry Pi 3 and on.
platform(
    name = "rpi-aarch64-clang",
    constraint_values = [
        "@platforms//os:linux",
        "@platforms//cpu:aarch64",
        "//tools/cc_toolchain:clang",
        "//tools/cc_toolchain:rpi",
    ],
)
