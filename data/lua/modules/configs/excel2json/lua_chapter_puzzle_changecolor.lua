module("modules.configs.excel2json.lua_chapter_puzzle_changecolor", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	interactbtns = 5,
	name = 2,
	colorsort = 6,
	id = 1,
	initColors = 3,
	finalColors = 4,
	bonus = 7
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	initColors = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
