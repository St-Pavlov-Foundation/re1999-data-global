module("modules.configs.excel2json.lua_activity166_talent_style", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	needStar = 3,
	slot = 6,
	skillId2 = 5,
	skillId = 4,
	talentId = 1,
	level = 2
}
local var_0_2 = {
	"talentId",
	"level"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
