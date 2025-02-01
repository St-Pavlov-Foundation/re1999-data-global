module("modules.configs.excel2json.lua_activity172_task", package.seeall)

slot1 = {
	itemId = 11,
	name = 5,
	openLimit = 7,
	isOnline = 3,
	listenerType = 8,
	jumpId = 12,
	desc = 6,
	listenerParam = 9,
	minType = 4,
	id = 1,
	maxProgress = 10,
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
