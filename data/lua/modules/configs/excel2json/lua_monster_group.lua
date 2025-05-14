module("modules.configs.excel2json.lua_monster_group", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	bossId = 8,
	stanceId = 7,
	bgm = 10,
	appearMonsterId = 11,
	sp2Monster = 5,
	appearTimeline = 12,
	sp2Supporter = 6,
	spMonster = 3,
	appearCameraPos = 13,
	aiId = 9,
	spSupporter = 4,
	id = 1,
	monster = 2
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
