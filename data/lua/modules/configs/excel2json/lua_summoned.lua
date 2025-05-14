module("modules.configs.excel2json.lua_summoned", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	group = 4,
	enterTime = 14,
	includeTypes = 5,
	closeTime = 15,
	enterAudio = 16,
	aniEffect = 10,
	maxLevel = 3,
	skills = 6,
	uniqueSkills = 7,
	closeAudio = 17,
	level = 2,
	stanceId = 9,
	closeEffect = 13,
	enterEffect = 11,
	additionRule = 8,
	loopEffect = 12,
	id = 1
}
local var_0_2 = {
	"id",
	"level"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
