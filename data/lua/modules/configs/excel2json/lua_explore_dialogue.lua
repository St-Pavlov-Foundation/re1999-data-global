module("modules.configs.excel2json.lua_explore_dialogue", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	refuseButton = 8,
	bonusButton = 9,
	selectButton = 10,
	audio = 5,
	picture = 11,
	interrupt = 3,
	desc = 6,
	speaker = 4,
	id = 1,
	acceptButton = 7,
	stepid = 2
}
local var_0_2 = {
	"id",
	"stepid"
}
local var_0_3 = {
	refuseButton = 4,
	speaker = 1,
	bonusButton = 5,
	selectButton = 6,
	acceptButton = 3,
	desc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
