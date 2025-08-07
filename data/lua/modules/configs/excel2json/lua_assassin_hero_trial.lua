module("modules.configs.excel2json.lua_assassin_hero_trial", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	heroImg = 5,
	heroIcon = 4,
	secondCareer = 3,
	entityIcon = 6,
	assassinHeroId = 1,
	model = 8,
	career = 2,
	unlock = 7
}
local var_0_2 = {
	"assassinHeroId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
