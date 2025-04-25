module("modules.configs.excel2json.lua_actvity186_mini_game", package.seeall)

slot1 = {
	gameType2Prob = 6,
	expireSeconds = 7,
	triggerConditionParams = 4,
	triggerConditionType = 3,
	id = 2,
	activityId = 1,
	conditionStage = 5
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
