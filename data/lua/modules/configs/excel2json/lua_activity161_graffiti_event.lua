module("modules.configs.excel2json.lua_activity161_graffiti_event", package.seeall)

slot1 = {
	elementId = 2,
	cd = 3,
	activityId = 1
}
slot2 = {
	"activityId",
	"elementId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
