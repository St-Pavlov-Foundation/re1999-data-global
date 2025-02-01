module("modules.configs.excel2json.lua_room_character_interaction", package.seeall)

slot1 = {
	relateHeroId = 15,
	buildingAudio = 10,
	variety = 3,
	rate = 5,
	faithDialog = 18,
	excludeDaily = 19,
	conditionStr = 21,
	buildingAnimState = 13,
	heroId = 2,
	weather = 4,
	buildingCameraIds = 11,
	behaviour = 6,
	buildingNode = 12,
	reward = 17,
	showtime = 20,
	buildingInside = 8,
	heroAnimState = 14,
	buildingId = 7,
	buildingInsideSpines = 9,
	id = 1,
	dialogId = 16
}
slot2 = {
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
