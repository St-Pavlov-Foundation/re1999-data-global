module("modules.configs.excel2json.lua_sign_in_lifetime_bonus", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	logindaysid = 2,
	stagetitle = 3,
	bonus = 4,
	stageid = 1
}
local var_0_2 = {
	"stageid"
}
local var_0_3 = {
	stagetitle = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
