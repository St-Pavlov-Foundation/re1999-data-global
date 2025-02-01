module("modules.configs.excel2json.lua_room_camera_params", package.seeall)

slot1 = {
	fogRangeXYZW = 15,
	gameMode = 3,
	blur = 9,
	state = 2,
	lightMin = 6,
	bendingAmount = 8,
	distance = 5,
	fogParticles = 13,
	zoom = 4,
	oceanFog = 18,
	angle = 7,
	shadowOffsetXYZW = 12,
	fogNearColorRGBA = 16,
	fogViewType = 14,
	touchMoveSpeed = 11,
	offsetHorizon = 10,
	fogFarColorRGBA = 17,
	id = 1
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
