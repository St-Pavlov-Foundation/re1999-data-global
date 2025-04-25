module("modules.configs.excel2json.lua_room_character_interaction", package.seeall)

slot1 = {
	buildingAudio = 10,
	variety = 3,
	rate = 5,
	dialogId = 17,
	faithDialog = 19,
	excludeDaily = 20,
	conditionStr = 22,
	buildingAnimState = 13,
	heroId = 2,
	weather = 4,
	buildingCameraIds = 11,
	behaviour = 6,
	buildingNode = 12,
	reward = 18,
	showtime = 21,
	buildingInside = 8,
	heroAnimState = 14,
	buildingId = 7,
	buildingInsideSpines = 9,
	id = 1,
	relateHeroId = 16,
	delayEnterBuilding = 15
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
