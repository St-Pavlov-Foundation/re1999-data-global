module("modules.configs.excel2json.lua_fight_common_buff_effect_2_skin", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	audio = 5,
	effectHang = 3,
	buffId = 1,
	skinId = 2,
	duration = 6,
	effectPath = 4
}
local var_0_2 = {
	"buffId",
	"skinId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
