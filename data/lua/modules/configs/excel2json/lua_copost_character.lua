module("modules.configs.excel2json.lua_copost_character", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	chaName = 3,
	chaPicture = 2,
	chaId = 1
}
local var_0_2 = {
	"chaId"
}
local var_0_3 = {
	chaName = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
