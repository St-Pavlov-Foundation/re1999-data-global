module("modules.configs.excel2json.lua_turnback_task", package.seeall)

slot1 = {
	sortId = 11,
	name = 6,
	unlockDay = 17,
	type = 18,
	isOnlineTimeTask = 19,
	acceptNeedOnlineSeconds = 20,
	desc = 7,
	listenerParam = 9,
	params = 14,
	openLimit = 13,
	maxProgress = 10,
	jumpId = 15,
	isOnline = 3,
	prepose = 12,
	loopType = 4,
	listenerType = 8,
	minType = 5,
	id = 1,
	turnbackId = 2,
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
