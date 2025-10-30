module("modules.configs.excel2json.lua_activity104_story", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	id = 1,
	picture = 5,
	subTitle = 6,
	storyId = 2,
	condition = 9,
	title = 3,
	content = 8,
	titleEn = 4,
	subContent = 7
}
local var_0_2 = {
	"id",
	"storyId"
}
local var_0_3 = {
	subTitle = 3,
	titleEn = 2,
	subContent = 4,
	title = 1,
	content = 5
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
