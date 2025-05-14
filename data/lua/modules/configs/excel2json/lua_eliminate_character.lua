module("modules.configs.excel2json.lua_eliminate_character", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	resPic = 4,
	name = 2,
	hp = 3,
	characterId = 1,
	skillName1 = 5,
	skillName2 = 6,
	defaultUnlock = 7
}
local var_0_2 = {
	"characterId"
}
local var_0_3 = {
	skillName1 = 2,
	name = 1,
	skillName2 = 3
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
