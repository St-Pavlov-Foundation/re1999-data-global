module("modules.configs.excel2json.lua_activity121_note", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	name = 3,
	unlockType = 4,
	noteId = 1,
	fightId = 6,
	desc = 7,
	content = 8,
	activityId = 2,
	episodeId = 5
}
local var_0_2 = {
	"noteId",
	"activityId"
}
local var_0_3 = {
	name = 1,
	content = 3,
	desc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
