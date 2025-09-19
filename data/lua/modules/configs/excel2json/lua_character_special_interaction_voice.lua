module("modules.configs.excel2json.lua_character_special_interaction_voice", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	timeoutVoice = 4,
	protectionTime = 5,
	time = 2,
	id = 1,
	statusParams = 6,
	waitVoice = 3
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
