module("modules.configs.excel2json.lua_activity168_compose_type", package.seeall)

slot1 = {
	name = 3,
	composeType = 2,
	activityId = 1,
	costItems = 4
}
slot2 = {
	"activityId",
	"composeType"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
