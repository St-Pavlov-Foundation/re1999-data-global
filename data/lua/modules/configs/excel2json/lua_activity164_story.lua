module("modules.configs.excel2json.lua_activity164_story", package.seeall)

slot1 = {
	bgPath = 9,
	name = 5,
	needbg = 8,
	nameen = 6,
	episodeId = 2,
	id = 4,
	icon = 7,
	activityId = 1,
	order = 3
}
slot2 = {
	"activityId",
	"episodeId",
	"order"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
