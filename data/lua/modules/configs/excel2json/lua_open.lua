module("modules.configs.excel2json.lua_open", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	isOnline = 3,
	name = 2,
	verifingHide = 11,
	verifingEpisodeId = 7,
	roomLevel = 13,
	playerLv = 4,
	episodeId = 5,
	elementId = 6,
	isAlwaysShowBtn = 8,
	bindActivityId = 12,
	id = 1,
	showInEpisode = 9,
	dec = 10
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
