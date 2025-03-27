module("modules.configs.excel2json.lua_activity178_score", package.seeall)

slot1 = {
	value = 3,
	showTxt = 4,
	activityId = 1,
	level = 2
}
slot2 = {
	"activityId",
	"level"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
