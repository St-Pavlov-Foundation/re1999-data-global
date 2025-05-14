module("modules.configs.excel2json.lua_fight_sp_effect_ly", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	spine1EffectRes = 5,
	spine2Res = 6,
	fadeAudioId = 9,
	spine1Res = 4,
	pos = 3,
	path = 2,
	audioId = 8,
	spine2EffectRes = 7,
	id = 1
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
