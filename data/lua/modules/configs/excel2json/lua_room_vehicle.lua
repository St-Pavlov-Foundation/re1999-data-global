module("modules.configs.excel2json.lua_room_vehicle", package.seeall)

local var_0_0 = {}
local var_0_1 = {
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
local var_0_2 = {
	"id"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
