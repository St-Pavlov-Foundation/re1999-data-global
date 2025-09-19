module("modules.configs.excel2json.lua_activity_nuodika_180_enemy", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	enemyId = 1,
	name = 2,
	eventID = 10,
	main = 6,
	mapID = 11,
	picture = 4,
	desc = 3,
	skillID = 9,
	hp = 7,
	atk = 8,
	pictureOffset = 5
}
local var_0_2 = {
	"enemyId"
}
local var_0_3 = {
	desc = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
