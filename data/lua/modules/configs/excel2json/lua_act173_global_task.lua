module("modules.configs.excel2json.lua_act173_global_task", package.seeall)

slot1 = {
	id = 2,
	endValue = 3,
	activityId = 1,
	isVisible = 4
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
