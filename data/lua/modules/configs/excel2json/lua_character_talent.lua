module("modules.configs.excel2json.lua_character_talent", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	requirement = 5,
	heroId = 1,
	consume = 6,
	exclusive = 4,
	talentMould = 3,
	talentId = 2
}
local var_0_2 = {
	"heroId",
	"talentId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
