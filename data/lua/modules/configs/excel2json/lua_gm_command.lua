module("modules.configs.excel2json.lua_gm_command", package.seeall)

slot1 = {
	id = 1,
	name = 3,
	command = 2,
	desc = 4
}
slot2 = {
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
