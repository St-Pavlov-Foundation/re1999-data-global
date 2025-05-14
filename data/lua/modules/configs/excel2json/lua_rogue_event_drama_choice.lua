module("modules.configs.excel2json.lua_rogue_event_drama_choice", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	dialogId = 7,
	event = 9,
	collection = 10,
	type = 2,
	group = 3,
	title = 5,
	condition = 4,
	desc = 6,
	id = 1,
	icon = 8
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc = 2,
	title = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
