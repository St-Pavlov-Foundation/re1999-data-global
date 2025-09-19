module("modules.configs.excel2json.lua_fight_luxi_upgrade_effect", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	effect = 5,
	effectType = 3,
	buffId = 2,
	countOffset = 4,
	id = 1,
	effectHangPoint = 6,
	audio = 7
}
local var_0_2 = {
	"id",
	"buffId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
