module("modules.configs.excel2json.lua_lucky_bag_heroes", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	heroChoices = 3,
	name = 4,
	nameEn = 5,
	sceneIcon = 7,
	icon = 6,
	bagId = 2,
	poolId = 1
}
local var_0_2 = {
	"poolId",
	"bagId"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
