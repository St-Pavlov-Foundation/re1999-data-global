module("modules.configs.excel2json.lua_fight_ui_style", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	itemId = 4,
	sort = 5,
	image = 6,
	type = 2,
	showres = 9,
	banner = 8,
	previewImage = 7,
	id = 1,
	defaultUnlock = 3
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
