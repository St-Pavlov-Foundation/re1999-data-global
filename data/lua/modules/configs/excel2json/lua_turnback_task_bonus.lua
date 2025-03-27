module("modules.configs.excel2json.lua_turnback_task_bonus", package.seeall)

slot1 = {
	needPoint = 6,
	character = 4,
	id = 2,
	turnbackId = 1,
	content = 5,
	bonus = 3
}
slot2 = {
	"turnbackId",
	"id"
}
slot3 = {
	content = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
