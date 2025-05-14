module("modules.logic.scene.cachot.comp.CachotBGMComp", package.seeall)

local var_0_0 = class("CachotBGMComp", BaseSceneComp)

function var_0_0.onSceneStart(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._scene = arg_1_0:getCurScene()
	arg_1_0._levelComp = arg_1_0._scene.level

	arg_1_0._levelComp:registerCallback(CommonSceneLevelComp.OnLevelLoaded, arg_1_0.onLevelLoaded, arg_1_0)
end

function var_0_0.onLevelLoaded(arg_2_0)
	local var_2_0 = 0
	local var_2_1 = V1a6_CachotModel.instance:getRogueInfo()

	if var_2_1 then
		var_2_0 = var_2_1.layer
	end

	local var_2_2 = V1a6_CachotEventConfig.instance:getBgmIdByLayer(var_2_0)

	if var_2_2 then
		AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.Cachot, var_2_2)
	end
end

function var_0_0.onSceneClose(arg_3_0)
	arg_3_0._levelComp:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, arg_3_0.onLevelLoaded, arg_3_0)
end

return var_0_0
