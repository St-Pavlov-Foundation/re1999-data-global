module("modules.configs.excel2json.lua_activity101_springsign", package.seeall)

slot1 = {
	goodDesc = 6,
	name = 3,
	simpleDesc = 4,
	detailDesc = 5,
	badDesc = 7,
	activityId = 1,
	day = 2
}
slot2 = {
	"activityId",
	"day"
}
slot3 = {
	goodDesc = 4,
	name = 1,
	simpleDesc = 2,
	detailDesc = 3,
	badDesc = 5
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
