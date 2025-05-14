module("modules.configs.excel2json.lua_block_package", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	blockBuildDegree = 12,
	name = 2,
	useDesc = 3,
	free = 11,
	sources = 10,
	showOnly = 13,
	rare = 7,
	desc = 4,
	sourcesType = 9,
	id = 1,
	icon = 5,
	rewardIcon = 6,
	nameEn = 8
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	name = 1,
	useDesc = 2,
	desc = 3
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
