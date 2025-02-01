module("modules.configs.excel2json.lua_activity117_task", package.seeall)

slot1 = {
	listenerParam = 6,
	name = 3,
	listenerType = 5,
	icon = 8,
	id = 2,
	maxProgress = 7,
	activityId = 1,
	desc = 4
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {
	desc = 2,
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
