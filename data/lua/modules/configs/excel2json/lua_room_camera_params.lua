module("modules.configs.excel2json.lua_room_camera_params", package.seeall)

local var_0_0 = {}
local var_0_1 = {
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
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
