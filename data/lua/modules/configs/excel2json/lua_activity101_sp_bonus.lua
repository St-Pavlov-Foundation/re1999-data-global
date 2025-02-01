module("modules.configs.excel2json.lua_activity101_sp_bonus", package.seeall)

slot1 = {
	canGetSignInDays = 6,
	taskDesc = 3,
	canGetDate = 5,
	id = 2,
	activityId = 1,
	bonus = 4
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {
	taskDesc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
