module("modules.configs.excel2json.lua_help_page_tab", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	parentId = 2,
	title_en = 5,
	sortIdx = 3,
	showType = 6,
	id = 1,
	title = 4,
	helpId = 7
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	title_en = 2,
	title = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
