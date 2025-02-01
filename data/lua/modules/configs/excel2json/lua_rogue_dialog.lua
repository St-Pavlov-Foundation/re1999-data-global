module("modules.configs.excel2json.lua_rogue_dialog", package.seeall)

slot1 = {
	text = 3,
	id = 2,
	photo = 5,
	type = 4,
	group = 1
}
slot2 = {
	"group",
	"id"
}
slot3 = {
	text = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
