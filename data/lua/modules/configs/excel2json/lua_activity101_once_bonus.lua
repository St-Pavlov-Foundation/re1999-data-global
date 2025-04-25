module("modules.configs.excel2json.lua_activity101_once_bonus", package.seeall)

slot1 = {
	activityId = 1,
	bonus = 2
}
slot2 = {
	"activityId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
