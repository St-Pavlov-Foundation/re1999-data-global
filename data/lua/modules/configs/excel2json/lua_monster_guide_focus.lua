module("modules.configs.excel2json.lua_monster_guide_focus", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	param = 3,
	invokeType = 2,
	completeWithGroup = 5,
	isActivityVersion = 7,
	id = 1,
	icon = 6,
	monster = 4,
	des = 8
}
local var_0_2 = {
	"id",
	"invokeType",
	"param",
	"monster"
}
local var_0_3 = {
	des = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
