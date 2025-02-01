module("modules.configs.excel2json.lua_activity120_map", package.seeall)

slot1 = {
	bgPath = 6,
	height = 4,
	activityId = 1,
	objects = 10,
	offset = 8,
	audioAmbient = 5,
	tilebase = 9,
	groundItems = 7,
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
