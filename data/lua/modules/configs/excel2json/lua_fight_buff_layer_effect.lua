module("modules.configs.excel2json.lua_fight_buff_layer_effect", package.seeall)

local var_0_0 = {}
local var_0_1 = {
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
	hideEffectWhenPlaying = 20,
	loopEffect = 4,
	id = 1,
	createAudio = 13,
	createEffectRoot = 12
}
local var_0_2 = {
	"id",
	"skin",
	"layer"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
