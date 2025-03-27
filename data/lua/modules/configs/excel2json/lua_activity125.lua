module("modules.configs.excel2json.lua_activity125", package.seeall)

slot1 = {
	targetFrequency = 7,
	name = 8,
	preId = 3,
	musictime = 12,
	clientbonus = 11,
	openDay = 4,
	time = 13,
	key = 14,
	text = 9,
	initFrequency = 6,
	id = 2,
	frequency = 5,
	activityId = 1,
	bonus = 10
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {
	text = 2,
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
