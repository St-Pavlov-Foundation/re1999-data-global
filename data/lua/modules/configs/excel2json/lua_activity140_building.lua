module("modules.configs.excel2json.lua_activity140_building", package.seeall)

slot1 = {
	cost = 6,
	name = 7,
	skilldesc = 5,
	type = 4,
	group = 3,
	focusPos = 12,
	pos = 11,
	desc = 13,
	previewImg = 9,
	id = 1,
	icon = 10,
	activityId = 2,
	nameEn = 8
}
slot2 = {
	"id"
}
slot3 = {
	name = 2,
	skilldesc = 1,
	desc = 3
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
