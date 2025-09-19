module("modules.configs.excel2json.lua_story_mode_battle_field", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	heroGroupTypeId = 4,
	chapterMapIds = 5,
	chapterId = 1,
	fieldId = 2,
	episodeIds = 3
}
local var_0_2 = {
	"chapterId",
	"fieldId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
