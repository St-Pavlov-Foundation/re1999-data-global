module("modules.configs.excel2json.lua_activity106_task", package.seeall)

slot1 = {
	orderid = 17,
	name = 5,
	bonusMail = 8,
	maxFinishCount = 14,
	desc = 6,
	listenerParam = 12,
	needAccept = 7,
	params = 9,
	openLimit = 10,
	maxProgress = 13,
	activityId = 2,
	openDay = 16,
	isOnline = 3,
	listenerType = 11,
	minType = 4,
	id = 1,
	bonus = 15
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
