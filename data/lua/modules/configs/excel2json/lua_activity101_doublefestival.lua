module("modules.configs.excel2json.lua_activity101_doublefestival", package.seeall)

slot1 = {
	blessTitle = 5,
	blessContent = 7,
	blessTitleEn = 6,
	btnDesc = 4,
	blessDesc = 8,
	blessContentType = 10,
	day = 2,
	bgSpriteName = 3,
	activityId = 1,
	blessSpriteName = 9
}
slot2 = {
	"activityId",
	"day"
}
slot3 = {
	btnDesc = 2,
	bgSpriteName = 1,
	blessContent = 5,
	blessDesc = 6,
	blessTitle = 3,
	blessContentType = 8,
	blessTitleEn = 4,
	blessSpriteName = 7
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
