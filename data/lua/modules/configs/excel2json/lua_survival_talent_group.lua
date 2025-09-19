module("modules.configs.excel2json.lua_survival_talent_group", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	slot2 = 11,
	name = 2,
	desc = 9,
	align = 19,
	slot1 = 10,
	slot4 = 13,
	initTalents = 18,
	slot7 = 16,
	icon = 7,
	folder = 5,
	versions = 3,
	slot3 = 12,
	slot6 = 15,
	activeIcon = 6,
	border = 20,
	seasons = 4,
	id = 1,
	slot5 = 14,
	choose = 8,
	slot8 = 17
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
