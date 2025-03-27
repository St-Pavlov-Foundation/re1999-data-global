module("modules.configs.excel2json.lua_bp_task", package.seeall)

slot1 = {
	listenerType = 8,
	name = 6,
	bonusScoreTimes = 22,
	bonusMail = 14,
	endTime = 19,
	turnbackTask = 20,
	jumpId = 17,
	desc = 7,
	listenerParam = 9,
	bpId = 3,
	params = 15,
	openLimit = 13,
	maxProgress = 10,
	sortId = 11,
	isOnline = 2,
	prepose = 12,
	loopType = 4,
	bonusScore = 16,
	minType = 5,
	id = 1,
	newbieTask = 21,
	startTime = 18
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
