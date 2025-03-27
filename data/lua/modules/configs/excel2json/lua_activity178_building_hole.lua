module("modules.configs.excel2json.lua_activity178_building_hole", package.seeall)

slot1 = {
	activityId = 1,
	condition = 5,
	index = 2,
	size = 4,
	pos = 3
}
slot2 = {
	"activityId",
	"index"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
