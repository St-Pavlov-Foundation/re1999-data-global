module("modules.configs.excel2json.lua_explore_unit_effect", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	prefabPath = 1,
	isLoopAudio = 7,
	audioId = 5,
	isBindGo = 6,
	animName = 2,
	effectPath = 3,
	isOnce = 4
}
local var_0_2 = {
	"prefabPath",
	"animName"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
