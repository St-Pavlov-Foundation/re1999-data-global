module("modules.configs.excel2json.lua_character_recommend", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	equipRec = 4,
	teamDisplay = 3,
	resonanceRec = 7,
	lvRec = 6,
	id = 1,
	equipDisplay = 5,
	teamRec = 2
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
