module("modules.configs.excel2json.lua_character_destiny_slots", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	node = 3,
	effect = 5,
	consume = 4,
	stage = 2,
	slotsId = 1
}
local var_0_2 = {
	"slotsId",
	"stage",
	"node"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
