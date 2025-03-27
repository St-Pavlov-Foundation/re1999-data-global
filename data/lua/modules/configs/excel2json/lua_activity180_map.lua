module("modules.configs.excel2json.lua_activity180_map", package.seeall)

slot1 = {
	activityId = 1,
	id = 2
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
