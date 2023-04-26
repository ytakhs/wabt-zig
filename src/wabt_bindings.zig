const std = @import("std");

const WabtFeatures = extern struct {};
const WabtErrors = extern struct {};
const WabtResultEnum = enum(c_int) {
    Ok,
    Error,
};
const WabtWastLexer = extern struct {};
const WabtParseWatResult = extern struct {};
const WabtParseWastResult = extern struct {};
const WabtReadBinaryResult = extern struct {};
const WabtModule = extern struct {};
const WabtScript = extern struct {};
const WabtWriteScriptResult = extern struct {};
const WabtWriteModuleResult = extern struct {};
const WabtOutputBuffer = extern struct {};

extern fn wabt_new_features() *WabtFeatures;
extern fn wabt_destroy_features(features: *WabtFeatures) void;
extern fn wabt_new_wast_buffer_lexer(
    filename: [*:0]const u8,
    data: [*:0]const u8,
    size: usize,
    errors: *WabtErrors,
) *WabtWastLexer;
extern fn wabt_parse_wat(
    lexer: *WabtWastLexer,
    features: *WabtFeatures,
    errors: *WabtErrors,
) *WabtParseWatResult;
extern fn wabt_parse_wast(
    lexer: *WabtWastLexer,
    features: *WabtFeatures,
    errors: *WabtErrors,
) *WabtParseWastResult;
extern fn wabt_read_binary(
    data: [*:0]const u8,
    size: usize,
    read_debug_names: c_int,
    features: *WabtFeatures,
    errors: *WabtErrors,
) *WabtReadBinaryResult;
extern fn wabt_validate_module(
    module: *WabtModule,
    features: *WabtFeatures,
    errors: *WabtErrors,
) void;
extern fn wabt_validate_script(
    script: *WabtScript,
    features: *WabtFeatures,
    errors: *WabtErrors,
) void;
extern fn wabt_write_binary_spec_script(script: *WabtScript, source_filename: [*:0]const u8, out_filename: [*:0]const u8, log: c_int, canonicalize_lebs: c_int, relocatable: c_int, write_debug_names: c_int) *WabtWriteScriptResult;
extern fn wabt_apply_names_module(module: *WabtModule) WabtResultEnum;
extern fn wabt_generate_names_module(module: *WabtModule) WabtResultEnum;
extern fn wabt_write_binary_module(module: *WabtModule, log: c_int, canonicalize_lebs: c_int, relocatable: c_int, write_debug_names: c_int) *WabtWriteModuleResult;
extern fn wabt_write_text_module(module: *WabtModule, fold_exprs: c_int, inline_export: c_int) *WabtWriteModuleResult;
extern fn wabt_destroy_module(module: *WabtModule) void;
extern fn wabt_destroy_wast_lexer(lexer: *WabtWastLexer) void;
// WabtErrors
extern fn wabt_new_errors() *WabtErrors;
extern fn wabt_format_text_errors(errors: *WabtErrors, lexer: *WabtWastLexer) *WabtOutputBuffer;
extern fn wabt_format_binary_errors(errors: *WabtErrors) *WabtOutputBuffer;
extern fn wabt_destroy_errors(errors: *WabtErrors) void;
// WabtParseWatResult
extern fn wabt_parse_wat_result_get_result(result: *WabtParseWatResult) WabtResultEnum;
extern fn wabt_parse_wat_result_release_module(result: *WabtParseWatResult) *WabtModule;
extern fn wabt_destroy_parse_wat_result(result: *WabtParseWatResult) void;
// WabtParseWastResult
extern fn wabt_parse_wast_result_get_result(result: *WabtParseWastResult) WabtResultEnum;
extern fn wabt_parse_wast_result_release_module(result: *WabtParseWastResult) *WabtModule;
extern fn wabt_destroy_parse_wast_result(result: *WabtParseWastResult) void;
// WabtReadBinaryResult
extern fn wabt_read_binary_result_get_result(result: *WabtReadBinaryResult) WabtResultEnum;
extern fn wabt_read_binary_result_release_module(result: *WabtReadBinaryResult) *WabtModule;
extern fn wabt_destroy_read_binary_result(result: *WabtReadBinaryResult) void;
// WabtWriteWabtModuleResult
extern fn wabt_write_module_result_get_result(result: *WabtWriteModuleResult) WabtResultEnum;
extern fn wabt_write_module_result_release_output_buffer(result: *WabtWriteModuleResult) *WabtOutputBuffer;
extern fn wabt_write_module_result_release_log_output_buffer(result: *WabtWriteModuleResult) *WabtOutputBuffer;
extern fn wabt_destroy_write_module_result(result: *WabtWriteModuleResult) void;
// WabtWriteScriptResult
extern fn wabt_write_script_result_get_result(result: *WabtWriteScriptResult) WabtResultEnum;
extern fn wabt_write_script_result_release_json_output_buffer(result: *WabtWriteScriptResult) *WabtOutputBuffer;
extern fn wabt_write_script_result_release_log_output_buffer(result: *WabtWriteScriptResult) *WabtOutputBuffer;
extern fn wabt_write_script_result_get_module_count(result: *WabtWriteScriptResult) usize;
extern fn wabt_write_script_result_get_module_filename(result: *WabtWriteScriptResult, index: usize) [*:0]const u8;
extern fn wabt_write_script_result_release_module_output_buffer(result: *WabtWriteScriptResult, index: usize) *WabtOutputBuffer;
extern fn wabt_destroy_write_script_result(result: *WabtWriteScriptResult) void;
// WabtOutputBuffer
extern fn wabt_output_buffer_get_data(buffer: *WabtOutputBuffer) [*:0]const u8;
extern fn wabt_output_buffer_get_size(buffer: *WabtOutputBuffer) usize;
extern fn wabt_destroy_output_buffer(buffer: *WabtOutputBuffer) void;

