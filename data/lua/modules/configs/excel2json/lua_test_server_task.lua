module("modules.configs.excel2json.lua_test_server_task", package.seeall)

slot1 = {
	sortId = 10,
	name = 5,
	endTime = 17,
	bonusMail = 13,
	bonus = 18,
	desc = 6,
	listenerParam = 8,
	params = 14,
	openLimit = 12,
	maxProgress = 9,
	activityId = 19,
	jumpId = 15,
	isOnline = 2,
	prepose = 11,
	loopType = 3,
	listenerType = 7,
	minType = 4,
	id = 1,
	startTime = 16
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
