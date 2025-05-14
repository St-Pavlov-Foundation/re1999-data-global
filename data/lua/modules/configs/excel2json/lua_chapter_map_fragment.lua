module("modules.configs.excel2json.lua_chapter_map_fragment", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	toastId = 6,
	res = 3,
	type = 4,
	id = 1,
	title = 2,
	content = 5
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	content = 2,
	title = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
