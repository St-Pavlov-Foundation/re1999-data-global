module("modules.configs.excel2json.lua_task_instruction", package.seeall)

slot1 = {
	listenerParam = 6,
	minType = 3,
	listenerType = 5,
	name = 2,
	id = 1,
	maxProgress = 7,
	bonus = 8,
	desc = 4
}
slot2 = {
	"id"
}
slot3 = {
	minType = 2,
	name = 1,
	desc = 3
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
