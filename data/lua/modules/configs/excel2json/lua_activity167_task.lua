module("modules.configs.excel2json.lua_activity167_task", package.seeall)

slot1 = {
	jumpId = 12,
	name = 5,
	isOnline = 3,
	bonusMail = 7,
	listenerType = 9,
	id = 1,
	desc = 6,
	listenerParam = 10,
	minType = 4,
	openLimit = 8,
	maxProgress = 11,
	activityId = 2,
	bonus = 13
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
