module("modules.configs.excel2json.lua_character_grow", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	technic = 7,
	def = 5,
	hp = 3,
	atk = 4,
	id = 1,
	icon = 2,
	mdef = 6
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
