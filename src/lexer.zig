const std = @import("std");
const bindings = @import("./wabt_bindings.zig");
const errors = @import("./errors.zig");
const features = @import("./features.zig");
const module = @import("./module.zig");

pub const Lexer = @This();

const LexerError = error{
    ParseWatError,
};

raw: *bindings.WabtWastLexer,
errors: errors.Errors,
features: features.Features,

pub fn init(filename: [*:0]const u8, data: [*:0]const u8, f: features.Features) Lexer {
    const e = errors.Errors.init();

    return .{
        .raw = bindings.wabt_new_wast_buffer_lexer(filename, data, std.mem.len(data), e.raw),
        .errors = e,
        .features = f,
    };
}

pub fn deinit(self: *Lexer) void {
    self.errors.deinit();
    bindings.wabt_destroy_wast_lexer(self.raw);
}

pub fn parseWat(self: *Lexer) !module.Module {
    const parse_wat_result = bindings.wabt_parse_wat(self.raw, self.features.raw, self.errors.raw);
    const result = bindings.wabt_parse_wat_result_get_result(parse_wat_result);
    if (bindings.WabtResultEnum.Error == result) {
        return LexerError.ParseWatError;
    }

    const mod = bindings.wabt_parse_wat_result_release_module(parse_wat_result);

    return module.Module.init(mod);
}

test "parseWat" {
    const filename = "test.wat";
    const data = "(module)";
    var f = features.Features.init();
    defer f.deinit();
    var lexer = Lexer.init(filename, data, f);
    defer lexer.deinit();

    var mod = try lexer.parseWat();
    defer mod.deinit();

    try std.testing.expectEqualStrings("module", @typeName(@TypeOf(mod)));
}
