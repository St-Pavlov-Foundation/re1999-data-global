module("modules.configs.excel2json.lua_activity123_trial", package.seeall)

slot1 = {
	equipId = 8,
	firstPassEquipIds = 5,
	name = 6,
	nameEn = 7,
	unlockStage = 4,
	episodeId = 3,
	activityId = 1,
	layer = 2
}
slot2 = {
	"activityId",
	"layer"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
