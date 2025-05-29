module("modules.configs.excel2json.lua_dice_dialogue", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	speaker = 3,
	desc = 4,
	line = 5,
	type = 6,
	id = 1,
	step = 2
}
local var_0_2 = {
	"id",
	"step"
}
local var_0_3 = {
	speaker = 1,
	desc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
