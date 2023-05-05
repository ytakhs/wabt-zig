const std = @import("std");
const bindings = @import("./wabt_bindings.zig");
const errors = @import("./errors.zig");
const features = @import("./features.zig");

pub const Lexer = @This();

raw: *bindings.WabtWastLexer,
filename: []const u8,
data: []const u8,
errors: errors.Errors,
features: features.Features,

pub fn init(filename: []const u8, data: []const u8, f: features.Features) Lexer {
    const e = errors.Errors.init();

    return .{
        .raw = bindings.wabt_new_wast_buffer_lexer(filename, data, data.len, e.raw),
        .errors = e,
        .features = f,
    };
}

pub fn deinit(self: *Lexer) void {
    self.errors.deinit();
    bindings.wabt_destroy_wast_lexer(self.raw);
}

test {
    const filename = "test.wast";
    const data = "(module)";
    const f = features.Features.init();
    defer f.deinit();
    var lexer = Lexer.init(filename, data, f);
    defer lexer.deinit();

    std.testing.expectEqualStrings(lexer.filename, filename);
    std.testing.expectEqualStrings(lexer.data, data);
}
