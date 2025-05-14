module("modules.configs.excel2json.lua_character_data", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	skinId = 3,
	lockText = 11,
	unlockConditine = 12,
	type = 4,
	isCustom = 14,
	title = 6,
	unlockRewards = 13,
	number = 5,
	text = 8,
	heroId = 1,
	titleEn = 7,
	id = 2,
	icon = 9,
	estimate = 10
}
local var_0_2 = {
	"heroId",
	"id"
}
local var_0_3 = {
	text = 2,
	title = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
