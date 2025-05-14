module("modules.configs.excel2json.lua_skill_bufftype", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	removeNum = 10,
	skipDelay = 11,
	dontShowFloat = 9,
	type = 2,
	includeTypes = 4,
	takeStage = 6,
	cannotRemove = 8,
	excludeTypes = 5,
	group = 3,
	takeAct = 7,
	matSort = 12,
	aniSort = 13,
	id = 1,
	playEffect = 14
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
