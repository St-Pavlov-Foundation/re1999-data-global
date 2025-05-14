module("modules.configs.excel2json.lua_rouge_map_skill", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	icon = 9,
	stepCd = 5,
	middleLayerLimit = 10,
	desc = 8,
	effects = 7,
	coinCost = 4,
	id = 1,
	version = 2,
	powerCost = 3,
	useLimit = 6
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
