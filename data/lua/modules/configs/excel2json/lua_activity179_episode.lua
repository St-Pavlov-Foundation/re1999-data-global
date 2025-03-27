module("modules.configs.excel2json.lua_activity179_episode", package.seeall)

slot1 = {
	name_En = 7,
	name = 6,
	orderId = 5,
	id = 2,
	storyAfter = 10,
	preEpisode = 3,
	beatId = 8,
	storyBefore = 9,
	episodeType = 4,
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
