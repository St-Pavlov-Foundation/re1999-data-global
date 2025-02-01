module("modules.configs.excel2json.lua_reward", package.seeall)

slot1 = {
	reward_id = 1,
	rewardGroup1 = 4,
	dailyDrop = 2,
	rewardGroup2 = 5,
	rewardGroup3 = 6,
	rewardGroup4 = 7,
	dailyGainWarning = 3,
	rewardGroup5 = 8,
	rewardGroup6 = 9
}
slot2 = {
	"reward_id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
