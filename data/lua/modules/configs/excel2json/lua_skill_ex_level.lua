module("modules.configs.excel2json.lua_skill_ex_level", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	skillEx = 8,
	passiveSkill = 9,
	desc = 5,
	skillGroup1 = 6,
	requirement = 4,
	skillGroup2 = 7,
	skillLevel = 2,
	heroId = 1,
	consume2 = 10,
	consume = 3
}
local var_0_2 = {
	"heroId",
	"skillLevel"
}
local var_0_3 = {
	desc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
