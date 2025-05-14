module("modules.configs.excel2json.lua_reward_group", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	group = 2,
	materialId = 4,
	count = 5,
	shownum = 7,
	id = 1,
	label = 6,
	materialType = 3
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
