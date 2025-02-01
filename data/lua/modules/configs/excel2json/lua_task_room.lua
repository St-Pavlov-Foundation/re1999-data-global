module("modules.configs.excel2json.lua_task_room", package.seeall)

slot1 = {
	bonusIcon = 20,
	name = 4,
	bonusMail = 9,
	maxFinishCount = 16,
	desc = 5,
	listenerParam = 14,
	needAccept = 8,
	params = 10,
	openLimit = 12,
	maxProgress = 15,
	order = 7,
	tips = 6,
	isOnline = 2,
	prepose = 11,
	listenerType = 13,
	onceBonus = 19,
	minType = 3,
	id = 1,
	needReset = 18,
	bonus = 17
}
slot2 = {
	"id"
}
slot3 = {
	tips = 4,
	minType = 1,
	name = 2,
	desc = 3
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
