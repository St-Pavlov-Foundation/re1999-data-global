module("modules.configs.excel2json.lua_activity136", package.seeall)

slot1 = {
	activityId = 1,
	heroIds = 2
}
slot2 = {
	"activityId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
