module("modules.configs.excel2json.lua_task_hide_achievement", package.seeall)

slot1 = {
	name = 4,
	isOnline = 2,
	openLimit = 9,
	bonusMail = 7,
	maxFinishCount = 13,
	listenerType = 10,
	desc = 5,
	listenerParam = 11,
	minType = 3,
	needAccept = 6,
	params = 8,
	id = 1,
	maxProgress = 12,
	bonus = 14
}
slot2 = {
	"id"
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
