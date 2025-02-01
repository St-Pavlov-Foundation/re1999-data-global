module("modules.configs.excel2json.lua_activity133_episode", package.seeall)

slot1 = {
	jumpId = 8,
	listenerType = 5,
	orActivity = 9,
	prop = 4,
	desc = 3,
	listenerParam = 6,
	loopDay = 10,
	id = 2,
	maxProgress = 7,
	activityId = 1
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {
	maxProgress = 2,
	desc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
