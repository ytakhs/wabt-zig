const std = @import("std");
const bindings = @import("./wabt_bindings.zig");
const errors = @import("./errors.zig");
const features = @import("./features.zig");
const module = @import("./module.zig");

pub const Lexer = @This();

const ParseWatResult = struct {
    const Self = @This();

    raw: *bindings.WabtParseWatResult,
    result: bindings.WabtResultEnum,

    pub fn init(raw: *bindings.WabtParseWatResult) Self {
        return .{
            .raw = raw,
            .result = bindings.wabt_parse_wat_result_get_result(raw),
        };
    }

    pub fn isOK(self: *Self) bool {
        return bindings.WabtResultEnum.Ok == self.result;
    }
};

const LexerError = error{
    ParseWatError,
};

raw: *bindings.WabtWastLexer,
errors: errors.Errors,

pub fn init(filename: [*:0]const u8, data: [*:0]const u8) Lexer {
    const e = errors.Errors.init();

    return .{
        .errors = e,
        .raw = bindings.wabt_new_wast_buffer_lexer(filename, data, std.mem.len(data), e.raw),
    };
}

pub fn deinit(self: *Lexer) void {
    bindings.wabt_destroy_wast_lexer(self.raw);
    self.errors.deinit();
}

pub fn parseWat(self: *Lexer, f: *features.Features) LexerError!module.Module {
    const parse_wat_result = bindings.wabt_parse_wat(self.raw, f.raw, self.errors.raw);

    var result = ParseWatResult.init(parse_wat_result);
    if (!result.isOK()) {
        return LexerError.ParseWatError;
    }

    const mod = bindings.wabt_parse_wat_result_release_module(result.raw);

    return module.Module.init(mod);
}

test "parseWat" {
    const filename = "test.wat";
    const data = "(module)";
    var f = features.Features.init();
    defer f.deinit();
    var lexer = Lexer.init(filename, data);
    defer lexer.deinit();

    var result = try lexer.parseWat(&f);

    try std.testing.expectEqualStrings("module", @typeName(@TypeOf(result)));
}
