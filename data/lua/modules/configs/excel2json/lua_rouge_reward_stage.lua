module("modules.configs.excel2json.lua_rouge_reward_stage", package.seeall)

slot1 = {
	jump = 8,
	name = 6,
	icon = 5,
	stage = 2,
	season = 1,
	openTime = 9,
	bigRewardId = 4,
	pointLimit = 10,
	preStage = 3,
	lockName = 7
}
slot2 = {
	"season",
	"stage"
}
slot3 = {
	lockName = 2,
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
