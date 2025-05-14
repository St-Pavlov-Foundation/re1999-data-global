module("modules.configs.excel2json.lua_v2a4_warmup_photo_item_list", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	imgName = 3,
	yes3 = 12,
	yes1 = 8,
	passTalkAllYes = 5,
	yes2 = 10,
	no2 = 11,
	preTalk = 4,
	passTalk = 6,
	failTalk = 7,
	no3 = 13,
	id = 1,
	no1 = 9,
	level = 2
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
