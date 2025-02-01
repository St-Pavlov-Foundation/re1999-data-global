module("modules.configs.excel2json.lua_hero_story_score_reward", package.seeall)

slot1 = {
	score = 3,
	storyId = 2,
	id = 1,
	keyReward = 5,
	bonus = 4
}
slot2 = {
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
