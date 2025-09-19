module("modules.configs.excel2json.lua_single_mode_episode", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	openDay = 3,
	episodeId2Level = 4,
	activityId = 2,
	chapterId = 1
}
local var_0_2 = {
	"chapterId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
