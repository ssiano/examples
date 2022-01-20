# Recursively print the src files for a rule and all of its deps
def _print_aspect_impl(target, ctx):
    # print('target is', target)  # target object
    # print('target[CcInfo] is', target[CcInfo])  # struct
    # print('target[InstrumentedFilesInfo] is', target[InstrumentedFilesInfo])  # struct
    # print('target[OutputGroupInfo] is', target[OutputGroupInfo])  # struct
    # Make sure the rule has a srcs attribute.
    if hasattr(ctx.rule.attr, 'srcs'):
        # print('- ctx.rule.attr.srcs is', ctx.rule.attr.srcs)  # list of input file target objects
        # Iterate through the files that make up the sources and
        # print their paths.
        for src in ctx.rule.attr.srcs:
            # print('- - src is', src)  # input file target object
            # print('- - src.files is', src.files)  # depset of source file objects
            # print('- - src.files.to_list is', src.files.to_list())  # list of source file objects
            for f in src.files.to_list():
                # print('- - - f is', f)  # source file object
                # print('- - - f.path is', f.path)  # source file object's path attribute
                print(f.path)
    return []

print_aspect = aspect(
    implementation = _print_aspect_impl,
    attr_aspects = ['deps'],
)


# target is <target //main:hello-greet, keys:[CcInfo, InstrumentedFilesInfo, OutputGroupInfo]>
# target[CcInfo]                is struct(compilation_context = <unknown object com.google.devtools.build.lib.rules.cpp.CcCompilationContext>,
#                                         linking_context     = <unknown object com.google.devtools.build.lib.rules.cpp.CcLinkingContext>)
# target[InstrumentedFilesInfo] is struct(instrumented_files = depset([]),
#                                         metadata_files = depset([]))
# target[OutputGroupInfo]       is struct(_hidden_header_tokens_INTERNAL_ = depset([]),
#                                         _hidden_top_level_INTERNAL_ = depset([<generated file main/_objs/hello-greet/hello-greet.pic.o>]),
#                                         archive = depset([<generated file main/libhello-greet.a>]),
#                                         compilation_outputs = depset([<generated file main/_objs/hello-greet/hello-greet.pic.o>]),
#                                         compilation_prerequisites_INTERNAL_ = depset([<source file main/hello-greet.h>,
#                                         <source file main/hello-greet.cc>]),
#                                         dynamic_library = depset([<generated file main/libhello-greet.so>]),
#                                         temp_files_INTERNAL_ = depset([]))
# - ctx.rule.attr.srcs is [<input file target //main:hello-greet.cc>, <input file target //main:hello-greet.h>]
# - - src is <input file target //main:hello-greet.cc>
# - - src.files is depset([<source file main/hello-greet.cc>])
# - - src.files.to_list is [<source file main/hello-greet.cc>]
# - - - f is <source file main/hello-greet.cc>
# - - - f.path is main/hello-greet.cc

# The target's keys are dict keys, but are object constructors, and not strings.  They are the target's providers.
