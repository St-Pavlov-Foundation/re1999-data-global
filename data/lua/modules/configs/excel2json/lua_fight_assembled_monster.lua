module("modules.configs.excel2json.lua_fight_assembled_monster", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	clickIndex = 6,
	virtualStance = 3,
	part = 2,
	hpPos = 8,
	id = 1,
	virtualSpineSize = 5,
	selectPos = 7,
	virtualSpinePos = 4
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
