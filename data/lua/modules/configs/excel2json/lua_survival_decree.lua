module("modules.configs.excel2json.lua_survival_decree", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	versions = 3,
	name = 5,
	tags = 10,
	type = 2,
	limit = 11,
	stageVotes = 8,
	condition = 9,
	desc = 6,
	getTalents = 12,
	seasons = 4,
	id = 1,
	icon = 7
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
