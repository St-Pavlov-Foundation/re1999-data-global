module("modules.configs.excel2json.lua_character_skill", package.seeall)

slot1 = {
	triggerPoint = 8,
	name = 2,
	cost = 7,
	condition = 9,
	effect = 10,
	roundTriggerCountLimit = 11,
	skillPrompt = 4,
	desc = 3,
	totalTriggerCountLimit = 12,
	id = 1,
	icon = 5,
	active = 6
}
slot2 = {
	"id"
}
slot3 = {
	name = 1,
	skillPrompt = 3,
	desc = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
