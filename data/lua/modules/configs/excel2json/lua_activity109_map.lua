module("modules.configs.excel2json.lua_activity109_map", package.seeall)

slot1 = {
	bgPath = 6,
	height = 4,
	activityId = 1,
	objects = 9,
	offset = 7,
	audioAmbient = 5,
	tilebase = 8,
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
