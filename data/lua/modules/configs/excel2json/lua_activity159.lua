module("modules.configs.excel2json.lua_activity159", package.seeall)

slot1 = {
	bonus = 3,
	activityId = 1,
	day = 2
}
slot2 = {
	"activityId",
	"day"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
