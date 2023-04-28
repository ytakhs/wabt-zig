const std = @import("std");
const bindings = @import("./wabt_bindings.zig");

pub const Features = @This();

raw: *bindings.WabtFeatures,

pub fn init() Features {
    return .{
        .raw = bindings.wabt_new_features(),
    };
}

pub fn deinit(self: *Features) void {
    bindings.wabt_destroy_features(self.raw);
}

fn bool2CInt(b: bool) c_int {
    return if (b) 1 else 0;
}

pub fn getExceptionsEnabled(self: *Features) bool {
    return bindings.wabt_exceptions_enabled(self.raw);
}

pub fn setExceptionsEnabled(self: *Features, enabled: bool) void {
    bindings.wabt_set_exceptions_enabled(self.raw, bool2CInt(enabled));
}

test "exceptions" {
    var f = Features.init();
    defer f.deinit();

    const v = f.getExceptionsEnabled();
    f.setExceptionsEnabled(!v);
    try std.testing.expect(f.getExceptionsEnabled() == !v);
}

pub fn getMutableGlobalsEnabled(self: *Features) bool {
    return bindings.wabt_mutable_globals_enabled(self.raw);
}

pub fn setMutableGlobalsEnabled(self: *Features, enabled: bool) void {
    bindings.wabt_set_mutable_globals_enabled(self.raw, bool2CInt(enabled));
}

test "mutable-globals" {
    var f = Features.init();
    defer f.deinit();

    const v = f.getMutableGlobalsEnabled();
    f.setMutableGlobalsEnabled(!v);
    try std.testing.expect(f.getMutableGlobalsEnabled() == !v);
}

pub fn getSatFloatToIntEnabled(self: *Features) bool {
    return bindings.wabt_sat_float_to_int_enabled(self.raw);
}

pub fn setSatFloatToIntEnabled(self: *Features, enabled: bool) void {
    bindings.wabt_set_sat_float_to_int_enabled(self.raw, bool2CInt(enabled));
}

test "sat-float-to-int" {
    var f = Features.init();
    defer f.deinit();

    const v = f.getSatFloatToIntEnabled();
    f.setSatFloatToIntEnabled(!v);
    try std.testing.expect(f.getSatFloatToIntEnabled() == !v);
}

pub fn getSignExtensionEnabled(self: *Features) bool {
    return bindings.wabt_sign_extension_enabled(self.raw);
}

pub fn setSignExtensionEnabled(self: *Features, enabled: bool) void {
    bindings.wabt_set_sign_extension_enabled(self.raw, bool2CInt(enabled));
}

test "sign-extension" {
    var f = Features.init();
    defer f.deinit();

    const v = f.getSignExtensionEnabled();
    f.setSignExtensionEnabled(!v);
    try std.testing.expect(f.getSignExtensionEnabled() == !v);
}

pub fn getSIMDEnabled(self: *Features) bool {
    return bindings.wabt_simd_enabled(self.raw);
}

pub fn setSIMDEnabled(self: *Features, enabled: bool) void {
    bindings.wabt_set_simd_enabled(self.raw, bool2CInt(enabled));
}

test "simd" {
    var f = Features.init();
    defer f.deinit();

    const v = f.getSIMDEnabled();
    f.setSIMDEnabled(!v);
    try std.testing.expect(f.getSIMDEnabled() == !v);
}

pub fn getThreadsEnabled(self: *Features) bool {
    return bindings.wabt_threads_enabled(self.raw);
}

pub fn setThreadsEnabled(self: *Features, enabled: bool) void {
    bindings.wabt_set_threads_enabled(self.raw, bool2CInt(enabled));
}

test "threads" {
    var f = Features.init();
    defer f.deinit();

    const v = f.getThreadsEnabled();
    f.setThreadsEnabled(!v);
    try std.testing.expect(f.getThreadsEnabled() == !v);
}

pub fn getFunctionReferencesEnabled(self: *Features) bool {
    return bindings.wabt_function_references_enabled(self.raw);
}

pub fn setFunctionReferencesEnabled(self: *Features, enabled: bool) void {
    bindings.wabt_set_function_references_enabled(self.raw, bool2CInt(enabled));
}

test "function-references" {
    var f = Features.init();
    defer f.deinit();

    const v = f.getFunctionReferencesEnabled();
    f.setFunctionReferencesEnabled(!v);
    try std.testing.expect(f.getFunctionReferencesEnabled() == !v);
}

pub fn getMultiValueEnabled(self: *Features) bool {
    return bindings.wabt_multi_value_enabled(self.raw);
}

pub fn setMultiValueEnabled(self: *Features, enabled: bool) void {
    bindings.wabt_set_multi_value_enabled(self.raw, bool2CInt(enabled));
}

test "multi-value" {
    var f = Features.init();
    defer f.deinit();

    const v = f.getMultiValueEnabled();
    f.setMultiValueEnabled(!v);
    try std.testing.expect(f.getMultiValueEnabled() == !v);
}

pub fn getTailCallEnabled(self: *Features) bool {
    return bindings.wabt_tail_call_enabled(self.raw);
}

pub fn setTailCallEnabled(self: *Features, enabled: bool) void {
    bindings.wabt_set_tail_call_enabled(self.raw, bool2CInt(enabled));
}

