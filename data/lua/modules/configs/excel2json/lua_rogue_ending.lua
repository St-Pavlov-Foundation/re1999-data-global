module("modules.configs.excel2json.lua_rogue_ending", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	endingDesc = 6,
	resultIcon = 5,
	storyId = 3,
	id = 1,
	title = 2,
	endingIcon = 4
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	endingDesc = 2,
	title = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
