module("modules.configs.excel2json.lua_activity163_task", package.seeall)

slot1 = {
	jumpId = 10,
	isOnline = 3,
	episodeId = 9,
	name = 5,
	listenerType = 6,
	listenerParam = 7,
	minType = 4,
	id = 1,
	maxProgress = 8,
	activityId = 2,
	bonus = 11
}
slot2 = {
	"id"
}
slot3 = {
	name = 2,
	minType = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
