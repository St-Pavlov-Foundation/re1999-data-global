module("modules.configs.excel2json.lua_room_character", package.seeall)

local var_0_0 = {}
local var_0_1 = {
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
	hideFootprint = 13,
	moveRate = 5,
	moveInterval = 4
}
local var_0_2 = {
	"skinId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
