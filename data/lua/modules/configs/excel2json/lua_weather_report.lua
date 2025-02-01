module("modules.configs.excel2json.lua_weather_report", package.seeall)

slot1 = {
	audioLength = 6,
	effect = 4,
	roomMode = 5,
	id = 1,
	lightMode = 2,
	roleMode = 3
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
