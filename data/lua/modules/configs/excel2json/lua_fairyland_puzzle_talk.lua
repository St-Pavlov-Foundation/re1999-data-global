module("modules.configs.excel2json.lua_fairyland_puzzle_talk", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	param = 4,
	audioId = 5,
	speaker = 6,
	type = 3,
	id = 1,
	elementId = 8,
	content = 7,
	step = 2
}
local var_0_2 = {
	"id",
	"step"
}
local var_0_3 = {
	speaker = 1,
	content = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
