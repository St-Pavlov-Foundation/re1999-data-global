module("modules.configs.excel2json.lua_activity166_word_effect_pos", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	id = 2,
	pos = 3,
	activityId = 1
}
local var_0_2 = {
	"activityId",
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
