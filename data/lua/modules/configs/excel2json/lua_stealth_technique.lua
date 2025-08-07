module("modules.configs.excel2json.lua_stealth_technique", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	mainTitleId = 2,
	picture = 6,
	subTitle = 5,
	showInMap = 8,
	id = 1,
	mainTitle = 4,
	content = 7,
	subTitleId = 3
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	content = 3,
	mainTitle = 1,
	subTitle = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
