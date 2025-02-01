module("modules.configs.excel2json.lua_task_weekwalk", package.seeall)

slot1 = {
	sortId = 10,
	listenerType = 6,
	periods = 13,
	bonusMail = 12,
	maxFinishCount = 9,
	layerId = 5,
	desc = 4,
	listenerParam = 7,
	minType = 3,
	minTypeId = 2,
	id = 1,
	maxProgress = 8,
	bonus = 11
}
slot2 = {
	"id"
}
slot3 = {
	desc = 2,
	minType = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
