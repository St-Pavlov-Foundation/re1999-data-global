module("modules.configs.excel2json.lua_fight_eziozhuangbei", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	skillEx = 9,
	passiveSkill = 6,
	firstId = 1,
	secondId = 2,
	skillGroup1 = 7,
	skillGroup2 = 8,
	skillLevel = 3,
	secondDesc = 5,
	firstDesc = 4,
	exchangeSkills = 10
}
local var_0_2 = {
	"firstId",
	"secondId",
	"skillLevel"
}
local var_0_3 = {
	secondDesc = 2,
	firstDesc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
