module("modules.configs.excel2json.lua_rogue_event_drop_desc", package.seeall)

slot1 = {
	icon = 5,
	iconbg = 6,
	type = 1,
	id = 2,
	title = 3,
	desc = 4
}
slot2 = {
	"type",
	"id"
}
slot3 = {
	desc = 2,
	title = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
