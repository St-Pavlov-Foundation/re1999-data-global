module("modules.configs.excel2json.lua_weekwalk_question", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	text = 2,
	select3 = 5,
	select2 = 4,
	id = 1,
	select1 = 3
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	text = 1,
	select1 = 2,
	select3 = 4,
	select2 = 3
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
