module("modules.configs.excel2json.lua_teamchess_enemy", package.seeall)

slot1 = {
	name = 2,
	passiveSkillIds = 7,
	specialAttr1 = 9,
	behaviorId = 8,
	specialAttr2 = 10,
	headImg = 4,
	specialAttr3 = 11,
	specialAttr5 = 13,
	specialAttr4 = 12,
	hp = 3,
	id = 1,
	skillIcon = 5,
	skillDesc = 6
}
slot2 = {
	"id"
}
slot3 = {
	skillDesc = 2,
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
