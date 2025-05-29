module("modules.configs.excel2json.lua_fight_sp_effect_alf_timeline", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	timeline_2 = 2,
	timeline_3 = 3,
	timeline_4 = 4,
	skinId = 1
}
local var_0_2 = {
	"skinId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
