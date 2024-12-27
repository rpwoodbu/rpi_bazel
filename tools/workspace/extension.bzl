load("//tools/workspace:default.bzl", "add_default_repositories")

def _rpi_bazel_repos_impl(ctx):
    add_default_repositories()

rpi_bazel_repos = module_extension(
    implementation = _rpi_bazel_repos_impl,
)
