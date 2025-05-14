module("modules.configs.excel2json.lua_achievement", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	startTime = 8,
	name = 5,
	endTime = 9,
	groupId = 3,
	uiPlayerParam = 6,
	category = 2,
	id = 1,
	isMask = 7,
	order = 4
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
