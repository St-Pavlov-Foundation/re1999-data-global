module("modules.configs.excel2json.lua_actvity186_milestone_bonus", package.seeall)

slot1 = {
	loopBonusIntervalNum = 5,
	isSpBonus = 7,
	coinNum = 3,
	rewardId = 2,
	bonus = 6,
	activityId = 1,
	isLoopBonus = 4
}
slot2 = {
	"activityId",
	"rewardId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
