module("modules.configs.excel2json.lua_turnback_submodule", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	jumpId = 7,
	name = 3,
	reddotId = 8,
	actDesc = 5,
	id = 1,
	turnbackId = 2,
	showInPopup = 6,
	nameEn = 4
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	actDesc = 3,
	name = 1,
	nameEn = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
