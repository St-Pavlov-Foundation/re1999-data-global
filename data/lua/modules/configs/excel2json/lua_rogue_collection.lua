module("modules.configs.excel2json.lua_rogue_collection", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	skills = 12,
	name = 2,
	group = 10,
	type = 3,
	eventGroupWeights = 17,
	dropGroupWeights = 19,
	unlockTask = 20,
	desc = 13,
	inHandBook = 21,
	statetype = 8,
	icon = 9,
	spdesc = 14,
	attr = 11,
	shopWeights = 18,
	holeNum = 6,
	showRare = 5,
	rare = 4,
	unique = 7,
	heartbeatRange = 15,
	eventWeights = 16,
	id = 1
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	name = 1,
	spdesc = 3,
	desc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
