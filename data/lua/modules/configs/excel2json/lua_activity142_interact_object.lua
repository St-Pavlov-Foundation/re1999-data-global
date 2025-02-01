module("modules.configs.excel2json.lua_activity142_interact_object", package.seeall)

slot1 = {
	alertType = 8,
	name = 3,
	id = 2,
	effectId = 10,
	moveAudioId = 12,
	param = 5,
	showParam = 7,
	createAudioId = 11,
	alertParam = 9,
	avatar = 6,
	interactType = 4,
	activityId = 1
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
