module("modules.configs.excel2json.lua_tower_boss", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	bossId = 2,
	name = 3,
	nameEn = 4,
	towerId = 1
}
local var_0_2 = {
	"towerId"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
