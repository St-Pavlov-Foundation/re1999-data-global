module("modules.configs.excel2json.lua_auto_chess_master", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	unlockSkill = 7,
	name = 2,
	spUdimoGoodsId = 18,
	isSelf = 4,
	udimoCase = 16,
	spUdimo = 17,
	skillIcon = 12,
	skillId = 8,
	skillName = 11,
	skillDesc = 13,
	skillLockDesc = 15,
	roundTriggerCountLimit = 9,
	illustrationShow = 3,
	image = 6,
	totalTriggerCountLimit = 10,
	hp = 5,
	skillProgressDesc = 14,
	id = 1
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	name = 1,
	skillProgressDesc = 4,
	skillName = 2,
	skillDesc = 3,
	skillLockDesc = 5
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
