module("modules.audio.AudioItem", package.seeall)

local var_0_0 = class("AudioItem")

function var_0_0.createPool()
	var_0_0._fadeStringId = AudioMgr.instance:getIdFromString("Fade_in_on_parameters")
	var_0_0._itemPool = LuaObjPool.New(6, var_0_0._poolNew, var_0_0._poolRelease, var_0_0._poolReset)

	return var_0_0._itemPool
end

function var_0_0._poolNew()
	return var_0_0.New()
end

function var_0_0._poolRelease(arg_3_0)
	arg_3_0:release()
end

function var_0_0._poolReset(arg_4_0)
	arg_4_0:reset()
end

function var_0_0.ctor(arg_5_0)
	local var_5_0 = UnityEngine.GameObject.New()

	var_5_0.name = "AudioItem"

	UnityEngine.GameObject.DontDestroyOnLoad(var_5_0)

	arg_5_0._go = var_5_0

	arg_5_0:reset()
end

function var_0_0.reset(arg_6_0)
	arg_6_0._callback = nil
	arg_6_0._callbackTarget = nil

	transformhelper.setPos(arg_6_0._go.transform, 0, 0, 0)
	arg_6_0:killTween()

	arg_6_0._volume = nil
end

function var_0_0.setVolume(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0:_fade(arg_7_1 * 0.01, arg_7_2 or 0)
end

function var_0_0.stopAudio(arg_8_0, arg_8_1, arg_8_2)
	transformhelper.setPos(arg_8_0._go.transform, 0, 0, 0)

	arg_8_0._fadeOutTime = arg_8_2 or 0

	if not arg_8_0:_startDelayFadeOut(0) then
		arg_8_0:_onStop()
	end
end

function var_0_0.setSwitch(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_0._emitter then
		return
	end

	arg_9_0._emitter:SetSwitch(arg_9_1, arg_9_2)
end

function var_0_0.playAudio(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._audioId = arg_10_1

	local var_10_0 = AudioConfig.instance:getAudioCOById(arg_10_0._audioId)

	arg_10_0._eventName = ""
	arg_10_0._bankName = ""

	if var_10_0 == nil then
		logError("AudioItem.playAudio, audio cfg is null for audioId = " .. arg_10_1)
	else
		arg_10_0._eventName = var_10_0.eventName
		arg_10_0._bankName = var_10_0.bankName

		if SettingsModel.instance:isZhRegion() == false then
			if string.nilorempty(var_10_0.eventName_Overseas) == false then
				arg_10_0._eventName = var_10_0.eventName_Overseas
			end

			if string.nilorempty(var_10_0.bankName_Overseas) == false then
				arg_10_0._bankName = var_10_0.bankName_Overseas
			end
		end
	end

	arg_10_0._playNum = 0
	arg_10_0._loopNum = arg_10_2.loopNum or 1
	arg_10_0._fadeInTime = arg_10_2.fadeInTime or 0
	arg_10_0._fadeOutTime = arg_10_2.fadeOutTime or 0

	local var_10_1 = arg_10_2.volume or 100

	arg_10_0._audioGo = arg_10_2.audioGo
	arg_10_0._callback = arg_10_2.callback
	arg_10_0._callbackTarget = arg_10_2.callbackTarget
	arg_10_0._audioLang = arg_10_2.audioLang

	arg_10_0:_play()
	arg_10_0:_fadeIn(var_10_1 * 0.01)
end

function var_0_0.SeekPercentByName(arg_11_0, arg_11_1)
	if arg_11_0._playingId and arg_11_0._emitter and string.nilorempty(arg_11_0._eventName) == false then
		arg_11_0._emitter:SeekPercent(arg_11_0._eventName, arg_11_1)
	end
end

function var_0_0.seekMilliSeconds(arg_12_0, arg_12_1)
	if arg_12_0._playingId and arg_12_0._emitter and string.nilorempty(arg_12_0._eventName) == false then
		arg_12_0._emitter:SeekMilliSecondsByName(arg_12_0._eventName, arg_12_1)
	end
end

function var_0_0._play(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._play, arg_13_0)

	arg_13_0._startTime = Time.realtimeSinceStartup

	if arg_13_0._audioGo then
		local var_13_0, var_13_1, var_13_2 = transformhelper.getPos(arg_13_0._audioGo.transform)

		transformhelper.setPos(arg_13_0._go.transform, var_13_0, var_13_1, var_13_2)
	else
		transformhelper.setPos(arg_13_0._go.transform, 0, 0, 0)
	end

	arg_13_0._emitter = arg_13_0._emitter or ZProj.AudioEmitter.Get(arg_13_0._go)

	local function var_13_3(arg_14_0, arg_14_1)
		if arg_14_0 == AudioEnum.AkCallbackType.AK_Duration then
			arg_13_0:_setAudioDuration(arg_14_1)
		elseif arg_14_0 == AudioEnum.AkCallbackType.AK_EndOfEvent then
			arg_13_0:_onAudioStop()
		end
	end

	if arg_13_0._audioLang then
		if GameConfig:GetCurVoiceShortcut() == LangSettings.shortcutTab[LangSettings.zh] then
			local var_13_4 = AudioConfig.instance:getAudioCOById(arg_13_0._audioId)

			if not var_13_4 then
				logError("audio cfg not config : " .. tostring(arg_13_0._audioId))
			end

			if var_13_4 then
				local var_13_5 = var_13_4.bankName

				ZProj.AudioManager.Instance:LoadBank(var_13_5, arg_13_0._audioLang)
				arg_13_0._emitter:EmitterByName(arg_13_0._bankName, arg_13_0._eventName, arg_13_0._audioLang, var_13_3)
				ZProj.AudioManager.Instance:UnloadBank(var_13_5)
			end
		else
			arg_13_0._emitter:EmitterByName(arg_13_0._bankName, arg_13_0._eventName, arg_13_0._audioLang, var_13_3)
		end
	else
		arg_13_0._emitter:EmitterByName(arg_13_0._bankName, arg_13_0._eventName, var_13_3)
	end

	AudioMgr.instance:addAudioLog(arg_13_0._audioId, "yellow", "播放音效开始")

	arg_13_0._playingId = arg_13_0._emitter.playingId
end

function var_0_0._fadeIn(arg_15_0, arg_15_1)
	if arg_15_0._fadeInTime > 0 then
		arg_15_0:_fade(0, 0)
	end

	arg_15_0:_fade(arg_15_1, arg_15_0._fadeInTime)
end

function var_0_0._fadeOut(arg_16_0)
	if arg_16_0._fadeOutTime > 0 then
		TaskDispatcher.cancelTask(arg_16_0._onStop, arg_16_0)
		TaskDispatcher.runDelay(arg_16_0._onStop, arg_16_0, arg_16_0._fadeOutTime)
		arg_16_0:_fade(0, arg_16_0._fadeOutTime)
	end
end

function var_0_0._fade(arg_17_0, arg_17_1, arg_17_2)
	if not arg_17_0._playingId then
		return
	end

	arg_17_0:killTween()

	if arg_17_2 > 0 then
		arg_17_0.tweenId = ZProj.TweenHelper.DOTweenFloat(arg_17_0._volume or 1, arg_17_1, arg_17_2, arg_17_0._tweenFrameCallback, nil, arg_17_0, nil, EaseType.Linear)
	else
		arg_17_0:_tweenFrameCallback(arg_17_1)
	end
end

function var_0_0._tweenFrameCallback(arg_18_0, arg_18_1)
	AudioMgr.instance:setGameObjectOutputBusVolume(arg_18_0._go, arg_18_1)

	arg_18_0._volume = arg_18_1
end

function var_0_0.killTween(arg_19_0)
	if arg_19_0.tweenId then
		ZProj.TweenHelper.KillById(arg_19_0.tweenId)

		arg_19_0.tweenId = nil
	end
end

function var_0_0._setAudioDuration(arg_20_0, arg_20_1)
	arg_20_0._duration = (arg_20_1 or 0) / 1000

	if arg_20_0._playNum + 1 >= arg_20_0._loopNum then
		arg_20_0:_startDelayFadeOut()
	end
end

function var_0_0._startDelayFadeOut(arg_21_0, arg_21_1)
	if arg_21_0._fadeOutTime <= 0 then
		return false
	end

	if not arg_21_1 then
		if arg_21_0._duration and arg_21_0._duration > 0 then
			arg_21_0._fadeOutTime = math.min(arg_21_0._fadeOutTime, arg_21_0._duration)
			arg_21_1 = arg_21_0._duration - arg_21_0._fadeOutTime
		else
			arg_21_1 = arg_21_0._fadeOutTime
		end
	end

	arg_21_1 = math.max(arg_21_1, 0)

	TaskDispatcher.cancelTask(arg_21_0._fadeOut, arg_21_0)

	if arg_21_1 == 0 then
		arg_21_0:_fadeOut()
	else
		TaskDispatcher.runDelay(arg_21_0._fadeOut, arg_21_0, arg_21_1)
	end

	return true
end

function var_0_0._onAudioStop(arg_22_0)
	if not arg_22_0._audioId then
		return
	end

	arg_22_0._playNum = arg_22_0._playNum + 1

	if arg_22_0._playNum < arg_22_0._loopNum then
		TaskDispatcher.runDelay(arg_22_0._play, arg_22_0, 0)
	else
		arg_22_0:_onStop()
	end
end

function var_0_0._onStop(arg_23_0)
	if not arg_23_0._audioId then
		return
	end

	if arg_23_0._callback then
		arg_23_0._callback(arg_23_0._callbackTarget, arg_23_0._audioId)
	end

	if arg_23_0._playingId then
		AudioMgr.instance:stopPlayingID(arg_23_0._playingId)
	end

	if arg_23_0._playNum == 0 then
		AudioMgr.instance:addAudioLog(arg_23_0._audioId, "red", "播放音效停止")
	elseif arg_23_0._playNum == 1 then
		AudioMgr.instance:addAudioLog(arg_23_0._audioId, "green", "播放音效结束")
	end

	TaskDispatcher.cancelTask(arg_23_0._fadeOut, arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0._onStop, arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0._play, arg_23_0)
	AudioEffectMgr.instance:_onStopAudio(arg_23_0._audioId)

	arg_23_0._audioId = nil
	arg_23_0._playingId = nil
end

function var_0_0.isPlaying(arg_24_0)
	return arg_24_0._playingId
end

function var_0_0.release(arg_25_0)
	arg_25_0:reset()
	UnityEngine.GameObject.Destroy(arg_25_0._go)

	arg_25_0._go = nil
	arg_25_0._emitter = nil
end

return var_0_0
