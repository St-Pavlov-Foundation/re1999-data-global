module("modules.configs.excel2json.lua_weekwalk", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	notCdHeroCount = 5,
	resIdRear = 11,
	preId = 3,
	type = 4,
	fightIdFront = 8,
	sceneId = 6,
	issueId = 7,
	resIdFront = 9,
	id = 1,
	fightIdRear = 10,
	layer = 2
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
