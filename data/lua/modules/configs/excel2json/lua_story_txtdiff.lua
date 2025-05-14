module("modules.configs.excel2json.lua_story_txtdiff", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	kr = 6,
	de = 8,
	cn = 3,
	tw = 4,
	thai = 10,
	fr = 9,
	en = 5,
	jp = 7,
	id = 1,
	lanType = 2
}
local var_0_2 = {
	"id",
	"lanType"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
