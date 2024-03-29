const std = @import("std");
const bindings = @import("./wabt_bindings.zig");
const Features = @import("./features.zig").Features;
const Lexer = @import("./lexer.zig").Lexer;
const errors = @import("./errors.zig");

pub const Output = struct {
    buf: *bindings.WabtOutputBuffer,
    data: [*:0]const u8,
    size: usize,

    pub fn init(buf: *bindings.WabtOutputBuffer) Output {
        return .{
            .buf = buf,
            .data = bindings.wabt_output_buffer_get_data(buf),
            .size = bindings.wabt_output_buffer_get_size(buf),
        };
    }

    pub fn deinit(self: *Output) void {
        bindings.wabt_destroy_output_buffer(self.buf);
    }

    pub fn getData(self: *Output) []const u8 {
        return self.data[0..self.size];
    }
};

pub const Module = @This();
const ModuleError = error{
    ApplyNameError,
    GenerateModuleError,
    GetResultError,
    WatParseError,
};

const Type = enum {
    ToWat,
    ToWasm,
};

module: *bindings.WabtModule,
write_module: *bindings.WabtWriteModuleResult,
module_type: Type,

pub fn init(module: *bindings.WabtModule, module_type: Type) Module {
    return .{
        .module = module,
        .write_module = bindings.wabt_write_binary_module(module, 0, 0, 0, 0),
        .module_type = module_type,
    };
}

pub fn parseWat(filename: [*:0]const u8, wat: [*:0]const u8, features: *Features) !Module {
    var lexer = Lexer.init(filename, wat);
    defer lexer.deinit();
    var result = try lexer.parseWat(features);
    defer result.deinit();

    const mod = bindings.wabt_parse_wat_result_release_module(result.raw);

    return Module.init(mod, Type.ToWasm);
}

pub fn deinit(self: *Module) void {
    bindings.wabt_destroy_module(self.module);
    bindings.wabt_destroy_write_module_result(self.write_module);
}

pub fn wat2Wasm(self: *Module) ModuleError!Output {
    const result_enum = bindings.wabt_write_module_result_get_result(self.write_module);
    if (bindings.WabtResultEnum.Error == result_enum) {
        return ModuleError.GetResultError;
    }

    const output_buffer = bindings.wabt_write_module_result_release_output_buffer(self.write_module);

    return Output.init(output_buffer);
}

test "wat2Wasm" {
    var features = Features.init();
    defer features.deinit();

    var mod = try Module.parseWat("test.wat", "(module)", &features);
    defer mod.deinit();

    var out = try mod.wat2Wasm();
    try std.testing.expectEqualStrings("\x00\x61\x73\x6d\x01\x00\x00\x00", out.getData());
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
