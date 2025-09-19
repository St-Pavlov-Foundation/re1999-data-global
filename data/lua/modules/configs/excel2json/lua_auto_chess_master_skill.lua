module("modules.configs.excel2json.lua_auto_chess_master_skill", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	cost = 2,
	abilities = 6,
	targetType = 11,
	activeChessSkill = 5,
	passiveChessSkills = 4,
	skillIndex = 9,
	type = 3,
	skillaction = 7,
	useeffect = 8,
	id = 1,
	needTarget = 10
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
