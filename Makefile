
.PHONY: build
build: deps/wabt/out/clang/Release/include/config.h
	zig build

.PHONY: test
test: deps/wabt/out/clang/Release/include/config.h
	zig build test

deps/wabt/out/clang/Release/include/config.h: deps/wabt
	@cd deps/wabt && make clang-release
