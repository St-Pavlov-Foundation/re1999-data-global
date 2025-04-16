module("modules.configs.excel2json.lua_fight_buff_layer_effect_enemy_skin", package.seeall)

slot1 = {
	releaseCreateEffectTime = 15,
	addLayerEffectRoot = 10,
	hideWhenPlayTimeline = 6,
	delayTimeBeforeLoop = 16,
	releaseDestroyEffectTime = 20,
	skin = 2,
	addLayerAudio = 8,
	destroyEffect = 17,
	destroyEffectRoot = 18,
	addLayerEffect = 9,
	releaseAddLayerEffectTime = 11,
	destroyEffectAudio = 19,
	createEffect = 12,
	loopEffectAudio = 7,
	loopEffectRoot = 5,
	layer = 3,
	loopEffect = 4,
	id = 1,
	createAudio = 14,
	createEffectRoot = 13
}
slot2 = {
	"id",
	"skin",
	"layer"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
