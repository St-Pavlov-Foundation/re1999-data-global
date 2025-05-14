module("modules.logic.story.view.StoryAudioItem", package.seeall)

local var_0_0 = class("StoryAudioItem")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._audioId = arg_1_1
	arg_1_0._playCount = 1
end

function var_0_0.pause(arg_2_0, arg_2_1)
	return
end

function var_0_0.stop(arg_3_0, arg_3_1)
	AudioEffectMgr.instance:stopAudio(arg_3_0._audioId, arg_3_1)
	arg_3_0:onDestroy()
end

function var_0_0.play(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0._hasDestroy = false

	local var_4_0 = AudioParam.New()

	var_4_0.loopNum = arg_4_0._playCount
	var_4_0.fadeInTime = arg_4_1
	var_4_0.fadeOutTime = arg_4_2
	var_4_0.volume = 100 * arg_4_3

	AudioEffectMgr.instance:playAudio(arg_4_0._audioId, var_4_0)
	AudioEffectMgr.instance:setSwitch(arg_4_0._audioId, AudioMgr.instance:getIdFromString("plot_music_stae_strength"), AudioMgr.instance:getIdFromString("strength0" .. tostring(arg_4_0._audioParam.audioState)))
end

function var_0_0.setLoop(arg_5_0)
	arg_5_0._playCount = 999999
end

function var_0_0.setCount(arg_6_0, arg_6_1)
	arg_6_0._playCount = arg_6_1
end

function var_0_0.isPause(arg_7_0)
	return
end

function var_0_0._resetAudio(arg_8_0)
	AudioEffectMgr.instance:setVolume(arg_8_0._audioId, 100 * arg_8_0._audioParam.volume, arg_8_0._audioParam.transTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	AudioEffectMgr.instance:setSwitch(arg_8_0._audioId, AudioMgr.instance:getIdFromString("plot_music_stae_strength"), AudioMgr.instance:getIdFromString("strength0" .. tostring(arg_8_0._audioParam.audioState)))
end

function var_0_0.setAudio(arg_9_0, arg_9_1)
	if arg_9_1.orderType == StoryEnum.AudioOrderType.Destroy and arg_9_0._hasDestroy then
		return
	end

	arg_9_0._hasDestroy = false

	local var_9_0 = arg_9_1.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]

	if var_9_0 < 0.1 then
		arg_9_0:_startAudio(arg_9_1)
	else
		TaskDispatcher.runDelay(function()
			if not ViewMgr.instance:isOpen(ViewName.StoryView) then
				return
			end

			if arg_9_0._hasDestroy then
				return
			end

			arg_9_0:_startAudio(arg_9_1)
		end, arg_9_0, var_9_0)
	end
end

function var_0_0._startAudio(arg_11_0, arg_11_1)
	arg_11_0._audioParam = arg_11_1

	if arg_11_0._audioParam.orderType == StoryEnum.AudioOrderType.Continuity then
		arg_11_0:_playLoop()
	elseif arg_11_0._audioParam.orderType == StoryEnum.AudioOrderType.Single then
		arg_11_0:_playSingle()
	elseif arg_11_0._audioParam.orderType == StoryEnum.AudioOrderType.Destroy then
		arg_11_0:_stopAudio()
	elseif arg_11_0._audioParam.orderType == StoryEnum.AudioOrderType.Adjust then
		arg_11_0:_resetAudio()
	end
end

function var_0_0._playSingle(arg_12_0)
	arg_12_0:setCount(arg_12_0._audioParam.count)
	arg_12_0:play(arg_12_0._audioParam.transTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], arg_12_0._audioParam.transTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], arg_12_0._audioParam.volume)
end

function var_0_0._playLoop(arg_13_0)
	arg_13_0:setLoop()
	arg_13_0:play(arg_13_0._audioParam.transTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], arg_13_0._audioParam.transTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], arg_13_0._audioParam.volume)
end

function var_0_0._stopAudio(arg_14_0)
	arg_14_0:stop(arg_14_0._audioParam.transTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function var_0_0.onDestroy(arg_15_0)
	arg_15_0._hasDestroy = true

	TaskDispatcher.cancelTask(arg_15_0._dealAudio, arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0._playLoop, arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0._playSingle, arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0._stopAudio, arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0._resetAudio, arg_15_0)
end

return var_0_0
