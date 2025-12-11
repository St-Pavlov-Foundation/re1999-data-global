module("modules.configs.excel2json.lua_survival_end", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	endImg = 7,
	name = 2,
	mainImg = 9,
	type = 3,
	group = 4,
	unlock = 6,
	endDesc = 5,
	id = 1,
	order = 8
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
