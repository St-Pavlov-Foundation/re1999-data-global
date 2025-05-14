module("modules.configs.excel2json.lua_activity144_equip", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	cost = 4,
	name = 8,
	buffId = 6,
	preEquipId = 3,
	typeId = 7,
	equipId = 2,
	effectDesc = 9,
	activityId = 1,
	level = 5
}
local var_0_2 = {
	"activityId",
	"equipId"
}
local var_0_3 = {
	effectDesc = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
