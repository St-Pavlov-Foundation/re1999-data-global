module("modules.configs.excel2json.lua_room_atmosphere", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	effectSequence = 3,
	openTime = 6,
	buildingId = 2,
	cdtimes = 9,
	residentEffect = 4,
	triggerType = 8,
	cyclesTimes = 5,
	id = 1,
	durationDay = 7
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
