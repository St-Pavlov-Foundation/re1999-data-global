module("modules.configs.excel2json.lua_activity114_feature", package.seeall)

slot1 = {
	verifyNum = 5,
	inheritable = 9,
	attributeNum = 6,
	courseEfficiency = 7,
	desc = 4,
	restEfficiency = 8,
	id = 2,
	features = 3,
	activityId = 1
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {
	desc = 2,
	features = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
