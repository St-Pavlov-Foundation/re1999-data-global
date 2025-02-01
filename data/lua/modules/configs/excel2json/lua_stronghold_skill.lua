module("modules.configs.excel2json.lua_stronghold_skill", package.seeall)

slot1 = {
	triggerPoint = 3,
	effect = 4,
	roundTriggerCountLimit = 5,
	skillId = 1,
	totalTriggerCountLimit = 6,
	condition = 2
}
slot2 = {
	"skillId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
