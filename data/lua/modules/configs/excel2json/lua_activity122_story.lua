module("modules.configs.excel2json.lua_activity122_story", package.seeall)

slot1 = {
	bgPath = 9,
	name = 3,
	needbg = 8,
	nameen = 4,
	episodeId = 5,
	id = 2,
	icon = 6,
	activityId = 1,
	order = 7
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
