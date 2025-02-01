module("modules.configs.excel2json.lua_activity144_task", package.seeall)

slot1 = {
	jumpId = 10,
	name = 6,
	isOnline = 3,
	desc = 12,
	showType = 13,
	episodeId = 14,
	loopType = 4,
	listenerType = 7,
	listenerParam = 8,
	minType = 5,
	id = 1,
	maxProgress = 9,
	activityId = 2,
	bonus = 11
}
slot2 = {
	"id"
}
slot3 = {
	name = 3,
	minType = 2,
	loopType = 1,
	desc = 4
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
