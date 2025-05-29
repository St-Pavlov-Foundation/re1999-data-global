module("modules.configs.excel2json.lua_weekwalk_ver2_element", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	isBoss = 7,
	smokeMaskOffset = 12,
	lightOffsetPos = 11,
	type = 2,
	disappearEffect = 17,
	skipFinish = 4,
	pos = 14,
	desc = 13,
	roundId = 5,
	param = 3,
	effect = 16,
	starOffsetPos = 10,
	tipOffsetPos = 15,
	res = 6,
	generalType = 9,
	id = 1,
	bonusGroup = 8
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
