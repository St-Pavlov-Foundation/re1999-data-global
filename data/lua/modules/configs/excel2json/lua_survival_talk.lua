module("modules.configs.excel2json.lua_survival_talk", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	id = 1,
	animType = 4,
	content = 3,
	step = 2
}
local var_0_2 = {
	"id",
	"step"
}
local var_0_3 = {
	content = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
