load("@rules_cc//cc:defs.bzl", "cc_binary", "cc_library")
load("//aspects:file_count.bzl", "file_count_rule")

cc_library(
    name = "hello-greet",
    srcs = ["hello-greet.cc"],
    hdrs = ["hello-greet.h"],
)

cc_binary(
    name = "hello-world",
    srcs = ["hello-world.cc"],
    deps = [
        ":hello-greet",
        "//lib:hello-time",
    ],
)

file_count_rule(
    name = 'file_count',
    deps = ['hello-world'],
    extension = '*',
)
