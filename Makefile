
default::
	@echo 'Try `make test` or `make release`.' && exit 2


test::
	@cd test && ./main.lua


wamdir?=$(HOME)/src/wesnoth-tools

release: test
	@./scripts/release.zsh 8680s_Lua_Pack 1.10.x $(wamdir)
	@./scripts/release.zsh 8680s_Lua_Pack 1.11.x $(wamdir)
