module("modules.configs.excel2json.lua_room_vehicle", package.seeall)

slot1 = {
	audioStop = 14,
	radius = 5,
	audioTurn = 9,
	rotate = 12,
	moveSpeed = 6,
	name = 2,
	followRotateStr = 17,
	path = 3,
	audioTurnAround = 10,
	takeoffTime = 19,
	endPathWaitTime = 8,
	audioCrossload = 11,
	firstCameraId = 20,
	resId = 4,
	uiIcon = 22,
	replaceConditionStr = 24,
	waterOffseY = 25,
	buildIcon = 23,
	rotationSpeed = 7,
	useType = 18,
	followNodePathStr = 15,
	followRadiusStr = 16,
	id = 1,
	thirdCameraId = 21,
	audioWalk = 13
}
slot2 = {
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
