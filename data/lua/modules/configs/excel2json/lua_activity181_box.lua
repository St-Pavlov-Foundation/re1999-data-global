module("modules.configs.excel2json.lua_activity181_box", package.seeall)

slot1 = {
	showOnlineTime = 2,
	bonus = 5,
	obtainStart = 7,
	obtainTimes = 9,
	showOfflineTime = 3,
	obtainType = 6,
	totalBox = 4,
	activityId = 1,
	obtainEnd = 8
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
