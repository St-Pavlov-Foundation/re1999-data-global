module("modules.configs.excel2json.lua_activity_nuodika_180_skill", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	param = 3,
	effect = 2,
	scale = 5,
	skillId = 1,
	trigger = 4
}
local var_0_2 = {
	"skillId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
