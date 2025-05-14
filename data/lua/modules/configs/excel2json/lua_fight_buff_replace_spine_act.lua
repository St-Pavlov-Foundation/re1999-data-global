module("modules.configs.excel2json.lua_fight_buff_replace_spine_act", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	combination = 4,
	priority = 3,
	buffId = 2,
	id = 1,
	suffix = 5
}
local var_0_2 = {
	"id",
	"buffId",
	"priority"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
