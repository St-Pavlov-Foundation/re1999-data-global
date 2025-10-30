module("modules.configs.excel2json.lua_fight_sp_wuerlixi_monster_star_effect", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	bornEffectDuration = 5,
	effect = 2,
	buffId = 1,
	disAppearEffectDuration = 7,
	disAppearEffect = 6,
	bornEffect = 4,
	height = 3
}
local var_0_2 = {
	"buffId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
