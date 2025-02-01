module("modules.configs.excel2json.lua_hero_story_dispatch", package.seeall)

slot1 = {
	scoreReward = 9,
	name = 4,
	count = 8,
	type = 2,
	time = 10,
	effect = 12,
	effectDesc = 13,
	desc = 5,
	unlockEpisodeId = 14,
	talkIds = 15,
	heroStoryId = 3,
	consume = 7,
	id = 1,
	effectCondition = 11,
	completeDesc = 6
}
slot2 = {
	"id"
}
slot3 = {
	effectDesc = 4,
	name = 1,
	completeDesc = 3,
	desc = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
