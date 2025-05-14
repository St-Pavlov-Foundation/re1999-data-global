module("modules.configs.excel2json.lua_fight_replace_timeline", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	condition = 6,
	priority = 3,
	timeline = 2,
	id = 1,
	target = 4,
	simulate = 5
}
local var_0_2 = {
	"id",
	"timeline"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
