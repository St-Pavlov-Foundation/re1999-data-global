module("modules.configs.excel2json.lua_activity130_oper_group", package.seeall)

slot1 = {
	operGroupId = 2,
	descImg = 5,
	name = 9,
	operDesc = 4,
	operType = 3,
	audioId = 8,
	shapegetImg = 7,
	shapeImg = 6,
	activityId = 1
}
slot2 = {
	"activityId",
	"operGroupId",
	"operType"
}
slot3 = {
	name = 2,
	operDesc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
