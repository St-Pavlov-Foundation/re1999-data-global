module("modules.configs.excel2json.lua_adventure_task", package.seeall)

slot1 = {
	taskType = 5,
	name = 3,
	openLimit = 10,
	listenerType = 11,
	prepose = 9,
	banner = 7,
	isForever = 15,
	desc = 4,
	listenerParam = 12,
	mapId = 2,
	task_desc = 6,
	params = 8,
	id = 1,
	maxProgress = 13,
	bonus = 14
}
slot2 = {
	"id"
}
slot3 = {
	name = 1,
	task_desc = 3,
	desc = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
