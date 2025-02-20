module("modules.configs.excel2json.lua_role_activity_task", package.seeall)

slot1 = {
	taskDesc = 5,
	name = 4,
	jumpid = 10,
	listenerType = 6,
	listenerParam = 7,
	minType = 3,
	id = 2,
	maxProgress = 8,
	activityId = 1,
	bonus = 9
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {
	name = 2,
	minType = 1,
	taskDesc = 3
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
