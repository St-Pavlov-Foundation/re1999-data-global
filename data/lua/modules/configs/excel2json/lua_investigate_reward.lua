module("modules.configs.excel2json.lua_investigate_reward", package.seeall)

slot1 = {
	listenerParam = 4,
	minType = 2,
	listenerType = 3,
	desc = 6,
	bonus = 7,
	maxProgress = 5,
	jumpId = 8,
	taskId = 1
}
slot2 = {
	"taskId"
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
