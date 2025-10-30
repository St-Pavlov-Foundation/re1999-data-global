module("modules.configs.excel2json.lua_copost_npc", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	weight = 4,
	time = 5,
	id = 1,
	condition = 3,
	textId = 2
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
