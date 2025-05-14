module("modules.configs.excel2json.lua_rouge_fight_event", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	interactive = 7,
	title = 2,
	versionInteractive = 9,
	type = 3,
	versionEvent = 10,
	advanceInteractive = 8,
	bossMask = 13,
	episodeId = 4,
	versionEpisode = 5,
	monsterMask = 12,
	id = 1,
	isChangeScene = 11,
	bossDesc = 14,
	episodeIdInstead = 6
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	bossDesc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
