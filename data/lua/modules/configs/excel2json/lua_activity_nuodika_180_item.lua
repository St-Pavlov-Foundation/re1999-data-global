module("modules.configs.excel2json.lua_activity_nuodika_180_item", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	itemId = 1,
	name = 2,
	canMove = 6,
	canEmpty = 7,
	skillID = 8,
	picture = 4,
	pictureOffset = 5,
	desc = 3
}
local var_0_2 = {
	"itemId"
}
local var_0_3 = {
	desc = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
