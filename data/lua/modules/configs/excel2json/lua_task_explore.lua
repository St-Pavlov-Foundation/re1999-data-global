module("modules.configs.excel2json.lua_task_explore", package.seeall)

slot1 = {
	listenerType = 5,
	isOnline = 2,
	name = 3,
	display = 9,
	desc = 4,
	listenerParam = 6,
	id = 1,
	maxProgress = 7,
	bonus = 8
}
slot2 = {
	"id"
}
slot3 = {
	desc = 2,
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
