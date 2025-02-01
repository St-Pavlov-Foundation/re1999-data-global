module("modules.configs.excel2json.lua_fight_buff_layer_effect", package.seeall)

slot1 = {
	addLayerEffect = 8,
	releaseCreateEffectTime = 14,
	skin = 2,
	delayTimeBeforeLoop = 15,
	releaseDestroyEffectTime = 19,
	addLayerEffectRoot = 9,
	addLayerAudio = 7,
	destroyEffectAudio = 18,
	destroyEffectRoot = 17,
	destroyEffect = 16,
	releaseAddLayerEffectTime = 10,
	loopEffectAudio = 6,
	createEffect = 11,
	loopEffectRoot = 5,
	layer = 3,
	loopEffect = 4,
	id = 1,
	createAudio = 13,
	createEffectRoot = 12
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
