module("modules.configs.excel2json.lua_auto_chess_master", package.seeall)

slot1 = {
	roundTriggerCountLimit = 8,
	name = 2,
	unlockSkill = 6,
	isSelf = 3,
	skillIcon = 11,
	image = 5,
	skillProgressDesc = 13,
	totalTriggerCountLimit = 9,
	hp = 4,
	skillId = 7,
	id = 1,
	skillName = 10,
	skillDesc = 12,
	skillLockDesc = 14
}
slot2 = {
	"id"
}
slot3 = {
	name = 1,
	skillProgressDesc = 4,
	skillName = 2,
	skillDesc = 3,
	skillLockDesc = 5
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
