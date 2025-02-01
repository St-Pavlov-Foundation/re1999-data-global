module("modules.configs.excel2json.lua_room_character", package.seeall)

slot1 = {
	shadow = 8,
	moveSpeed = 6,
	zeroMix = 7,
	skinId = 1,
	cameraAnimPath = 9,
	specialIdle = 2,
	effectPath = 10,
	waterDistance = 11,
	specialRate = 3,
	roleVoice = 12,
	moveRate = 5,
	moveInterval = 4
}
slot2 = {
	"skinId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
