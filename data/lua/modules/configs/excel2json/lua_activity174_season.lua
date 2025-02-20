module("modules.configs.excel2json.lua_activity174_season", package.seeall)

slot1 = {
	openTime = 3,
	name = 4,
	season = 1,
	activityId = 2,
	desc = 5
}
slot2 = {
	"season"
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
