module("modules.configs.excel2json.lua_activity173_task", package.seeall)

slot1 = {
	sortId = 9,
	isOnline = 2,
	name = 4,
	bonusMail = 12,
	prepose = 10,
	openLimit = 11,
	listenerType = 6,
	desc = 5,
	listenerParam = 7,
	minType = 3,
	jumpId = 15,
	params = 13,
	id = 1,
	maxProgress = 8,
	activityId = 16,
	bonus = 14
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
