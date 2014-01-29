
default::
	@echo 'Try `make test` or `make release`.' && exit 2


test::
	@cd test && ./main.lua


server?=1.11.x
wamdir?=$(HOME)/src/wesnoth-tools

release: test
	@./scripts/release.zsh 8680s_Lua_Pack $(server) $(wamdir)
