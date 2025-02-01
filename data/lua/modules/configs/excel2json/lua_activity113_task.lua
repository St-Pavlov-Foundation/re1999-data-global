module("modules.configs.excel2json.lua_activity113_task", package.seeall)

slot1 = {
	isOnline = 3,
	name = 5,
	isKeyReward = 20,
	bonusMail = 8,
	maxFinishCount = 15,
	desc = 6,
	listenerParam = 13,
	needAccept = 7,
	params = 9,
	openLimit = 11,
	maxProgress = 14,
	activityId = 2,
	page = 19,
	jumpId = 17,
	activity = 16,
	prepose = 10,
	listenerType = 12,
	minType = 4,
	id = 1,
	bonus = 18
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
