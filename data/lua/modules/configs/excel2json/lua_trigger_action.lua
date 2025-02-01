module("modules.configs.excel2json.lua_trigger_action", package.seeall)

slot1 = {
	param15 = 17,
	param1 = 3,
	actionType = 2,
	param12 = 14,
	param8 = 10,
	param6 = 8,
	param5 = 7,
	param2 = 4,
	param14 = 16,
	param13 = 15,
	param9 = 11,
	param7 = 9,
	param11 = 13,
	param10 = 12,
	id = 1,
	param4 = 6,
	param3 = 5
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
