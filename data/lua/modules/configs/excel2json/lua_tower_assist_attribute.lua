module("modules.configs.excel2json.lua_tower_assist_attribute", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	bossId = 1,
	criDmg = 5,
	hp = 6,
	cri = 4,
	attack = 3,
	teamLevel = 2
}
local var_0_2 = {
	"bossId",
	"teamLevel"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
