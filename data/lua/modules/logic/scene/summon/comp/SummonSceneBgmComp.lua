module("modules.logic.scene.summon.comp.SummonSceneBgmComp", package.seeall)

local var_0_0 = class("SummonSceneBgmComp", BaseSceneComp)

function var_0_0.onSceneStart(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._sceneLevelCO = lua_scene_level.configDict[arg_1_2]

	if arg_1_0._sceneLevelCO and arg_1_0._sceneLevelCO.bgm and arg_1_0._sceneLevelCO.bgm > 0 then
		arg_1_0._bgmId = arg_1_0._sceneLevelCO.bgm
	end

	if arg_1_0._bgmId then
		AudioBgmManager.instance:modifyAndPlay(AudioBgmEnum.Layer.Summon, arg_1_0._bgmId, AudioEnum.UI.Stop_UIMusic, nil, nil, AudioEnum.SwitchGroup.Summon, AudioEnum.SwitchState.SummonNormal)
	end
end

function var_0_0.Play(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1 == SummonEnum.ResultType.Equip and AudioEnum.SwitchState.SummonEquip or AudioEnum.SwitchState.SummonChar

	AudioMgr.instance:setSwitch(AudioMgr.instance:getIdFromString(AudioEnum.SwitchGroup.SummonTab), AudioMgr.instance:getIdFromString(var_2_0))
end

function var_0_0.onSceneClose(arg_3_0)
	if arg_3_0._bgmId then
		arg_3_0._bgmId = nil

		AudioBgmManager.instance:stopAndClear(AudioBgmEnum.Layer.Summon)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_help_close)
end

function var_0_0.onSceneHide(arg_4_0)
	arg_4_0:onSceneClose()
end

return var_0_0
