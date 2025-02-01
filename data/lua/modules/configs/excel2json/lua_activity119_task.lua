module("modules.configs.excel2json.lua_activity119_task", package.seeall)

slot1 = {
	desc = 8,
	isOnline = 6,
	bonusMail = 9,
	tabId = 4,
	openLimit = 10,
	listenerType = 11,
	bonus = 14,
	day = 3,
	listenerParam = 12,
	minType = 7,
	id = 1,
	maxProgress = 13,
	activityId = 2,
	sort = 5
}
slot2 = {
	"id"
}
slot3 = {
	desc = 2,
	minType = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
