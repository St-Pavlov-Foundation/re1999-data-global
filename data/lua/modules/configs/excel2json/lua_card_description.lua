module("modules.configs.excel2json.lua_card_description", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	card2 = 4,
	card1 = 2,
	cardname_en = 5,
	cardname = 6,
	id = 1,
	carddescription2 = 8,
	carddescription1 = 7,
	attribute = 3
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	carddescription1 = 2,
	carddescription2 = 3,
	cardname = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
