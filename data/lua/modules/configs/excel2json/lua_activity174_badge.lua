module("modules.configs.excel2json.lua_activity174_badge", package.seeall)

slot1 = {
	trigger = 6,
	name = 3,
	actParam = 7,
	spParam = 8,
	id = 2,
	icon = 5,
	activityId = 1,
	desc = 4
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
