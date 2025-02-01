module("modules.configs.excel2json.lua_activity161_graffiti", package.seeall)

slot1 = {
	dialogGroupId = 7,
	subElementIds = 6,
	activityId = 1,
	finishRate = 9,
	mainElementCd = 5,
	picture = 8,
	finishTitle = 12,
	finishDesc = 13,
	elementId = 2,
	preMainElementIds = 4,
	finishTitleEn = 14,
	brushSize = 10,
	mainElementId = 3,
	sort = 11
}
slot2 = {
	"activityId",
	"elementId"
}
slot3 = {
	finishDesc = 2,
	finishTitle = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
