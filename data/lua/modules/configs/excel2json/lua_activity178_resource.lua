module("modules.configs.excel2json.lua_activity178_resource", package.seeall)

slot1 = {
	tips = 5,
	name = 3,
	id = 2,
	icon = 4,
	activityId = 1
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {
	tips = 2,
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
