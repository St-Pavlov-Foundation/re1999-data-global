module("modules.configs.excel2json.lua_talent_mould", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	type11 = 5,
	type19 = 13,
	talentMould = 2,
	type14 = 8,
	type12 = 6,
	type17 = 11,
	type15 = 9,
	type20 = 14,
	type10 = 4,
	type13 = 7,
	type18 = 12,
	allShape = 3,
	talentId = 1,
	type16 = 10
}
local var_0_2 = {
	"talentId",
	"talentMould"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
