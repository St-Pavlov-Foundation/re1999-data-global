module("modules.configs.excel2json.lua_card_enchant", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	feature = 7,
	id = 1,
	excludeTypes = 3,
	coverType = 2,
	rejectTypes = 4,
	stage = 5,
	desc = 8,
	decStage = 6
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
