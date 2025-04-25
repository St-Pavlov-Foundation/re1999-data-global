module("modules.configs.excel2json.lua_room_atmosphere", package.seeall)

slot1 = {
	effectSequence = 3,
	openTime = 6,
	buildingId = 2,
	cdtimes = 9,
	residentEffect = 4,
	triggerType = 8,
	cyclesTimes = 5,
	id = 1,
	durationDay = 7
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
