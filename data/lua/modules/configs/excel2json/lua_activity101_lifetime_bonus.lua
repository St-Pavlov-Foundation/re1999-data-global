module("modules.configs.excel2json.lua_activity101_lifetime_bonus", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	stagetitle = 4,
	bonus = 5,
	stagename = 3,
	logindaysid = 2,
	stagepriceid = 1
}
local var_0_2 = {
	"stagepriceid"
}
local var_0_3 = {
	stagename = 1,
	stagetitle = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
