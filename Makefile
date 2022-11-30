# 编辑脚本
# 全局参数
EBIN_OUTDIR := ebin

###===================================================================

compile:rebar_compile

### use this
all_rebuild:get-deps clean build

build:dirs all_compile

all_compile:apps table compile  copy_deps

###===================================================================
quick_build: dirs all_compile

rebuild:quick_rebuild

quick_rebuild:clean quick_build

###===================================================================
### Internal functions
###===================================================================
clean:clean_beam clean-deps-beam
	(rm -rf *.dump)
	(rm -rf ebin/*.app)
	(rm -rf src/node/db_mysql/db_table/*)
	(rm -rf deps/*/ebin/*.app)
	(./rebar clean)

clean_beam:
	(rm -rf ebin/*.beam)

clean-deps-beam:
	(rm -rf deps/*/ebin/*.beam)

dirs:
	(mkdir -p data; mkdir -p $(EBIN_OUTDIR))
	(mkdir -p cvLoggerLogs; mkdir -p cvSaslLogs; mkdir -p etc)
	(mkdir -p deps; mkdir -p cvSelfLogs; mkdir -p var)

apps:
	(mkdir -p $(EBIN_OUTDIR))
	(cp -rf src/app/*.app $(EBIN_OUTDIR))


copy_deps:
	(mkdir -p $(EBIN_OUTDIR))
	(cp -rf deps/*/ebin/*.beam $(EBIN_OUTDIR))
	(cp -rf deps/*/ebin/*.app $(EBIN_OUTDIR))
	(rm -rf deps/*/ebin/*.beam)

table:
	(rm -fr ./src/node/db_mysql/db_table/*; chmod +x ./sql/gen_tab)
	(./sql/gen_tab ./sql/tab.conf ./include/common ./src/node/db_mysql/db_table)


###===================================================================
### Rebar2.X Func
###===================================================================

rebar_compile:
	(./rebar compile)

get-deps:
	(./rebar get-deps)

list-deps:
	(./rebar list-deps)

update-deps:
	(./rebar update-deps)

delete-deps:
	(./rebar delete-deps)




