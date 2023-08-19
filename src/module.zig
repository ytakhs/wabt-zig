const std = @import("std");
const bindings = @import("./wabt_bindings.zig");
const features = @import("./features.zig");
const errors = @import("./errors.zig");
const lexer = @import("./lexer.zig");

const Output = struct {
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
        return self.data[0 .. self.size - 1];
    }
};

pub const Module = @This();
const ModuleError = error{
    ApplyNameError,
    GenerateModuleError,
    GetResultError,
};

module: *bindings.WabtModule,
write_module: *bindings.WabtWriteModuleResult,

pub fn init(module: *bindings.WabtModule) !Module {
    return .{
        .module = module,
        .write_module = bindings.wabt_write_binary_module(module, 0, 0, 0, 0),
    };
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
    var l = lexer.Lexer.init("test.wat", "(module)");
    defer l.deinit();
    var f = features.Features.init();
    defer f.deinit();

    var mod = try l.parseWat(&f);
    defer mod.deinit();

    var out = try mod.wat2Wasm();
    const actual = out.getData();
    try std.testing.expectEqualStrings("\x00\x61\x73\x6d\x01\x00\x00", actual);
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
