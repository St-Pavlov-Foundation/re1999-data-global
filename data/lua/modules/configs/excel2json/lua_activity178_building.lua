module("modules.configs.excel2json.lua_activity178_building", package.seeall)

slot1 = {
	cost = 12,
	effect = 7,
	desc2 = 11,
	type = 4,
	name = 5,
	uiOffset = 13,
	condition = 6,
	desc = 10,
	destory = 14,
	res = 8,
	limit = 15,
	size = 16,
	id = 2,
	icon = 9,
	activityId = 1,
	level = 3
}
slot2 = {
	"activityId",
	"id",
	"level"
}
slot3 = {
	desc2 = 3,
	name = 1,
	desc = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
