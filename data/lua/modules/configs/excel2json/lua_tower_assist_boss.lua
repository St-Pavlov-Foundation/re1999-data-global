module("modules.configs.excel2json.lua_tower_assist_boss", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	bossId = 1,
	teachSkills = 13,
	heartVariantId = 9,
	skinId = 5,
	name = 3,
	gender = 6,
	career = 4,
	passiveSkills = 12,
	bossPic = 17,
	bossDesc = 19,
	dmgType = 7,
	tag = 8,
	coldTime = 10,
	resMaxVal = 16,
	bossShadowPic = 18,
	resInitVal = 15,
	towerId = 2,
	activeSkills = 11,
	passiveSkillName = 14
}
local var_0_2 = {
	"bossId"
}
local var_0_3 = {
	tag = 2,
	name = 1,
	passiveSkillName = 3,
	bossDesc = 4
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
