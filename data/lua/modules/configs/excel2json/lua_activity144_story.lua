module("modules.configs.excel2json.lua_activity144_story", package.seeall)

slot1 = {
	titleen = 5,
	name = 3,
	order = 8,
	nameen = 4,
	id = 2,
	icon = 7,
	activityId = 1,
	episodeId = 6
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
