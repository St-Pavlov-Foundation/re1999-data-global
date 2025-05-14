module("modules.configs.excel2json.lua_rouge_illustration_list", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	nameEn = 5,
	name = 4,
	eventId = 9,
	fullImage = 8,
	season = 1,
	image = 7,
	desc = 6,
	dlc = 10,
	id = 2,
	order = 3
}
local var_0_2 = {
	"season",
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
