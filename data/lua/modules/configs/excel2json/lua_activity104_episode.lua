module("modules.configs.excel2json.lua_activity104_episode", package.seeall)

slot1 = {
	level = 8,
	stagePicture = 7,
	stageNameEn = 6,
	episodeId = 3,
	unlockEquipIndex = 9,
	afterStoryId = 11,
	desc = 12,
	stageName = 5,
	firstPassEquipId = 10,
	stage = 4,
	activityId = 1,
	layer = 2
}
slot2 = {
	"activityId",
	"layer"
}
slot3 = {
	desc = 2,
	stageName = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
