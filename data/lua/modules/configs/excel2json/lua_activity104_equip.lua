module("modules.configs.excel2json.lua_activity104_equip", package.seeall)

slot1 = {
	iconOffset = 7,
	name = 2,
	attrId = 9,
	signIcon = 6,
	isOptional = 4,
	career = 11,
	rare = 3,
	careerIcon = 12,
	equipId = 1,
	signOffset = 8,
	group = 13,
	skillId = 10,
	tag = 15,
	icon = 5,
	activityId = 14
}
slot2 = {
	"equipId"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
