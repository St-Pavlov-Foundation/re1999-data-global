module("modules.configs.excel2json.lua_survival_shelter", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	versions = 5,
	difficultLv = 3,
	maxNpcNum = 7,
	orderPosition = 9,
	shelterId = 4,
	npcPosition = 12,
	toward = 10,
	stormCenter = 13,
	stormArea = 14,
	mapId = 11,
	seasons = 2,
	id = 1,
	position = 8,
	shelterChange = 6
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
