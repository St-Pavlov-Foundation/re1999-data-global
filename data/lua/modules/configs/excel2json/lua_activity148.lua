module("modules.configs.excel2json.lua_activity148", package.seeall)

slot1 = {
	skillSmallIcon = 8,
	skillId = 6,
	cost = 5,
	type = 3,
	skillAttrDesc = 9,
	attrs = 7,
	id = 1,
	activityId = 2,
	level = 4
}
slot2 = {
	"id"
}
slot3 = {
	skillAttrDesc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
