module("modules.configs.excel2json.lua_hero_invitation", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	head = 3,
	rewardDisplayList = 4,
	name = 2,
	storyId = 6,
	id = 1,
	elementId = 5,
	restoryId = 7,
	openTime = 8
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
