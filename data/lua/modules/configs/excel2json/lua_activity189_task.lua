module("modules.configs.excel2json.lua_activity189_task", package.seeall)

slot1 = {
	openLimitActId = 14,
	name = 6,
	openLimit = 9,
	bonusMail = 8,
	desc = 7,
	listenerParam = 11,
	clientlistenerParam = 12,
	tag = 13,
	maxProgress = 16,
	activityId = 2,
	jumpId = 17,
	isOnline = 3,
	loopType = 4,
	listenerType = 10,
	minType = 5,
	id = 1,
	sorting = 15,
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
