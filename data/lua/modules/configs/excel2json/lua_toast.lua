module("modules.configs.excel2json.lua_toast", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	audioId = 4,
	tips = 2,
	notMerge = 5,
	notShow = 6,
	id = 1,
	icon = 3
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	tips = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
