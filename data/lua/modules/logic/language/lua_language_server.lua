module("modules.logic.language.lua_language_server", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	content = 2,
	key = 1
}
local var_0_2 = {
	"key"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
