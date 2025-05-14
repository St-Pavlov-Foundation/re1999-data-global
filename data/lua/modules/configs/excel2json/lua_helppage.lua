module("modules.configs.excel2json.lua_helppage", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	text = 4,
	icon = 5,
	unlockGuideId = 7,
	type = 3,
	id = 1,
	title = 2,
	isCn = 8,
	iconText = 6
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	title = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
