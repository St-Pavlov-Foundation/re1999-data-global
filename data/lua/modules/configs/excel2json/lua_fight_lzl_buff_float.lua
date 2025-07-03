module("modules.configs.excel2json.lua_fight_lzl_buff_float", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	effectRoot = 4,
	effect = 3,
	effectAudio = 5,
	id = 1,
	duration = 6,
	layer = 2
}
local var_0_2 = {
	"id",
	"layer"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
