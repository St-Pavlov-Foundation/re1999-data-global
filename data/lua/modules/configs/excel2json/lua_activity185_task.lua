module("modules.configs.excel2json.lua_activity185_task", package.seeall)

slot1 = {
	jumpId = 11,
	isOnline = 3,
	name = 5,
	episodeId = 10,
	listenerType = 7,
	desc = 6,
	listenerParam = 8,
	minType = 4,
	id = 1,
	maxProgress = 9,
	activityId = 2,
	bonus = 12
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
