module("modules.configs.excel2json.lua_fight_technique", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	title_cn = 7,
	iconShow = 9,
	picture1 = 10,
	picture2 = 11,
	mainTitleId = 2,
	noDisplayType = 15,
	condition = 4,
	displayType = 14,
	isCn = 13,
	title_en = 8,
	mainTitle_en = 6,
	mainTitle_cn = 5,
	id = 1,
	content1 = 12,
	subTitleId = 3
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	title_cn = 3,
	content1 = 4,
	mainTitle_en = 2,
	mainTitle_cn = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
