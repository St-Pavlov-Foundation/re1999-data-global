module("modules.configs.excel2json.lua_activity114_round", package.seeall)

slot1 = {
	desc = 5,
	storyId = 10,
	isSkip = 12,
	type = 4,
	eventId = 8,
	transition = 11,
	day = 2,
	banButton2 = 7,
	banButton1 = 6,
	id = 3,
	activityId = 1,
	preStoryId = 9
}
slot2 = {
	"activityId",
	"day",
	"id"
}
slot3 = {
	desc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
