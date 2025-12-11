module("modules.configs.excel2json.lua_hero_team", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	isDisplay = 7,
	name = 3,
	unlockId = 4,
	actType = 2,
	minNum = 10,
	maxNum = 11,
	supNum = 6,
	isChangeName = 8,
	id = 1,
	batNum = 5,
	sort = 9
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
