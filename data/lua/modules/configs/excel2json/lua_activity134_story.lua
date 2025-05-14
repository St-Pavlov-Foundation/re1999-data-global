module("modules.configs.excel2json.lua_activity134_story", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	storyType = 2,
	charaterIcon = 4,
	id = 1,
	formMan = 5,
	desc = 3
}
local var_0_2 = {
	"id",
	"storyType"
}
local var_0_3 = {
	formMan = 2,
	desc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