test "tail-call" {
    var f = Features.init();
    defer f.deinit();

    const v = f.getTailCallEnabled();
    f.setTailCallEnabled(!v);
    try std.testing.expect(f.getTailCallEnabled() == !v);
}

pub fn getBulkMemoryEnabled(self: *Features) bool {
    return bindings.wabt_bulk_memory_enabled(self.raw);
}

pub fn setBulkMemoryEnabled(self: *Features, enabled: bool) void {
    bindings.wabt_set_bulk_memory_enabled(self.raw, bool2CInt(enabled));
}

test "bulk-memory" {
    var f = Features.init();
    defer f.deinit();

    const v = f.getBulkMemoryEnabled();
    f.setBulkMemoryEnabled(!v);
    try std.testing.expect(f.getBulkMemoryEnabled() == !v);
}

pub fn getReferenceTypesEnabled(self: *Features) bool {
    return bindings.wabt_reference_types_enabled(self.raw);
}

pub fn setReferenceTypesEnabled(self: *Features, enabled: bool) void {
    bindings.wabt_set_reference_types_enabled(self.raw, bool2CInt(enabled));
}

test "reference-types" {
    var f = Features.init();
    defer f.deinit();

    const v = f.getReferenceTypesEnabled();
    f.setReferenceTypesEnabled(!v);
    try std.testing.expect(f.getReferenceTypesEnabled() == !v);
}

pub fn getAnnotationsEnabled(self: *Features) bool {
    return bindings.wabt_annotations_enabled(self.raw);
}

pub fn setAnnotationsEnabled(self: *Features, enabled: bool) void {
    bindings.wabt_set_annotations_enabled(self.raw, bool2CInt(enabled));
}

test "annotations" {
    var f = Features.init();
    defer f.deinit();

    const v = f.getAnnotationsEnabled();
    f.setAnnotationsEnabled(!v);
    try std.testing.expect(f.getAnnotationsEnabled() == !v);
}

pub fn getCodeMetadataEnabled(self: *Features) bool {
    return bindings.wabt_code_metadata_enabled(self.raw);
}

pub fn setCodeMetadataEnabled(self: *Features, enabled: bool) void {
    bindings.wabt_set_code_metadata_enabled(self.raw, bool2CInt(enabled));
}

test "code-metadata" {
    var f = Features.init();
    defer f.deinit();

    const v = f.getCodeMetadataEnabled();
    f.setCodeMetadataEnabled(!v);
    try std.testing.expect(f.getCodeMetadataEnabled() == !v);
}

pub fn getGCEnabled(self: *Features) bool {
    return bindings.wabt_gc_enabled(self.raw);
}

pub fn setGCEnabled(self: *Features, enabled: bool) void {
    bindings.wabt_set_gc_enabled(self.raw, bool2CInt(enabled));
}

test "gc" {
    var f = Features.init();
    defer f.deinit();

    const v = f.getGCEnabled();
    f.setGCEnabled(!v);
    try std.testing.expect(f.getGCEnabled() == !v);
}

pub fn getMemory64Enabled(self: *Features) bool {
    return bindings.wabt_memory64_enabled(self.raw);
}

pub fn setMemory64Enabled(self: *Features, enabled: bool) void {
    bindings.wabt_set_memory64_enabled(self.raw, bool2CInt(enabled));
}

test "memory64" {
    var f = Features.init();
    defer f.deinit();

    const v = f.getMemory64Enabled();
    f.setMemory64Enabled(!v);
    try std.testing.expect(f.getMemory64Enabled() == !v);
}

pub fn getMultiMemoryEnabled(self: *Features) bool {
    return bindings.wabt_multi_memory_enabled(self.raw);
}

pub fn setMultiMemoryEnabled(self: *Features, enabled: bool) void {
    bindings.wabt_set_multi_memory_enabled(self.raw, bool2CInt(enabled));
}

test "multi-memory" {
    var f = Features.init();
    defer f.deinit();

    const v = f.getMultiMemoryEnabled();
    f.setMultiMemoryEnabled(!v);
    try std.testing.expect(f.getMultiMemoryEnabled() == !v);
}

pub fn getExtendedConstEnabled(self: *Features) bool {
    return bindings.wabt_extended_const_enabled(self.raw);
}

pub fn setExtendedConstEnabled(self: *Features, enabled: bool) void {
    bindings.wabt_set_extended_const_enabled(self.raw, bool2CInt(enabled));
}

test "extended-const" {
    var f = Features.init();
    defer f.deinit();

    const v = f.getExtendedConstEnabled();
    f.setExtendedConstEnabled(!v);
    try std.testing.expect(f.getExtendedConstEnabled() == !v);
}

pub fn getRelaxedSimdEnabled(self: *Features) bool {
    return bindings.wabt_relaxed_simd_enabled(self.raw);
}

pub fn setRelaxedSimdEnabled(self: *Features, enabled: bool) void {
    bindings.wabt_set_relaxed_simd_enabled(self.raw, bool2CInt(enabled));
}

test "relaxed-simd" {
    var f = Features.init();
    defer f.deinit();

    const v = f.getRelaxedSimdEnabled();
    f.setRelaxedSimdEnabled(!v);
    try std.testing.expect(f.getRelaxedSimdEnabled() == !v);
}
