module("modules.configs.excel2json.lua_activity104_equip_tag", package.seeall)

slot1 = {
	order = 5,
	name = 4,
	id = 2,
	activityId = 1,
	desc = 3
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {
	name = 2,
	desc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
