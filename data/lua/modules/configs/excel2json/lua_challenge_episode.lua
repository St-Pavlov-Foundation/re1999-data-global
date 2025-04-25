module("modules.configs.excel2json.lua_challenge_episode", package.seeall)

slot1 = {
	hiddenRule2 = 11,
	ruleIcon = 13,
	ruleDesc1 = 9,
	type = 3,
	groupId = 4,
	title = 15,
	preEpisodeIds = 5,
	desc = 16,
	episodeId = 1,
	reportIcon = 18,
	icon = 17,
	activityId = 2,
	order = 6,
	hiddenRule1 = 8,
	resultIcon = 19,
	rule1 = 7,
	condition = 14,
	ruleDesc2 = 12,
	rule2 = 10
}
slot2 = {
	"episodeId"
}
slot3 = {
	title = 3,
	ruleDesc2 = 2,
	ruleDesc1 = 1,
	desc = 4
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
