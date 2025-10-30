module("modules.configs.excel2json.lua_fight_sp_wuerlixi_monster_star_position_offset", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	offsetY = 3,
	monsterId = 1,
	offsetX = 2
}
local var_0_2 = {
	"monsterId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
