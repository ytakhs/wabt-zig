const std = @import("std");
const bindings = @import("./wabt_bindings.zig");
const features = @import("./features.zig");
const errors = @import("./errors.zig");
const lexer = @import("./lexer.zig");

pub const Module = @This();
const ModuleError = error{
    ApplyNameError,
    GenerateModuleError,
};

module: *bindings.WabtModule,
features: features.Features,

pub fn init(filename: [*:0]const u8, data: [*:0]const u8) !Module {
    const l = lexer.Lexer.init(filename, data);

    return .{
        .lexer = l,
    };
}

pub fn applyNames(self: *Module) ModuleError!void {
    const result = bindings.wabt_apply_names(self.raw);

    if (result == bindings.WabtResultEnum.Err) {
        return ModuleError.ApplyNameError;
    }
}

pub fn generateNames(self: *Module) ModuleError!void {
    const result = bindings.wabt_generate_names(self.raw);

    if (result == bindings.WabtResultEnum.Err) {
        return ModuleError.GenerateModuleError;
    }
}

pub fn deinit(self: *Module) void {
    bindings.wabt_destroy_module(self.raw);
}
