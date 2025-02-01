module("modules.configs.excel2json.lua_activity142_chapter", package.seeall)

slot1 = {
	selectSprite = 6,
	name = 3,
	lockSprite = 7,
	txtColor = 4,
	id = 2,
	normalSprite = 5,
	activityId = 1
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
