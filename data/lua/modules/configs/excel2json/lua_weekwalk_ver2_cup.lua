module("modules.configs.excel2json.lua_weekwalk_ver2_cup", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	fightType = 3,
	layerId = 2,
	progressDesc = 10,
	desc1 = 6,
	paramOfProgressDesc = 11,
	cupNo = 4,
	desc = 9,
	desc2 = 7,
	id = 1,
	cupTask = 5,
	desc3 = 8
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc3 = 3,
	desc2 = 2,
	progressDesc = 5,
	desc1 = 1,
	desc = 4
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
