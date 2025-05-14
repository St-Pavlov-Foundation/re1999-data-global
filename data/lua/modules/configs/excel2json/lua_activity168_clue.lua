module("modules.configs.excel2json.lua_activity168_clue", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	infoID = 6,
	mapElement = 5,
	desc = 3,
	clueId = 1,
	related = 7,
	icon = 2,
	defaultUnlock = 4
}
local var_0_2 = {
	"clueId"
}
local var_0_3 = {
	desc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
