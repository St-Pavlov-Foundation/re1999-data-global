module("modules.configs.excel2json.lua_turnback_task", package.seeall)

slot1 = {
	sortId = 11,
	name = 6,
	isOnline = 3,
	maxProgress = 10,
	prepose = 12,
	listenerType = 8,
	loopType = 4,
	desc = 7,
	listenerParam = 9,
	minType = 5,
	openLimit = 13,
	params = 14,
	id = 1,
	turnbackId = 2,
	jumpId = 15,
	bonus = 16
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
