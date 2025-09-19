module("modules.configs.excel2json.lua_survival_end", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	endImg = 6,
	endDesc = 4,
	name = 2,
	type = 3,
	id = 1,
	order = 7,
	mainImg = 8,
	unlock = 5
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	endDesc = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
