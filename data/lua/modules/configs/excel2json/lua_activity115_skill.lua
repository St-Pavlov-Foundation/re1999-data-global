module("modules.configs.excel2json.lua_activity115_skill", package.seeall)

slot1 = {
	param = 4,
	name = 6,
	type = 3,
	id = 2,
	canUseCount = 5,
	activityId = 1,
	desc = 7
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
