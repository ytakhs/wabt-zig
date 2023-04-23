const std = @import("std");

const Features = extern struct {};

extern fn wabt_new_features() *Features;
extern fn wabt_destroy_features(features: *Features) void;

test {
    const f = wabt_new_features();
    defer wabt_destroy_features(f);
}
