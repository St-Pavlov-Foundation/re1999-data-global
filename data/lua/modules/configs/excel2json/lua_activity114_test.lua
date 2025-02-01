module("modules.configs.excel2json.lua_activity114_test", package.seeall)

slot1 = {
	score = 8,
	topic = 4,
	result = 9,
	testId = 3,
	choice2 = 6,
	choice1 = 5,
	id = 2,
	activityId = 1,
	choice3 = 7
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {
	topic = 1,
	choice2 = 3,
	choice3 = 4,
	choice1 = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
