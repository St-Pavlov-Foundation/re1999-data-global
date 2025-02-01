module("modules.configs.excel2json.lua_activity142_map", package.seeall)

slot1 = {
	bgPath = 7,
	height = 4,
	activityId = 1,
	objects = 11,
	offset = 9,
	defaultCharacterId = 5,
	audioAmbient = 6,
	tilebase = 10,
	groundItems = 8,
	id = 2,
	width = 3
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
