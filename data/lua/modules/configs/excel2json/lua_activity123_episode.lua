module("modules.configs.excel2json.lua_activity123_episode", package.seeall)

slot1 = {
	level = 5,
	layerName = 8,
	stagePicture = 6,
	desc = 9,
	unlockEquipIndex = 10,
	layerPicture = 7,
	episodeId = 4,
	displayMark = 11,
	stage = 2,
	activityId = 1,
	layer = 3
}
slot2 = {
	"activityId",
	"stage",
	"layer"
}
slot3 = {
	desc = 2,
	layerName = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
