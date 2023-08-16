const std = @import("std");
const testing = std.testing;

test {
    _ = @import("./wabt_bindings.zig");
    _ = @import("./features.zig");
    _ = @import("./output_buffer.zig");
    _ = @import("./errors.zig");
    _ = @import("./lexer.zig");
    _ = @import("./module.zig");
}
