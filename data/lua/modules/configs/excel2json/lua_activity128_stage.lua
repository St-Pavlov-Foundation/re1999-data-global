module("modules.configs.excel2json.lua_activity128_stage", package.seeall)

slot1 = {
	openDay = 7,
	name = 3,
	name_en = 4,
	bossRushLevelDetailFullBgSimage = 9,
	maxPoints = 5,
	resultViewFullBgSImage = 10,
	skinIds = 12,
	bossRushMainItemBossSprite = 8,
	skinScales = 13,
	skinOffsetXYs = 14,
	resultViewNameSImage = 11,
	layer4MaxPoints = 6,
	stage = 2,
	activityId = 1
}
slot2 = {
	"activityId",
	"stage"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
