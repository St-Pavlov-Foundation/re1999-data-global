module("modules.configs.excel2json.lua_tower_assist_boss_change", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	bossId = 1,
	activeSkills = 5,
	passiveSkills = 6,
	skinId = 3,
	form = 2,
	coldTime = 4,
	replacePassiveSkills = 7,
	resMaxVal = 8
}
local var_0_2 = {
	"bossId",
	"form"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
