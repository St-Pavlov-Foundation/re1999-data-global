module("modules.configs.excel2json.lua_fight_monster_skin_idle_map", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	freezeAnimName = 4,
	idleAnimName = 2,
	skinId = 1,
	sleepAnimName = 5,
	hitAnimName = 3
}
local var_0_2 = {
	"skinId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
