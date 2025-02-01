module("modules.configs.excel2json.lua_activity123_package", package.seeall)

slot1 = {
	id = 2,
	name = 3,
	changeWeight = 7,
	awardTime5 = 6,
	initWeight = 4,
	awardTime4 = 5,
	activityId = 1
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
