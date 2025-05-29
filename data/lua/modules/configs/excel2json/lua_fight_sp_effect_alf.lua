module("modules.configs.excel2json.lua_fight_sp_effect_alf", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	resName = 1,
	residualRes = 2,
	pullOutRes = 3,
	audioId = 4
}
local var_0_2 = {
	"resName"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
