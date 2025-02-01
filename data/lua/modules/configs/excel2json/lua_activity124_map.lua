module("modules.configs.excel2json.lua_activity124_map", package.seeall)

slot1 = {
	objects = 7,
	height = 4,
	tilebase = 6,
	audioAmbient = 5,
	id = 2,
	activityId = 1,
	width = 3,
	desc = 8
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {
	desc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
