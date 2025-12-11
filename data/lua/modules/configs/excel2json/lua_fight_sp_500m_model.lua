module("modules.configs.excel2json.lua_fight_sp_500m_model", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	headIcon = 5,
	behind = 4,
	headIconName = 6,
	front = 2,
	monsterId = 1,
	center = 3
}
local var_0_2 = {
	"monsterId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
