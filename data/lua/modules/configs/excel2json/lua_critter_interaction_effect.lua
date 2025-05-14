module("modules.configs.excel2json.lua_critter_interaction_effect", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	animName = 5,
	effectKey = 6,
	point = 3,
	skinId = 1,
	id = 2,
	effectRes = 4
}
local var_0_2 = {
	"skinId",
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
