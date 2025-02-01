module("modules.configs.excel2json.lua_trigger", package.seeall)

slot1 = {
	id = 1,
	param2 = 8,
	param4 = 10,
	param1 = 7,
	param8 = 14,
	limitOneTurn = 6,
	limit = 5,
	param7 = 13,
	triggerType = 3,
	param6 = 12,
	param10 = 16,
	param5 = 11,
	battleId = 2,
	actionList = 4,
	param9 = 15,
	param3 = 9
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
