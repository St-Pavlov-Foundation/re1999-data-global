module("modules.configs.excel2json.lua_tower_assist_boss", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	bossId = 1,
	passiveSkills = 12,
	heartVariantId = 9,
	skinId = 5,
	name = 3,
	gender = 6,
	career = 4,
	passiveSkillName = 13,
	dmgType = 7,
	tag = 8,
	coldTime = 10,
	resMaxVal = 15,
	bossShadowPic = 17,
	resInitVal = 14,
	towerId = 2,
	activeSkills = 11,
	bossPic = 16
}
local var_0_2 = {
	"bossId"
}
local var_0_3 = {
	tag = 2,
	name = 1,
	passiveSkillName = 3
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
