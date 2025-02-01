module("modules.configs.excel2json.lua_activity126_horoscope", package.seeall)

slot1 = {
	desc = 4,
	resultIcon = 5,
	id = 1,
	activityId = 2,
	bonus = 3
}
slot2 = {
	"id",
	"activityId"
}
slot3 = {
	desc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
