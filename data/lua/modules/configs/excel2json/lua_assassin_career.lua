module("modules.configs.excel2json.lua_assassin_career", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	equipName = 3,
	pic = 6,
	capacity = 4,
	attrs = 5,
	title = 2,
	careerId = 1
}
local var_0_2 = {
	"careerId"
}
local var_0_3 = {
	equipName = 2,
	title = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
