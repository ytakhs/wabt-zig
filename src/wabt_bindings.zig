const std = @import("std");

const WabtFeatures = opaque {};
const WabtErrors = opaque {};
const WabtResultEnum = enum(c_int) {
    Ok,
    Error,
};
const WabtWastLexer = opaque {};
const WabtParseWatResult = opaque {};
const WabtParseWastResult = opaque {};
const WabtReadBinaryResult = opaque {};
const WabtModule = opaque {};
const WabtScript = opaque {};
const WabtWriteScriptResult = opaque {};
const WabtWriteModuleResult = opaque {};
const WabtOutputBuffer = opaque {};

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
) WabtParseWatResult;
extern fn wabt_parse_wast(
    lexer: *WabtWastLexer,
    features: *WabtFeatures,
    errors: *WabtErrors,
) WabtParseWastResult;
extern fn wabt_read_binary(
    data: [*:0]const u8,
    size: usize,
    read_debug_names: c_int,
    features: *WabtFeatures,
    errors: *WabtErrors,
) WabtReadBinaryResult;
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
extern fn wabt_write_binary_module(module: *WabtModule, log: c_int, canonicalize_lebs: c_int, relocatable: c_int, write_debug_names: c_int) WabtWriteModuleResult;
extern fn wabt_write_text_module(module: *WabtModule, fold_exprs: c_int, inline_export: c_int) WabtWriteModuleResult;
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

test {
    const f = wabt_new_features();
    defer wabt_destroy_features(f);
}
