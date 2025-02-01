module("modules.configs.excel2json.lua_activity130_task", package.seeall)

slot1 = {
	jumpId = 10,
	name = 5,
	episodeId = 9,
	isOnline = 3,
	loopType = 4,
	listenerType = 6,
	listenerParam = 7,
	id = 1,
	maxProgress = 8,
	activityId = 2,
	bonus = 11
}
slot2 = {
	"id"
}
slot3 = {
	loopType = 1,
	name = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
