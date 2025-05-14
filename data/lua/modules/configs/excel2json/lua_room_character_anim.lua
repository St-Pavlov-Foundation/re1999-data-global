module("modules.configs.excel2json.lua_room_character_anim", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	animName = 2,
	upTime = 3,
	upDuration = 4,
	downDuration = 7,
	id = 1,
	downTime = 6,
	upDistance = 5,
	cameraState = 8
}
local var_0_2 = {
	"id",
	"animName"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
