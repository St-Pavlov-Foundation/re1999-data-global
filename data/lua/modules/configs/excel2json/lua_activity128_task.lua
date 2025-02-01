module("modules.configs.excel2json.lua_activity128_task", package.seeall)

slot1 = {
	achievementRes = 4,
	name = 8,
	stage = 3,
	bonusMail = 11,
	maxFinishCount = 17,
	activity = 18,
	desc = 9,
	listenerParam = 15,
	needAccept = 10,
	params = 12,
	openLimit = 13,
	maxProgress = 16,
	activityId = 2,
	jumpId = 19,
	isOnline = 5,
	totalTaskType = 6,
	listenerType = 14,
	minType = 7,
	id = 1,
	bonus = 20
}
slot2 = {
	"id"
}
slot3 = {
	name = 2,
	minType = 1,
	desc = 3
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
