module("modules.configs.excel2json.lua_talent_style", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	replaceCube = 4,
	name = 5,
	tagicon = 6,
	tag = 7,
	talentMould = 1,
	styleId = 2,
	color = 8,
	level = 3
}
local var_0_2 = {
	"talentMould",
	"styleId"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
