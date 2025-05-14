module("modules.configs.excel2json.lua_skin_monster_hide_buff_effect", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	effectName = 2,
	exceptEffect = 3,
	skillId = 1
}
local var_0_2 = {
	"skillId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
