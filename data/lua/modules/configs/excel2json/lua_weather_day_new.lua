module("modules.configs.excel2json.lua_weather_day_new", package.seeall)

slot1 = {
	id = 2,
	sceneId = 1,
	reportList = 3
}
slot2 = {
	"sceneId",
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
