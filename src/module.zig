const std = @import("std");
const bindings = @import("./wabt_bindings.zig");

pub const Module = @This();
const ModuleError = error{
    ApplyNameError,
    GenerateModuleError,
};

raw: *bindings.WabtModule,

pub fn init(raw: *bindings.WabtModule) Module {
    return .{
        .raw = raw,
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
