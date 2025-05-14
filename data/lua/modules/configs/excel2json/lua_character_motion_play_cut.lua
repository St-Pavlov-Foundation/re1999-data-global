module("modules.configs.excel2json.lua_character_motion_play_cut", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	whenStopped = 4,
	heroId = 1,
	skinId = 2,
	whenNotStopped = 5,
	motion = 3
}
local var_0_2 = {
	"heroId",
	"skinId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
