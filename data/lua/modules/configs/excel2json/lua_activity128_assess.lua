module("modules.configs.excel2json.lua_activity128_assess", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	spriteName = 3,
	needPointBoss1 = 4,
	mainBg = 8,
	needPointBoss2 = 5,
	layer4Assess = 9,
	battleIconBg = 7,
	strLevel = 2,
	needPointBoss3 = 6,
	level = 1
}
local var_0_2 = {
	"level"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
