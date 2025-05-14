module("modules.configs.excel2json.lua_activity174_test_bot", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	collection3 = 9,
	collection4 = 10,
	count = 2,
	collection1 = 7,
	costCoin = 12,
	role3 = 5,
	enhance = 11,
	role1 = 3,
	collection2 = 8,
	role4 = 6,
	robotId = 1,
	role2 = 4
}
local var_0_2 = {
	"robotId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
