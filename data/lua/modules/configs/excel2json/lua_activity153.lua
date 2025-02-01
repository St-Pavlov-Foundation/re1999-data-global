module("modules.configs.excel2json.lua_activity153", package.seeall)

slot1 = {
	activityId = 1,
	dailyLimit = 3,
	totalLimit = 2
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
