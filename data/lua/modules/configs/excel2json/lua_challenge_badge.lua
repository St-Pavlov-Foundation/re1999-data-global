module("modules.configs.excel2json.lua_challenge_badge", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	rule = 3,
	unlockSupport = 5,
	num = 2,
	activityId = 1,
	decs = 4
}
local var_0_2 = {
	"activityId",
	"num"
}
local var_0_3 = {
	decs = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
