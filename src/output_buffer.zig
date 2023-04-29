const std = @import("std");
const bindings = @import("./wabt_bindings.zig");

pub const OutputBuffer = @This();

raw: *bindings.WabtOutputBuffer,

pub fn init(raw: *bindings.WabtOutputBuffer) OutputBuffer {
    return .{ .raw = raw };
}

pub fn getData(self: *OutputBuffer) []const u8 {
    const ptr: [*:0]const u8 = bindings.wabt_output_buffer_get_data(self.raw);
    const len = bindings.wabt_output_buffer_get_size(self.raw);

    return ptr[0..len];
}

pub fn deinit(self: *OutputBuffer) void {
    bindings.wabt_destroy_output_buffer(self.raw);
}

test {
    const binary = [8:0]u8{
        // magic
        0x00, 0x61, 0x73, 0x6D,
        // version
        0x01, 0x00, 0x00, 0x00,
    };

    const features = bindings.wabt_new_features();
    defer bindings.wabt_destroy_features(features);

    const errors = bindings.wabt_new_errors();
    defer bindings.wabt_destroy_errors(errors);

    const read_binary_result = bindings.wabt_read_binary(binary[0..], binary.len, 0, features, errors);
    defer bindings.wabt_destroy_read_binary_result(read_binary_result);

    const module = bindings.wabt_read_binary_result_release_module(read_binary_result);
    defer bindings.wabt_destroy_module(module);

    const write_text_module = bindings.wabt_write_text_module(module, 0, 0);
    defer bindings.wabt_destroy_write_module_result(write_text_module);

    const output_buffer = bindings.wabt_write_module_result_release_output_buffer(write_text_module);

    var ob = OutputBuffer.init(output_buffer);
    defer ob.deinit();

    try std.testing.expectEqualSlices(u8, "(module)\n", ob.getData());
}
