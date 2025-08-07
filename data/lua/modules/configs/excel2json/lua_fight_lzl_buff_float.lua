module("modules.configs.excel2json.lua_fight_lzl_buff_float", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	effectRoot = 5,
	effect = 4,
	effectAudio = 6,
	skinId = 3,
	id = 1,
	duration = 7,
	layer = 2
}
local var_0_2 = {
	"id",
	"layer",
	"skinId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
