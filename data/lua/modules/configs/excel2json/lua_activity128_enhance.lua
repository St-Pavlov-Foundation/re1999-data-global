module("modules.configs.excel2json.lua_activity128_enhance", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	sort = 3,
	desc = 5,
	characterId = 2,
	activityId = 1,
	exchangeSkills = 4
}
local var_0_2 = {
	"activityId",
	"characterId"
}
local var_0_3 = {
	desc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
