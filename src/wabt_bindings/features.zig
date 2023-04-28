pub const WabtFeatures = extern struct {};

pub extern fn wabt_new_features() *WabtFeatures;
pub extern fn wabt_destroy_features(features: *WabtFeatures) void;

pub extern fn wabt_exceptions_enabled(features: *WabtFeatures) bool;
pub extern fn wabt_set_exceptions_enabled(features: *WabtFeatures, enabled: c_int) void;
test "excetions_enabled" {
    const features = wabt_new_features();
    defer wabt_destroy_features(features);

    _ = wabt_exceptions_enabled(features);
    wabt_set_exceptions_enabled(features, 0);
}

pub extern fn wabt_mutable_globals_enabled(features: *WabtFeatures) bool;
pub extern fn wabt_set_mutable_globals_enabled(features: *WabtFeatures, enabled: c_int) void;
test "mutable_globals_enabled" {
    const features = wabt_new_features();
    defer wabt_destroy_features(features);

    _ = wabt_mutable_globals_enabled(features);
    wabt_set_mutable_globals_enabled(features, 0);
}

pub extern fn wabt_sat_float_to_int_enabled(features: *WabtFeatures) bool;
pub extern fn wabt_set_sat_float_to_int_enabled(features: *WabtFeatures, enabled: c_int) void;
test "sat_float_to_int_enabled" {
    const features = wabt_new_features();
    defer wabt_destroy_features(features);

    _ = wabt_sat_float_to_int_enabled(features);
    wabt_set_sat_float_to_int_enabled(features, 0);
}

pub extern fn wabt_sign_extension_enabled(features: *WabtFeatures) bool;
pub extern fn wabt_set_sign_extension_enabled(features: *WabtFeatures, enabled: c_int) void;
test "sign_extension_enabled" {
    const features = wabt_new_features();
    defer wabt_destroy_features(features);

    _ = wabt_sign_extension_enabled(features);
    wabt_set_sign_extension_enabled(features, 0);
}

pub extern fn wabt_simd_enabled(features: *WabtFeatures) bool;
pub extern fn wabt_set_simd_enabled(features: *WabtFeatures, enabled: c_int) void;
test "simd_enabled" {
    const features = wabt_new_features();
    defer wabt_destroy_features(features);

    _ = wabt_simd_enabled(features);
    wabt_set_simd_enabled(features, 0);
}

pub extern fn wabt_threads_enabled(features: *WabtFeatures) bool;
pub extern fn wabt_set_threads_enabled(features: *WabtFeatures, enabled: c_int) void;
test "threads_enabled" {
    const features = wabt_new_features();
    defer wabt_destroy_features(features);

    _ = wabt_threads_enabled(features);
    wabt_set_threads_enabled(features, 0);
}

pub extern fn wabt_function_references_enabled(features: *WabtFeatures) bool;
pub extern fn wabt_set_function_references_enabled(features: *WabtFeatures, enabled: c_int) void;
test "function_references_enabled" {
    const features = wabt_new_features();
    defer wabt_destroy_features(features);

    _ = wabt_function_references_enabled(features);
    wabt_set_function_references_enabled(features, 0);
}

pub extern fn wabt_multi_value_enabled(features: *WabtFeatures) bool;
pub extern fn wabt_set_multi_value_enabled(features: *WabtFeatures, enabled: c_int) void;
test "multi_value_enabled" {
    const features = wabt_new_features();
    defer wabt_destroy_features(features);

    _ = wabt_multi_value_enabled(features);
    wabt_set_multi_value_enabled(features, 0);
}

pub extern fn wabt_tail_call_enabled(features: *WabtFeatures) bool;
pub extern fn wabt_set_tail_call_enabled(features: *WabtFeatures, enabled: c_int) void;
test "tail_call_enabled" {
    const features = wabt_new_features();
    defer wabt_destroy_features(features);

    _ = wabt_tail_call_enabled(features);
    wabt_set_tail_call_enabled(features, 0);
}

pub extern fn wabt_bulk_memory_enabled(features: *WabtFeatures) bool;
pub extern fn wabt_set_bulk_memory_enabled(features: *WabtFeatures, enabled: c_int) void;
test "bulk_memory_enabled" {
    const features = wabt_new_features();
    defer wabt_destroy_features(features);

    _ = wabt_bulk_memory_enabled(features);
    wabt_set_bulk_memory_enabled(features, 0);
}

pub extern fn wabt_reference_types_enabled(features: *WabtFeatures) bool;
pub extern fn wabt_set_reference_types_enabled(features: *WabtFeatures, enabled: c_int) void;
test "reference_types_enabled" {
    const features = wabt_new_features();
    defer wabt_destroy_features(features);

    _ = wabt_reference_types_enabled(features);
    wabt_set_reference_types_enabled(features, 0);
}

pub extern fn wabt_annotations_enabled(features: *WabtFeatures) bool;
pub extern fn wabt_set_annotations_enabled(features: *WabtFeatures, enabled: c_int) void;
test "annotations_enabled" {
    const features = wabt_new_features();
    defer wabt_destroy_features(features);

    _ = wabt_annotations_enabled(features);
    wabt_set_annotations_enabled(features, 0);
}

pub extern fn wabt_code_metadata_enabled(features: *WabtFeatures) bool;
pub extern fn wabt_set_code_metadata_enabled(features: *WabtFeatures, enabled: c_int) void;
test "code_metadata_enabled" {
    const features = wabt_new_features();
    defer wabt_destroy_features(features);

    _ = wabt_code_metadata_enabled(features);
    wabt_set_code_metadata_enabled(features, 0);
}

pub extern fn wabt_gc_enabled(features: *WabtFeatures) bool;
pub extern fn wabt_set_gc_enabled(features: *WabtFeatures, enabled: c_int) void;
test "gc_enabled" {
    const features = wabt_new_features();
    defer wabt_destroy_features(features);

    _ = wabt_gc_enabled(features);
    wabt_set_gc_enabled(features, 0);
}

pub extern fn wabt_memory64_enabled(features: *WabtFeatures) bool;
pub extern fn wabt_set_memory64_enabled(features: *WabtFeatures, enabled: c_int) void;
test "memory64_enabled" {
    const features = wabt_new_features();
    defer wabt_destroy_features(features);

    _ = wabt_memory64_enabled(features);
    wabt_set_memory64_enabled(features, 0);
}

pub extern fn wabt_multi_memory_enabled(features: *WabtFeatures) bool;
pub extern fn wabt_set_multi_memory_enabled(features: *WabtFeatures, enabled: c_int) void;
test "multi_memory_enabled" {
    const features = wabt_new_features();
    defer wabt_destroy_features(features);

    _ = wabt_multi_memory_enabled(features);
    wabt_set_multi_memory_enabled(features, 0);
}

pub extern fn wabt_extended_const_enabled(features: *WabtFeatures) bool;
pub extern fn wabt_set_extended_const_enabled(features: *WabtFeatures, enabled: c_int) void;
test "extended_const_enabled" {
    const features = wabt_new_features();
    defer wabt_destroy_features(features);

    _ = wabt_extended_const_enabled(features);
    wabt_set_extended_const_enabled(features, 0);
}

pub extern fn wabt_relaxed_simd_enabled(features: *WabtFeatures) bool;
pub extern fn wabt_set_relaxed_simd_enabled(features: *WabtFeatures, enabled: c_int) void;
test "relaxed_simd_enabled" {
    const features = wabt_new_features();
    defer wabt_destroy_features(features);

    _ = wabt_relaxed_simd_enabled(features);
    wabt_set_relaxed_simd_enabled(features, 0);
}
