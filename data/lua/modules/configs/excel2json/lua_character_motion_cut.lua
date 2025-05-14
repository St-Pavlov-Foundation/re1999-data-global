module("modules.configs.excel2json.lua_character_motion_cut", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	onlyStopCut = 4,
	heroId = 1,
	motion = 3,
	skinId = 2
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
