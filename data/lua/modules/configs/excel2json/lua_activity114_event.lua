module("modules.configs.excel2json.lua_activity114_event", package.seeall)

slot1 = {
	checkOptionText = 6,
	isCheckEvent = 12,
	disposable = 11,
	successVerify = 13,
	battleId = 19,
	testId = 20,
	eventType = 4,
	successBattle = 17,
	activityId = 1,
	isTransition = 21,
	param = 5,
	storyId = 3,
	threshold = 10,
	checkAttribute = 8,
	condition = 18,
	nonOptionText = 7,
	failureStoryId = 16,
	id = 2,
	failureVerify = 15,
	successStoryId = 14,
	checkfeatures = 9
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {
	checkOptionText = 1,
	nonOptionText = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
