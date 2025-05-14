module("modules.configs.excel2json.lua_v2a4_warmup_text_item_list", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	yes2 = 12,
	yes3 = 15,
	no3 = 16,
	info2 = 11,
	yes5 = 21,
	info4 = 17,
	yes6 = 24,
	yes4 = 18,
	passTalkAllYes = 5,
	info3 = 14,
	imgName = 3,
	no5 = 22,
	passTalk = 6,
	no4 = 19,
	no6 = 25,
	level = 2,
	yes1 = 9,
	no2 = 13,
	info5 = 20,
	preTalk = 4,
	failTalk = 7,
	info6 = 23,
	id = 1,
	info1 = 8,
	no1 = 10
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
