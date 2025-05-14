module("modules.configs.excel2json.lua_boss_action", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	battleId = 1,
	monsterId = 2,
	monsterSpeed = 3,
	actionId = 4
}
local var_0_2 = {
	"battleId",
	"monsterId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
