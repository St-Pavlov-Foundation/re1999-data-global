module("modules.configs.excel2json.lua_story_audio_branch", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	bankName = 3,
	eventName_Overseas = 4,
	bankName_Overseas = 5,
	eventName = 2,
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
