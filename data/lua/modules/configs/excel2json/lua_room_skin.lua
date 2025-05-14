module("modules.configs.excel2json.lua_room_skin", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	bannerIcon = 8,
	activity = 6,
	name = 5,
	type = 2,
	itemId = 4,
	priority = 11,
	rare = 10,
	desc = 9,
	equipEffPos = 14,
	sources = 15,
	model = 12,
	id = 1,
	icon = 7,
	equipEffSize = 13,
	buildId = 3
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
