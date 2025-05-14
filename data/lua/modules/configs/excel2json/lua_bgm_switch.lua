module("modules.configs.excel2json.lua_bgm_switch", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	itemId = 5,
	audioIntroduce = 9,
	audioNameEn = 8,
	audio = 2,
	audioName = 7,
	unlockCondition = 4,
	audioicon = 11,
	sort = 12,
	audioType = 13,
	isNonLoop = 16,
	isReport = 3,
	audioBg = 10,
	id = 1,
	audioEvaluates = 15,
	audioLength = 14,
	defaultUnlock = 6
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	audioIntroduce = 2,
	audioEvaluates = 3,
	audioName = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
