module("modules.configs.excel2json.lua_critter_tag_effect", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	catalogue = 3,
	target = 2,
	previewCondition = 5,
	type = 6,
	id = 1,
	parameter = 7,
	condition = 4
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
