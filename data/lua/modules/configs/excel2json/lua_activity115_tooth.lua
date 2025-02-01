module("modules.configs.excel2json.lua_activity115_tooth", package.seeall)

slot1 = {
	story = 5,
	name = 3,
	prefab = 7,
	id = 2,
	icon = 6,
	activityId = 1,
	desc = 4
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {
	desc = 2,
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