test "read binary" {
    const binary = [8:0]u8{
        // magic
        0x00, 0x61, 0x73, 0x6D,
        // version
        0x01, 0x00, 0x00, 0x00,
    };

    const features = wabt_new_features();
    defer wabt_destroy_features(features);

    const errors = wabt_new_errors();
    defer wabt_destroy_errors(errors);

    const read_binary_result = wabt_read_binary(binary[0..], binary.len, 0, features, errors);
    defer wabt_destroy_read_binary_result(read_binary_result);

    const read_biary_result_enum = wabt_read_binary_result_get_result(read_binary_result);
    try std.testing.expect(read_biary_result_enum == WabtResultEnum.Ok);

    const module = wabt_read_binary_result_release_module(read_binary_result);
    defer wabt_destroy_module(module);

    const write_text_module = wabt_write_text_module(module, 0, 0);
    defer wabt_destroy_write_module_result(write_text_module);

    const write_text_module_result_enum = wabt_write_module_result_get_result(write_text_module);
    try std.testing.expect(write_text_module_result_enum == WabtResultEnum.Ok);

    const output_buffer = wabt_write_module_result_release_output_buffer(write_text_module);
    defer wabt_destroy_output_buffer(output_buffer);

    const output_ptr = wabt_output_buffer_get_data(output_buffer);
    const output_len = wabt_output_buffer_get_size(output_buffer);
    // exclude null string from output_ptr
    try std.testing.expectEqualSlices(u8, output_ptr[0 .. output_len - 1], "(module)");
}

test "read wat" {
    const wat = "(module)";
    const wat_len = wat.len;

    const features = wabt_new_features();
    defer wabt_destroy_features(features);

    const errors = wabt_new_errors();
    defer wabt_destroy_errors(errors);

    const wast_lexer = wabt_new_wast_buffer_lexer("test.wat", wat[0..], wat_len, errors);
    defer wabt_destroy_wast_lexer(wast_lexer);

    const parse_wat_result = wabt_parse_wat(wast_lexer, features, errors);
    defer wabt_destroy_parse_wat_result(parse_wat_result);

    const parse_wat_result_enum = wabt_parse_wat_result_get_result(parse_wat_result);
    try std.testing.expect(parse_wat_result_enum == WabtResultEnum.Ok);

    const module = wabt_parse_wat_result_release_module(parse_wat_result);
    defer wabt_destroy_module(module);

    const write_text_module = wabt_write_text_module(module, 0, 0);
    defer wabt_destroy_write_module_result(write_text_module);

    const write_text_module_result_enum = wabt_write_module_result_get_result(write_text_module);
    try std.testing.expect(write_text_module_result_enum == WabtResultEnum.Ok);

    const output_buffer = wabt_write_module_result_release_output_buffer(write_text_module);
    defer wabt_destroy_output_buffer(output_buffer);

    const output_ptr = wabt_output_buffer_get_data(output_buffer);
    const output_len = wabt_output_buffer_get_size(output_buffer);
    // exclude null string from output_ptr
    try std.testing.expectEqualSlices(u8, output_ptr[0 .. output_len - 1], "(module)");
}
