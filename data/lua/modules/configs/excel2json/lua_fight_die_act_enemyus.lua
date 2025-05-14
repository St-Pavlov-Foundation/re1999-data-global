module("modules.configs.excel2json.lua_fight_die_act_enemyus", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	id = 1,
	act = 3,
	playEffect = 4,
	enemyus = 2
}
local var_0_2 = {
	"id",
	"enemyus"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
