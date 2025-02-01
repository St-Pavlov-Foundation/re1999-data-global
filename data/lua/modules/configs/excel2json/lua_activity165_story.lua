module("modules.configs.excel2json.lua_activity165_story", package.seeall)

slot1 = {
	storyId = 2,
	unlockElementIds2 = 7,
	firstUnlockElementCd2 = 8,
	preElementId1 = 3,
	firstUnlockElementCd1 = 5,
	unlockElementIds1 = 4,
	pic = 11,
	name = 10,
	firstStepId = 9,
	preElementId2 = 6,
	activityId = 1
}
slot2 = {
	"activityId",
	"storyId"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
