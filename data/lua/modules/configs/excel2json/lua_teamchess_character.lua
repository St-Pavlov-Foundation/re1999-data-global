module("modules.configs.excel2json.lua_teamchess_character", package.seeall)

slot1 = {
	activeSkillIds = 8,
	name = 2,
	id = 1,
	specialAttr1 = 10,
	specialAttr2 = 11,
	initPower = 4,
	passiveSkillIds = 9,
	specialAttr3 = 12,
	specialAttr4 = 13,
	hp = 3,
	resPic = 7,
	maxPowerLimit = 6,
	initDiamonds = 5,
	specialAttr5 = 14
}
slot2 = {
	"id"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
