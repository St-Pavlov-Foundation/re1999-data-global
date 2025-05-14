module("modules.configs.excel2json.lua_instruction_level", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	picRes = 7,
	desc = 6,
	topicId = 2,
	instructionDesc = 4,
	id = 1,
	desc_en = 5,
	preEpisode = 8,
	episodeId = 3
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc = 2,
	instructionDesc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
