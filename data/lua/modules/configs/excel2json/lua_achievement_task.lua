module("modules.configs.excel2json.lua_achievement_task", package.seeall)

slot1 = {
	sortId = 8,
	listenerType = 5,
	achievementId = 2,
	extraDesc = 4,
	icon = 10,
	desc = 3,
	listenerParam = 6,
	id = 1,
	maxProgress = 7,
	level = 9
}
slot2 = {
	"id"
}
slot3 = {
	extraDesc = 2,
	desc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
