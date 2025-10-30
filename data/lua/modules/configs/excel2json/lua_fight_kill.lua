module("modules.configs.excel2json.lua_fight_kill", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	audio = 4,
	effect = 2,
	skinId = 1,
	effectHangPoint = 3,
	duration = 5,
	waitTime = 6
}
local var_0_2 = {
	"skinId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
