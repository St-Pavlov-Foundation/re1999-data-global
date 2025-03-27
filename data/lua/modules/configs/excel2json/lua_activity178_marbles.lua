module("modules.configs.excel2json.lua_activity178_marbles", package.seeall)

slot1 = {
	detectTime = 9,
	name = 3,
	radius = 6,
	elasticity = 7,
	effectTime2 = 11,
	limit = 12,
	effectTime = 10,
	desc = 4,
	id = 2,
	icon = 5,
	activityId = 1,
	velocity = 8
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
