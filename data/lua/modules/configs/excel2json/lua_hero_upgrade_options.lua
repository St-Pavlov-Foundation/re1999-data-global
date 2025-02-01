module("modules.configs.excel2json.lua_hero_upgrade_options", package.seeall)

slot1 = {
	unlockCondition = 2,
	addBuff = 11,
	replaceBigSkill = 8,
	replaceSkillGroup1 = 6,
	delBuff = 12,
	title = 3,
	desc = 4,
	replaceSkillGroup2 = 7,
	id = 1,
	addPassiveSkill = 10,
	showSkillId = 5,
	replacePassiveSkill = 9
}
slot2 = {
	"id"
}
slot3 = {
	desc = 2,
	title = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
