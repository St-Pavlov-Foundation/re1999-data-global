module("modules.configs.excel2json.lua_activity_show", package.seeall)

slot1 = {
	jumpId = 6,
	taskDesc = 4,
	centerId = 7,
	actDesc = 3,
	id = 2,
	activityId = 1,
	showBonus = 5
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {
	taskDesc = 2,
	actDesc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
