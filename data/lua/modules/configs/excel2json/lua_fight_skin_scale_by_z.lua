module("modules.configs.excel2json.lua_fight_skin_scale_by_z", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	posZ = 3,
	priority = 2,
	posXOffset = 5,
	id = 1,
	scale = 4
}
local var_0_2 = {
	"id",
	"priority"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
