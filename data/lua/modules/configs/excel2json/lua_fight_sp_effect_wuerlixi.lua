module("modules.configs.excel2json.lua_fight_sp_effect_wuerlixi", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	hangPoint = 4,
	effect = 3,
	channelHangPoint = 5,
	skinId = 2,
	buffTypeId = 1
}
local var_0_2 = {
	"buffTypeId",
	"skinId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
