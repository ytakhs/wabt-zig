const std = @import("std");

// Although this function looks imperative, note that its job is to
// declaratively construct a build graph that will be executed by an external
// runner.
pub fn build(b: *std.Build) void {
    // Standard target options allows the person running `zig build` to choose
    // what target to build for. Here we do not override the defaults, which
    // means any target is allowed, and the default is native. Other options
    // for restricting supported target set are available.
    const target = b.standardTargetOptions(.{});

    // Standard optimization options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall. Here we do not
    // set a preferred release mode, allowing the user to decide how to optimize.
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(.{
        .name = "wabt-zig",
        // In this case the main source file is merely a path, however, in more
        // complicated build scripts, this could be a generated file.
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });

    injectDeps(lib);

    // This declares intent for the library to be installed into the standard
    // location when the user invokes the "install" step (the default step when
    // running `zig build`).
    b.installArtifact(lib);

    // Creates a step for unit testing. This only builds the test executable
    // but does not run it.
    const main_tests = b.addTest(.{
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });

    injectDeps(main_tests);

    const run_main_tests = b.addRunArtifact(main_tests);

    // This creates a build step. It will be visible in the `zig build --help` menu,
    // and can be selected like this: `zig build test`
    // This will evaluate the `test` step rather than the default, which is "install".
    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&run_main_tests.step);
}

fn injectDeps(step: *std.build.CompileStep) void {
    step.linkLibC();
    step.linkLibCpp();

    step.addIncludePath(std.build.LazyPath.relative("deps/wabt/include"));
    step.addIncludePath(std.build.LazyPath.relative("deps/wabt/out/clang/Release/include"));
    step.addCSourceFile(.{ .file = std.build.LazyPath.relative("deps/wabt/src/opcode-code-table.c"), .flags = &[_][]const u8{} });
    step.addCSourceFiles(&[_][]const u8{
        "deps/wabt/src/apply-names.cc",
        "deps/wabt/src/binary.cc",
        "deps/wabt/src/binary-reader.cc",
        "deps/wabt/src/binary-reader-ir.cc",
        "deps/wabt/src/binary-reader-logging.cc",
        "deps/wabt/src/binary-reader-objdump.cc",
        "deps/wabt/src/binary-writer.cc",
        "deps/wabt/src/binary-writer-spec.cc",
        "deps/wabt/src/binding-hash.cc",
        "deps/wabt/src/color.cc",
        "deps/wabt/src/common.cc",
        "deps/wabt/src/emscripten-helpers.cc",
        "deps/wabt/src/error-formatter.cc",
        "deps/wabt/src/expr-visitor.cc",
        "deps/wabt/src/feature.cc",
        "deps/wabt/src/filenames.cc",
        "deps/wabt/src/generate-names.cc",
        "deps/wabt/src/ir.cc",
        "deps/wabt/src/ir-util.cc",
        "deps/wabt/src/leb128.cc",
        "deps/wabt/src/lexer-source.cc",
        "deps/wabt/src/lexer-source-line-finder.cc",
        "deps/wabt/src/literal.cc",
        "deps/wabt/src/opcode.cc",
        "deps/wabt/src/option-parser.cc",
        "deps/wabt/src/resolve-names.cc",
        "deps/wabt/src/shared-validator.cc",
        "deps/wabt/src/stream.cc",
        "deps/wabt/src/token.cc",
        "deps/wabt/src/type-checker.cc",
        "deps/wabt/src/utf8.cc",
        "deps/wabt/src/validator.cc",
        "deps/wabt/src/wast-lexer.cc",
        "deps/wabt/src/wast-parser.cc",
        "deps/wabt/src/wat-writer.cc",
    }, &[_][]const u8{
        "-std=c++17",
    });
}
