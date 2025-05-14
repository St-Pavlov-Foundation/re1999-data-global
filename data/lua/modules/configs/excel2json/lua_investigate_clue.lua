module("modules.configs.excel2json.lua_investigate_clue", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	mapRes = 5,
	relatedDesc = 9,
	infoID = 4,
	res = 6,
	mapElement = 3,
	id = 1,
	mapResLocked = 7,
	detailedDesc = 8,
	defaultUnlock = 2
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	detailedDesc = 1,
	relatedDesc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
