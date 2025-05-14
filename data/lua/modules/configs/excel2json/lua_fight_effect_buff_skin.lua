module("modules.configs.excel2json.lua_fight_effect_buff_skin", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	orEnemy = 2,
	effectHang = 4,
	buffId = 1,
	skinId = 3,
	delEffect = 7,
	triggerEffect = 6,
	effectPath = 5,
	audio = 8
}
local var_0_2 = {
	"buffId",
	"orEnemy",
	"skinId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
