module("modules.configs.excel2json.lua_task_guide", package.seeall)

slot1 = {
	maxProgress = 9,
	name = 5,
	isOnline = 2,
	bonusMail = 15,
	maxFinishCount = 10,
	part = 17,
	priority = 19,
	desc = 6,
	listenerParam = 8,
	chapter = 18,
	needAccept = 20,
	jumpId = 22,
	openLimit = 14,
	stage = 16,
	sortId = 12,
	activity = 11,
	prepose = 13,
	listenerType = 7,
	minType = 4,
	minTypeId = 3,
	id = 1,
	bonus = 21
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
