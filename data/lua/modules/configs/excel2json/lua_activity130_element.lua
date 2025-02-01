module("modules.configs.excel2json.lua_activity130_element", package.seeall)

slot1 = {
	param = 4,
	res = 6,
	elementId = 2,
	type = 3,
	activityId = 1,
	skipFinish = 5
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
