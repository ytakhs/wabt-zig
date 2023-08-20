const std = @import("std");
const testing = std.testing;
const module = @import("./module.zig");
const lexer = @import("./lexer.zig");
const features = @import("./features.zig");

pub fn wat2wasm(wat: []const u8) !module.Output {
    _ = wat;
}

test {
    _ = @import("./wabt_bindings.zig");
    _ = @import("./features.zig");
    _ = @import("./output_buffer.zig");
    _ = @import("./errors.zig");
    _ = @import("./lexer.zig");
    _ = @import("./module.zig");
}
