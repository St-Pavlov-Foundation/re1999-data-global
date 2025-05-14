module("modules.configs.excel2json.lua_activity168_info", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	clueNumber = 6,
	name = 3,
	infoId = 1,
	icon = 4,
	episode = 2,
	desc = 5
}
local var_0_2 = {
	"infoId"
}
local var_0_3 = {
	desc = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
