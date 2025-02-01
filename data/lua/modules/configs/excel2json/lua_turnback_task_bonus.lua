module("modules.configs.excel2json.lua_turnback_task_bonus", package.seeall)

slot1 = {
	id = 2,
	turnbackId = 1,
	needPoint = 4,
	bonus = 3
}
slot2 = {
	"turnbackId",
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
