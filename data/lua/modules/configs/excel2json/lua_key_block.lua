module("modules.configs.excel2json.lua_key_block", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	name = 2,
	hud = 1,
	blockkey = 3
}
local var_0_2 = {
	"hud"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
