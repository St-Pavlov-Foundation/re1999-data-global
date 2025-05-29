module("modules.configs.excel2json.lua_weekwalk_ver2", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	chooseSkillNum = 10,
	resIdRear = 9,
	preId = 4,
	fightIdFront = 6,
	sceneId = 5,
	issueId = 3,
	resIdFront = 7,
	id = 1,
	fightIdRear = 8,
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
