module("modules.configs.excel2json.lua_activity166_base_target", package.seeall)

slot1 = {
	score = 6,
	targetParam = 5,
	targetType = 4,
	targetId = 3,
	baseId = 2,
	targetDesc = 7,
	activityId = 1
}
slot2 = {
	"activityId",
	"baseId",
	"targetId"
}
slot3 = {
	targetDesc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
