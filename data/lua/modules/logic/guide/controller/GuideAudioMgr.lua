module("modules.logic.guide.controller.GuideAudioMgr", package.seeall)

local var_0_0 = class("GuideAudioMgr")
local var_0_1 = 0.33

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.playAudio(arg_2_0, arg_2_1)
	if AudioEffectMgr.instance:isPlaying(arg_2_1) then
		return
	end

	if arg_2_0._audioId then
		arg_2_0:stopAudio(arg_2_0._audioId)
	end

	local var_2_0 = AudioEffectMgr.instance:getPlayingItemDict()

	arg_2_0._setBusVolumeDict = {}

	for iter_2_0, iter_2_1 in pairs(var_2_0) do
		arg_2_0._setBusVolumeDict[iter_2_1] = true

		ZProj.AudioManager.Instance:SetGameObjectOutputBusVolume(iter_2_1._go, var_0_1)
	end

	arg_2_0._audioId = arg_2_1

	AudioEffectMgr.instance:registerCallback(AudioEffectMgr.OnPlayAudio, arg_2_0._onPlayAudio, arg_2_0)
	AudioEffectMgr.instance:playAudio(arg_2_0._audioId)
end

function var_0_0._onPlayAudio(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0._audioId and arg_3_0._setBusVolumeDict and arg_3_1 ~= arg_3_0._audioId then
		arg_3_0._setBusVolumeDict[arg_3_2] = true

		ZProj.AudioManager.Instance:SetGameObjectOutputBusVolume(arg_3_2._go, var_0_1)
	end
end

function var_0_0.stopAudio(arg_4_0)
	AudioEffectMgr.instance:unregisterCallback(AudioEffectMgr.OnPlayAudio, arg_4_0._onPlayAudio, arg_4_0)

	if arg_4_0._setBusVolumeDict then
		for iter_4_0, iter_4_1 in pairs(arg_4_0._setBusVolumeDict) do
			if not gohelper.isNil(iter_4_0._go) then
				ZProj.AudioManager.Instance:ResetListenersToDefault(iter_4_0._go)
			end
		end

		arg_4_0._setBusVolumeDict = nil
	end

	if arg_4_0._audioId then
		AudioEffectMgr.instance:stopAudio(arg_4_0._audioId)

		arg_4_0._audioId = nil
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
