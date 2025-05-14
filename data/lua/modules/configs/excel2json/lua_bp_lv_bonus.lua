module("modules.configs.excel2json.lua_bp_lv_bonus", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	selfSelectPayItem = 9,
	spFreeBonus = 6,
	selfSelectPayBonus = 8,
	payBonus = 4,
	keyBonus = 5,
	bpId = 1,
	spPayBonus = 7,
	freeBonus = 3,
	level = 2
}
local var_0_2 = {
	"bpId",
	"level"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
