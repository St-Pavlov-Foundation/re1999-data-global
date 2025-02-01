module("modules.configs.excel2json.lua_activity128_achievement", package.seeall)

slot1 = {
	achievementRes = 7,
	rewardPointNum = 6,
	desc = 5,
	minTypeId = 4,
	reward = 8,
	stage = 2,
	activityId = 1,
	taskId = 3
}
slot2 = {
	"activityId",
	"stage",
	"taskId"
}
slot3 = {
	desc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
