module("modules.configs.excel2json.lua_chapter_map_element_dialog", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	param = 4,
	stepId = 2,
	audio = 5,
	type = 3,
	id = 1,
	speaker = 6,
	content = 7
}
local var_0_2 = {
	"id",
	"stepId"
}
local var_0_3 = {
	speaker = 1,
	content = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
