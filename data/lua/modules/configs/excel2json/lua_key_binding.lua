module("modules.configs.excel2json.lua_key_binding", package.seeall)

slot1 = {
	description = 3,
	key = 4,
	hud = 1,
	editable = 5,
	id = 2
}
slot2 = {
	"hud",
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
