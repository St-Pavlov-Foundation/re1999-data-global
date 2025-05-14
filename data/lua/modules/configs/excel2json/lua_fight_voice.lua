module("modules.configs.excel2json.lua_fight_voice", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	audio_type3 = 4,
	audio_type9 = 10,
	audio_type4 = 5,
	skinId = 1,
	audio_type1 = 2,
	audio_type10 = 11,
	audio_type2 = 3,
	audio_type7 = 8,
	audio_type8 = 9,
	audio_type5 = 6,
	audio_type6 = 7
}
local var_0_2 = {
	"skinId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
