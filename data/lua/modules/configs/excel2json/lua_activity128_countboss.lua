module("modules.configs.excel2json.lua_activity128_countboss", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	battleId = 1,
	monsterId = 2,
	maxPoints = 4,
	finalMonsterId = 3
}
local var_0_2 = {
	"battleId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
