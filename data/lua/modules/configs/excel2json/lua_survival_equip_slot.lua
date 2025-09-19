module("modules.configs.excel2json.lua_survival_equip_slot", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	effect1 = 10,
	slot3 = 4,
	slot6 = 7,
	slot1 = 2,
	slot4 = 5,
	slot7 = 8,
	slot2 = 3,
	id = 1,
	slot5 = 6,
	slot8 = 9
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
