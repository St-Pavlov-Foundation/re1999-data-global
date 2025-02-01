module("modules.configs.excel2json.lua_activity161_reward", package.seeall)

slot1 = {
	rewardId = 3,
	bonus = 4,
	activityId = 1,
	paintedNum = 2
}
slot2 = {
	"activityId",
	"paintedNum"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
