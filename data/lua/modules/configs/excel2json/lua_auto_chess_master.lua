module("modules.configs.excel2json.lua_auto_chess_master", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	roundTriggerCountLimit = 8,
	name = 2,
	unlockSkill = 6,
	isSelf = 3,
	skillIcon = 11,
	image = 5,
	skillProgressDesc = 13,
	totalTriggerCountLimit = 9,
	hp = 4,
	skillId = 7,
	id = 1,
	skillName = 10,
	skillDesc = 12,
	skillLockDesc = 14
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
