module("modules.configs.excel2json.lua_activity148_skill_type", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	skillInfoDesc = 4,
	skillIcon = 5,
	skillValueDesc = 3,
	skillNameEn = 6,
	id = 1,
	skillName = 2
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	skillInfoDesc = 3,
	skillName = 1,
	skillValueDesc = 2,
	skillNameEn = 5,
	skillIcon = 4
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
