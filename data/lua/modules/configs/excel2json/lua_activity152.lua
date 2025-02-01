module("modules.configs.excel2json.lua_activity152", package.seeall)

slot1 = {
	presentName = 3,
	presentId = 2,
	roleNameEn = 8,
	presentIcon = 4,
	bonus = 10,
	acceptDate = 11,
	roleName = 7,
	roleIcon = 6,
	dialog = 9,
	activityId = 1,
	presentSign = 5
}
slot2 = {
	"activityId",
	"presentId"
}
slot3 = {
	roleName = 2,
	presentName = 1,
	dialog = 3
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
