module("modules.configs.excel2json.lua_rogue_event_drama_choice", package.seeall)

slot1 = {
	dialogId = 7,
	event = 9,
	collection = 10,
	type = 2,
	group = 3,
	title = 5,
	condition = 4,
	desc = 6,
	id = 1,
	icon = 8
}
slot2 = {
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
