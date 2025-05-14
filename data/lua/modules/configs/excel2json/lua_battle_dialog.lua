module("modules.configs.excel2json.lua_battle_dialog", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	param = 3,
	icon = 7,
	canRepeat = 4,
	random = 6,
	delay = 11,
	text = 9,
	insideRepeat = 5,
	audioId = 8,
	id = 2,
	code = 1,
	tipsDir = 10
}
local var_0_2 = {
	"code",
	"id"
}
local var_0_3 = {
	text = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
