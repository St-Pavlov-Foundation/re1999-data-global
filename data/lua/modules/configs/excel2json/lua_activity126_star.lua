module("modules.configs.excel2json.lua_activity126_star", package.seeall)

slot1 = {
	pos = 5,
	tip = 4,
	num = 1,
	activityId = 2,
	bonus = 3
}
slot2 = {
	"num",
	"activityId"
}
slot3 = {
	tip = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
