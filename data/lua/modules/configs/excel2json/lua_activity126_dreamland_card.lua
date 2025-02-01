module("modules.configs.excel2json.lua_activity126_dreamland_card", package.seeall)

slot1 = {
	id = 1,
	desc = 4,
	activityId = 2,
	skillId = 3
}
slot2 = {
	"id"
}
slot3 = {
	desc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
