module("modules.configs.excel2json.lua_tower_talent_plan", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	bossId = 1,
	talentIds = 3,
	planId = 2,
	planName = 4
}
local var_0_2 = {
	"bossId",
	"planId"
}
local var_0_3 = {
	planName = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
