module("modules.configs.excel2json.lua_hero_trial", package.seeall)

slot1 = {
	exSkillLv = 7,
	act104EquipId2 = 13,
	attrId = 14,
	equipId = 9,
	equipRefine = 11,
	skin = 4,
	trialTemplate = 2,
	heroId = 3,
	trialType = 5,
	talent = 8,
	act104EquipId1 = 12,
	id = 1,
	equipLv = 10,
	level = 6
}
slot2 = {
	"id",
	"trialTemplate"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
