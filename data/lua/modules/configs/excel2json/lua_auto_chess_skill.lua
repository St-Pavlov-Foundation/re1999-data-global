module("modules.configs.excel2json.lua_auto_chess_skill", package.seeall)

slot1 = {
	effect1 = 6,
	triggerPoint1 = 5,
	totalTriggerLimit1 = 8,
	totalTriggerLimit3 = 18,
	effect3 = 16,
	triggerPoint2 = 10,
	roundTriggerLimit1 = 7,
	condition3 = 14,
	skillaction = 19,
	skilleffID = 21,
	useeffect = 20,
	tag = 2,
	condition2 = 9,
	effect2 = 11,
	triggerPoint3 = 15,
	roundTriggerLimit2 = 12,
	countdown = 3,
	totalTriggerLimit2 = 13,
	roundTriggerLimit3 = 17,
	condition1 = 4,
	id = 1,
	downline = 22
}
slot2 = {
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
