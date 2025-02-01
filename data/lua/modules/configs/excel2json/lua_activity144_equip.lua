module("modules.configs.excel2json.lua_activity144_equip", package.seeall)

slot1 = {
	cost = 4,
	name = 8,
	buffId = 6,
	preEquipId = 3,
	typeId = 7,
	equipId = 2,
	effectDesc = 9,
	activityId = 1,
	level = 5
}
slot2 = {
	"activityId",
	"equipId"
}
slot3 = {
	effectDesc = 2,
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
