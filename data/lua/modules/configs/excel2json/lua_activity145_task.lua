module("modules.configs.excel2json.lua_activity145_task", package.seeall)

slot1 = {
	prepose = 11,
	name = 7,
	activity = 18,
	bonusMail = 17,
	maxFinishCount = 16,
	sort = 21,
	desc = 8,
	listenerParam = 14,
	needAccept = 9,
	params = 10,
	openLimit = 12,
	maxProgress = 15,
	activityId = 2,
	canRemove = 5,
	jumpId = 19,
	isOnline = 4,
	group = 3,
	listenerType = 13,
	minType = 6,
	id = 1,
	bonus = 20
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
