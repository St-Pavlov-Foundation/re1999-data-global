module("modules.configs.excel2json.lua_activity178_episode", package.seeall)

slot1 = {
	reward = 12,
	name = 4,
	condition2 = 10,
	type = 3,
	target = 11,
	shortDesc = 6,
	condition = 9,
	desc = 7,
	mapId = 8,
	id = 2,
	longDesc = 5,
	activityId = 1
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {
	longDesc = 2,
	name = 1,
	shortDesc = 3,
	desc = 4
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
