module("modules.configs.excel2json.lua_activity166_train", package.seeall)

slot1 = {
	trainId = 2,
	name = 7,
	winDesc = 12,
	needStar = 4,
	strategy = 11,
	firstBonus = 6,
	level = 10,
	episodeId = 3,
	desc = 9,
	type = 5,
	activityId = 1,
	nameEn = 8
}
slot2 = {
	"activityId",
	"trainId"
}
slot3 = {
	strategy = 3,
	name = 1,
	winDesc = 4,
	desc = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
