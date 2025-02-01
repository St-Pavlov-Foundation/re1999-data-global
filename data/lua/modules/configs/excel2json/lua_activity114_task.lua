module("modules.configs.excel2json.lua_activity114_task", package.seeall)

slot1 = {
	listenerParam = 6,
	listenerType = 5,
	desc = 4,
	minTypeId = 3,
	bonus = 8,
	maxProgress = 7,
	activityId = 1,
	taskId = 2
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
