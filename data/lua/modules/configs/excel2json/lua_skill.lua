module("modules.configs.excel2json.lua_skill", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	icon = 4,
	name = 2,
	desc_art = 5,
	timeline = 3,
	preFxId = 14,
	notDoAction = 10,
	bloomParams = 12,
	activeTargetFrameEvent = 13,
	eff_desc = 6,
	heroId = 15,
	battleTag = 7,
	id = 1,
	skillEffect = 8,
	showInBattle = 11,
	skillRank = 9
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc_art = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
