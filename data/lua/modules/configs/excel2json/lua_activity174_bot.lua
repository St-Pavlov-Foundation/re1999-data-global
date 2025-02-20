module("modules.configs.excel2json.lua_activity174_bot", package.seeall)

slot1 = {
	role2 = 8,
	collection3 = 13,
	count = 6,
	collection1 = 11,
	season = 3,
	role3 = 9,
	enhance = 15,
	collection4 = 14,
	role1 = 7,
	collection2 = 12,
	role4 = 10,
	id = 1,
	robotId = 4,
	activityId = 2,
	level = 5
}
slot2 = {
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
