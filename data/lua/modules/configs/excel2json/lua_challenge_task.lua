module("modules.configs.excel2json.lua_challenge_task", package.seeall)

slot1 = {
	groupId = 4,
	name = 7,
	bonusMail = 9,
	type = 3,
	maxFinishCount = 14,
	desc = 8,
	listenerParam = 12,
	openLimit = 10,
	maxProgress = 13,
	activityId = 2,
	jumpId = 15,
	isOnline = 5,
	listenerType = 11,
	minType = 6,
	id = 1,
	badgeNum = 17,
	bonus = 16
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
