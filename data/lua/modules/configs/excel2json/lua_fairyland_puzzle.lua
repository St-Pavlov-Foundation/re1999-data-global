module("modules.configs.excel2json.lua_fairyland_puzzle", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	id = 1,
	afterTalkId = 5,
	errorTalkId = 8,
	beforeTalkId = 4,
	storyTalkId = 9,
	elementId = 3,
	successTalkId = 6,
	tipsTalkId = 7,
	answer = 2
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
