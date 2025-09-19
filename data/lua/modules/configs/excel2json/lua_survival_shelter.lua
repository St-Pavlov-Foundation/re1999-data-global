module("modules.configs.excel2json.lua_survival_shelter", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	versions = 5,
	difficultLv = 3,
	orderPosition = 8,
	npcPosition = 10,
	shelterId = 4,
	stormCenter = 11,
	toward = 9,
	stormArea = 12,
	seasons = 2,
	id = 1,
	position = 7,
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
