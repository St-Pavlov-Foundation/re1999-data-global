module("modules.configs.excel2json.lua_tower_permanent_time", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	stageId = 1,
	name = 3,
	time = 2,
	nameEn = 4
}
local var_0_2 = {
	"stageId"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
