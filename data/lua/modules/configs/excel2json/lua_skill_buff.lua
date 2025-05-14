module("modules.configs.excel2json.lua_skill_buff", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	triggerAudio = 20,
	name = 2,
	desc = 3,
	duringTime = 6,
	effectCount = 7,
	isNoShow = 4,
	animationName = 14,
	mat = 15,
	bloommat = 16,
	delEffect = 22,
	triggerEffect = 18,
	delEffectHangPoint = 23,
	effectHangPoint = 13,
	features = 8,
	triggerAnimationName = 21,
	delAudio = 24,
	effect = 11,
	audio = 17,
	typeId = 9,
	effectloop = 12,
	iconId = 10,
	triggerEffectHangPoint = 19,
	isGoodBuff = 5,
	id = 1
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
