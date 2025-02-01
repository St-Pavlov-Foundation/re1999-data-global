module("modules.configs.excel2json.lua_activity128_episode", package.seeall)

slot1 = {
	openDay = 9,
	enhanceRole = 5,
	recommendLevelDesc = 8,
	type = 4,
	episodeId = 6,
	evaluate = 10,
	desc = 7,
	stage = 2,
	activityId = 1,
	layer = 3
}
slot2 = {
	"activityId",
	"stage",
	"layer"
}
slot3 = {
	recommendLevelDesc = 2,
	desc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
