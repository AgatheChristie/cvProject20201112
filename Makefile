# 编辑脚本
# 全局参数
EBIN_OUTDIR := ebin

compile: get-deps rebar_compile

all_compile:  rebar_compile copy_deps

rebar_compile:
	(./rebar compile)


clean_beam:
	(rm -rf ebin/*.beam)

#clean:clean_beam clean-deps-beam
#	(rm -rf *.dump)
#	(rm -rf ebin/*.app)
#	(rm -rf deps/*/ebin/*.app)
#	(./rebar clean)

get-deps:
	(./rebar get-deps)

list-deps:
	(./rebar list-deps)

update-deps:
	(./rebar update-deps)

delete-deps:
	(./rebar delete-deps)

#clean-deps-beam:
#	(rm -rf deps/*/ebin/*.beam)

copy_deps:
	(mkdir -p $(EBIN_OUTDIR))
	(cp -rf deps/*/ebin/*.beam $(EBIN_OUTDIR))
	(cp -rf deps/*/ebin/*.app $(EBIN_OUTDIR))








