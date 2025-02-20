module("modules.configs.excel2json.lua_activity176_episode", package.seeall)

slot1 = {
	id = 2,
	elementId = 3,
	activityId = 1,
	target = 4
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {
	target = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
