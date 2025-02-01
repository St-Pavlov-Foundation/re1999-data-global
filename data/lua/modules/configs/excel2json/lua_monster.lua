module("modules.configs.excel2json.lua_monster", package.seeall)

slot1 = {
	heartVariantId = 7,
	highPriorityName = 18,
	levelEasy = 22,
	uniqueSkillLevel = 10,
	skillTemplate = 3,
	initial_uniqueSkill_point = 9,
	career = 6,
	label = 5,
	highPriorityNameEng = 19,
	highPriorityDes = 20,
	hpSign = 14,
	templateEasy = 21,
	effectHangPoint = 17,
	skinId = 4,
	level = 8,
	effect = 16,
	passiveSkillsEx = 12,
	energySign = 15,
	uiFilterSkill = 13,
	passiveSkillCount = 11,
	template = 2,
	id = 1
}
slot2 = {
	"id"
}
slot3 = {
	highPriorityDes = 2,
	highPriorityName = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
