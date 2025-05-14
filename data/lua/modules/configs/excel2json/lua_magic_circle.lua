module("modules.configs.excel2json.lua_magic_circle", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	enemySkills = 10,
	enterTime = 15,
	selfSkills = 9,
	closeTime = 19,
	name = 2,
	enterAudio = 16,
	endSkills = 13,
	desc = 3,
	consumeType = 5,
	selfAttrs = 7,
	closeAudio = 21,
	enemyBuff = 12,
	enemyAttrs = 8,
	selfBuff = 11,
	closeEffect = 18,
	enterEffect = 14,
	posArr = 22,
	round = 4,
	loopEffect = 17,
	id = 1,
	consumeNum = 6,
	closeAniName = 20
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
