module("modules.configs.excel2json.lua_setting_lang", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	fontasset2 = 4,
	lang = 2,
	textfontasset1 = 5,
	textfontasset2 = 6,
	shortcuts = 1,
	fontasset1 = 3
}
local var_0_2 = {
	"shortcuts"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
