module("modules.configs.excel2json.lua_character_rank", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	requirement = 4,
	heroId = 1,
	rank = 2,
	consume = 3,
	effect = 5
}
local var_0_2 = {
	"heroId",
	"rank"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
