module("modules.configs.excel2json.lua_soldier_skill", package.seeall)

slot1 = {
	triggerPoint = 9,
	effect = 10,
	growUpTime = 6,
	type = 4,
	roundTriggerCountLimit = 11,
	condition = 8,
	skillDes = 3,
	totalTriggerCountLimit = 12,
	growUploop = 7,
	skillId = 1,
	skillName = 2,
	active = 5
}
slot2 = {
	"skillId"
}
slot3 = {
	skillDes = 2,
	skillName = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
