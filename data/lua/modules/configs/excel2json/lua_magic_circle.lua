module("modules.configs.excel2json.lua_magic_circle", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	consumeNum = 7,
	enterTime = 16,
	selfSkills = 10,
	closeTime = 20,
	enemySkills = 11,
	enterAudio = 17,
	endSkills = 14,
	desc = 3,
	name = 2,
	consumeType = 6,
	selfAttrs = 8,
	closeAudio = 22,
	enemyBuff = 13,
	enemyAttrs = 9,
	selfBuff = 12,
	closeEffect = 19,
	enterEffect = 15,
	posArr = 23,
	round = 5,
	loopEffect = 18,
	id = 1,
	uiType = 4,
	closeAniName = 21
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
