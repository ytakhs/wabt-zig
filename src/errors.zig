const std = @import("std");
const bindings = @import("./wabt_bindings.zig");
const output_buffer = @import("./output_buffer.zig");

pub const Errors = @This();

raw: *bindings.WabtErrors,

pub fn init() Errors {
    return .{
        .raw = bindings.wabt_new_errors(),
    };
}

pub fn deinit(self: *Errors) void {
    bindings.wabt_destroy_errors(self.raw);
}

pub fn formatBinary(self: *Errors) output_buffer.OutputBuffer {
    const buf = bindings.wabt_format_binary_errors(self.raw);

    return output_buffer.OutputBuffer.init(buf);
}

test {
    var errors = Errors.init();
    defer errors.deinit();

    var buf = errors.formatBinary();
    defer buf.deinit();

    try std.testing.expect(0 == buf.getData().len);
}
