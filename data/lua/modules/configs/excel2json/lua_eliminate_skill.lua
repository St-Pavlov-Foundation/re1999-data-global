module("modules.configs.excel2json.lua_eliminate_skill", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	skillDes = 3,
	skillName = 2,
	skillId = 1
}
local var_0_2 = {
	"skillId"
}
local var_0_3 = {
	skillDes = 2,
	skillName = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
