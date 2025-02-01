module("modules.configs.excel2json.lua_activity139_task_ring", package.seeall)

slot1 = {
	id = 1,
	reward = 3,
	elementIds = 2
}
slot2 = {
	"id"
}
slot3 = {
	reward = 2,
	elementIds = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
