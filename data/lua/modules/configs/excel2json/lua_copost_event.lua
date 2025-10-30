module("modules.configs.excel2json.lua_copost_event", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	needchaText = 9,
	eventTextId = 5,
	chaId = 10,
	allTime = 7,
	reduceTime = 11,
	eventCoordinate = 3,
	eventType = 2,
	charaProfile = 8,
	eventTitleId = 4,
	id = 1,
	chaNum = 6,
	bonus = 12
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	needchaText = 2,
	eventTitleId = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
