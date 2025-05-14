module("modules.configs.excel2json.lua_card_indicator", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	defaultValue = 4,
	desc = 3,
	valueRange = 5,
	takeTypeParam1 = 7,
	takeTypeParam2 = 9,
	takeType3 = 10,
	takeTypeParam3 = 11,
	takeType1 = 6,
	id = 1,
	takeType2 = 8,
	identity = 2
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
