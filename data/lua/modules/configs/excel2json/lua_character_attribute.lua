module("modules.configs.excel2json.lua_character_attribute", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	showType = 8,
	attrType = 2,
	name = 4,
	type = 3,
	showcolor = 9,
	sortId = 11,
	desc = 5,
	isShowTips = 6,
	id = 1,
	icon = 10,
	isShow = 7
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
