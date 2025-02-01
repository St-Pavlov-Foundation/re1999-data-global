module("modules.configs.excel2json.lua_activity134_task", package.seeall)

slot1 = {
	sortId = 11,
	name = 6,
	isOnline = 3,
	listenerType = 8,
	prepose = 12,
	openLimit = 13,
	loopType = 4,
	desc = 7,
	listenerParam = 9,
	minType = 5,
	jumpId = 15,
	params = 14,
	id = 1,
	maxProgress = 10,
	activityId = 2,
	bonus = 16
}
slot2 = {
	"id",
	"activityId"
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
