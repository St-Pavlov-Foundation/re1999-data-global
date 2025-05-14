module("modules.configs.excel2json.lua_chapter_map_element", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	mapId = 2,
	flagText = 18,
	desc = 17,
	type = 12,
	res = 5,
	title = 16,
	pos = 3,
	resScale = 6,
	acceptText = 19,
	finishText = 20,
	dispatchingText = 21,
	showCamera = 10,
	showArrow = 11,
	reward = 22,
	rewardPoint = 23,
	permanentReward = 24,
	param = 13,
	effect = 8,
	fragment = 26,
	holeSize = 25,
	retroReward = 27,
	condition = 9,
	tipOffsetPos = 7,
	paramCn = 14,
	offsetPos = 4,
	id = 1,
	paramLang = 15
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc = 4,
	paramCn = 1,
	flagText = 5,
	acceptText = 6,
	finishText = 7,
	title = 3,
	dispatchingText = 8,
	paramLang = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
