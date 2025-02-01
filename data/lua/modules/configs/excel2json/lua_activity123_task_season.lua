module("modules.configs.excel2json.lua_activity123_task_season", package.seeall)

slot1 = {
	sortId = 12,
	isOnline = 5,
	listenerType = 8,
	equipBonus = 14,
	maxFinishCount = 11,
	jumpId = 15,
	desc = 7,
	listenerParam = 9,
	minType = 4,
	seasonId = 2,
	minTypeId = 3,
	id = 1,
	maxProgress = 10,
	bgType = 6,
	bonus = 13
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
