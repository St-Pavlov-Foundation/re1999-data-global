module("modules.configs.excel2json.lua_character_limited", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	entranceEffect = 8,
	spineParam = 3,
	mvtime = 5,
	spine = 2,
	actionTime = 7,
	entranceMv = 4,
	specialInsightDesc = 12,
	voice = 6,
	audio = 10,
	stopAudio = 11,
	effectDuration = 9,
	specialLive2d = 13,
	id = 1
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	specialInsightDesc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
