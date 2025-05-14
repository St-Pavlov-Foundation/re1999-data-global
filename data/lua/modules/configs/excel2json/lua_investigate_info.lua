module("modules.configs.excel2json.lua_investigate_info", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	icon = 6,
	name = 5,
	conclusionDesc = 11,
	conclusionBg = 10,
	group = 3,
	unlockDesc = 7,
	episode = 2,
	desc = 8,
	clueNumber = 9,
	id = 1,
	entrance = 4
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	unlockDesc = 2,
	name = 1,
	conclusionDesc = 4,
	desc = 3
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
