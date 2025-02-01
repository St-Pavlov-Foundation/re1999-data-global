module("modules.configs.excel2json.lua_activity119_episode", package.seeall)

slot1 = {
	openDay = 5,
	name = 3,
	tabId = 4,
	id = 2,
	icon = 6,
	activityId = 1,
	des = 7
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {
	des = 2,
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
