module("modules.configs.excel2json.lua_main_ui_skin", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	iconAnchor = 4,
	name = 7,
	showChild = 8,
	skinId = 2,
	id = 1,
	icon = 3,
	iconRotate = 5,
	isLangBg = 6
}
local var_0_2 = {
	"id",
	"skinId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
