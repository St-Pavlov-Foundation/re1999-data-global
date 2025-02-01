module("modules.configs.excel2json.lua_skill_buff", package.seeall)

slot1 = {
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
slot2 = {
	"id"
}
slot3 = {
	desc = 2,
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
