module("modules.configs.excel2json.lua_activity178_talent", package.seeall)

slot1 = {
	isBig = 7,
	name = 3,
	effect = 11,
	cost = 12,
	condition = 9,
	desc = 8,
	needLv = 10,
	point = 5,
	id = 2,
	icon = 6,
	activityId = 1,
	root = 4
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {
	desc = 2,
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
