module("modules.configs.excel2json.lua_activity145_task_bonus", package.seeall)

slot1 = {
	bonus = 5,
	needProgress = 4,
	id = 2,
	activityId = 1,
	desc = 3
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {
	desc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
