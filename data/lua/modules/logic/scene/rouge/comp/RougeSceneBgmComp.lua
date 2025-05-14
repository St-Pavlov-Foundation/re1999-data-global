module("modules.logic.scene.rouge.comp.RougeSceneBgmComp", package.seeall)

local var_0_0 = class("RougeSceneBgmComp", BaseSceneComp)

function var_0_0.onScenePrepared(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:changeBgm()
	RougeMapController.instance:registerCallback(RougeMapEvent.onChangeMapInfo, arg_1_0.changeBgm, arg_1_0)
end

function var_0_0.changeBgm(arg_2_0)
	local var_2_0 = RougeMapModel.instance:getLayerCo()
	local var_2_1 = AudioEnum.Bgm.RougeMain

	if var_2_0 and var_2_0.bgm ~= 0 then
		var_2_1 = var_2_0.bgm
	end

	AudioBgmManager.instance:modifyAndPlay(AudioBgmEnum.Layer.RougeScene, var_2_1, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
end

function var_0_0.onSceneClose(arg_3_0, arg_3_1, arg_3_2)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onChangeMapInfo, arg_3_0.changeBgm, arg_3_0)
end

return var_0_0
