module("modules.configs.excel2json.lua_activity166_info_analy", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	content = 6,
	infoId = 2,
	consume = 4,
	stage = 3,
	activityId = 1,
	bonus = 5
}
local var_0_2 = {
	"activityId",
	"infoId",
	"stage"
}
local var_0_3 = {
	content = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
