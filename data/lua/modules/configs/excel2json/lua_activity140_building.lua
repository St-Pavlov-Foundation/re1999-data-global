module("modules.configs.excel2json.lua_activity140_building", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	cost = 6,
	name = 7,
	skilldesc = 5,
	type = 4,
	group = 3,
	focusPos = 12,
	pos = 11,
	desc = 13,
	previewImg = 9,
	id = 1,
	icon = 10,
	activityId = 2,
	nameEn = 8
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	name = 2,
	skilldesc = 1,
	desc = 3
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
