module("modules.configs.excel2json.lua_activity157_repair_map", package.seeall)

slot1 = {
	componentId = 2,
	height = 5,
	titleTip = 3,
	activityId = 1,
	tilebase = 6,
	objects = 7,
	width = 4,
	desc = 8
}
slot2 = {
	"activityId",
	"componentId"
}
slot3 = {
	titleTip = 1,
	desc = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
