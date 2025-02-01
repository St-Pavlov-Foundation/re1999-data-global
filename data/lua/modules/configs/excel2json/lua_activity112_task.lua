module("modules.configs.excel2json.lua_activity112_task", package.seeall)

slot1 = {
	jumpId = 11,
	isOnline = 3,
	listenerType = 6,
	bonus = 10,
	desc = 5,
	taskId = 2,
	listenerParam = 7,
	minTypeId = 4,
	maxProgress = 8,
	activityId = 1,
	sort = 9
}
slot2 = {
	"activityId",
	"taskId"
}
slot3 = {
	desc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
