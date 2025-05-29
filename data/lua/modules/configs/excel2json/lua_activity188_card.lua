module("modules.configs.excel2json.lua_activity188_card", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	cardId = 2,
	name = 5,
	skillId = 4,
	type = 3,
	resource = 7,
	activityId = 1,
	desc = 6
}
local var_0_2 = {
	"activityId",
	"cardId"
}
local var_0_3 = {
	desc = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
