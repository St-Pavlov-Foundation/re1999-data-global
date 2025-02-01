module("modules.configs.excel2json.lua_rogue_collecion_unlock_task", package.seeall)

slot1 = {
	param = 2,
	id = 1,
	desc = 3
}
slot2 = {
	"id"
}
slot3 = {
	desc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
