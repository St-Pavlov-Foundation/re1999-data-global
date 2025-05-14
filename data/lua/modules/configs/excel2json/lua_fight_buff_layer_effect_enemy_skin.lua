module("modules.configs.excel2json.lua_fight_buff_layer_effect_enemy_skin", package.seeall)

local var_0_0 = {}
local var_0_1 = {
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
