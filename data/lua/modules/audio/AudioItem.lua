module("modules.audio.AudioItem", package.seeall)

slot0 = class("AudioItem")

function slot0.createPool()
	uv0._fadeStringId = AudioMgr.instance:getIdFromString("Fade_in_on_parameters")
	uv0._itemPool = LuaObjPool.New(6, uv0._poolNew, uv0._poolRelease, uv0._poolReset)

	return uv0._itemPool
end

function slot0._poolNew()
	return uv0.New()
end

function slot0._poolRelease(slot0)
	slot0:release()
end

function slot0._poolReset(slot0)
	slot0:reset()
end

function slot0.ctor(slot0)
	slot1 = UnityEngine.GameObject.New()
	slot1.name = "AudioItem"

	UnityEngine.GameObject.DontDestroyOnLoad(slot1)

	slot0._go = slot1

	slot0:reset()
end

function slot0.reset(slot0)
	slot0._callback = nil
	slot0._callbackTarget = nil

	transformhelper.setPos(slot0._go.transform, 0, 0, 0)
	slot0:killTween()

	slot0._volume = nil
end

function slot0.setVolume(slot0, slot1, slot2)
	slot0:_fade(slot1 * 0.01, slot2 or 0)
end

function slot0.stopAudio(slot0, slot1, slot2)
	transformhelper.setPos(slot0._go.transform, 0, 0, 0)

	slot0._fadeOutTime = slot2 or 0

	if not slot0:_startDelayFadeOut(0) then
		slot0:_onStop()
	end
end

function slot0.setSwitch(slot0, slot1, slot2)
	if not slot0._emitter then
		return
	end

	slot0._emitter:SetSwitch(slot1, slot2)
end

function slot0.playAudio(slot0, slot1, slot2)
	slot0._audioId = slot1
	slot0._eventName = ""
	slot0._bankName = ""

	if AudioConfig.instance:getAudioCOById(slot0._audioId) == nil then
		logError("AudioItem.playAudio, audio cfg is null for audioId = " .. slot1)
	else
		slot0._eventName = slot3.eventName
		slot0._bankName = slot3.bankName

		if SettingsModel.instance:isZhRegion() == false then
			if string.nilorempty(slot3.eventName_Overseas) == false then
				slot0._eventName = slot3.eventName_Overseas
			end

			if string.nilorempty(slot3.bankName_Overseas) == false then
				slot0._bankName = slot3.bankName_Overseas
			end
		end
	end

	slot0._playNum = 0
	slot0._loopNum = slot2.loopNum or 1
	slot0._fadeInTime = slot2.fadeInTime or 0
	slot0._fadeOutTime = slot2.fadeOutTime or 0
	slot0._audioGo = slot2.audioGo
	slot0._callback = slot2.callback
	slot0._callbackTarget = slot2.callbackTarget
	slot0._audioLang = slot2.audioLang

	slot0:_play()
	slot0:_fadeIn((slot2.volume or 100) * 0.01)
end

function slot0.SeekPercentByName(slot0, slot1)
	if slot0._playingId and slot0._emitter and string.nilorempty(slot0._eventName) == false then
		slot0._emitter:SeekPercent(slot0._eventName, slot1)
	end
end

function slot0.seekMilliSeconds(slot0, slot1)
	if slot0._playingId and slot0._emitter and string.nilorempty(slot0._eventName) == false then
		slot0._emitter:SeekMilliSecondsByName(slot0._eventName, slot1)
	end
end

function slot0._play(slot0)
	TaskDispatcher.cancelTask(slot0._play, slot0)

	slot0._startTime = Time.realtimeSinceStartup

	if slot0._audioGo then
		slot1, slot2, slot3 = transformhelper.getPos(slot0._audioGo.transform)

		transformhelper.setPos(slot0._go.transform, slot1, slot2, slot3)
	else
		transformhelper.setPos(slot0._go.transform, 0, 0, 0)
	end

	slot0._emitter = slot0._emitter or ZProj.AudioEmitter.Get(slot0._go)

	function slot1(slot0, slot1)
		if slot0 == AudioEnum.AkCallbackType.AK_Duration then
			uv0:_setAudioDuration(slot1)
		elseif slot0 == AudioEnum.AkCallbackType.AK_EndOfEvent then
			uv0:_onAudioStop()
		end
	end

	if slot0._audioLang then
		if GameConfig:GetCurVoiceShortcut() == LangSettings.shortcutTab[LangSettings.zh] then
			if not AudioConfig.instance:getAudioCOById(slot0._audioId) then
				logError("audio cfg not config : " .. tostring(slot0._audioId))
			end

			if slot3 then
				slot4 = slot3.bankName

				ZProj.AudioManager.Instance:LoadBank(slot4, slot0._audioLang)
				slot0._emitter:EmitterByName(slot0._bankName, slot0._eventName, slot0._audioLang, slot1)
				ZProj.AudioManager.Instance:UnloadBank(slot4)
			end
		else
			slot0._emitter:EmitterByName(slot0._bankName, slot0._eventName, slot0._audioLang, slot1)
		end
	else
		slot0._emitter:EmitterByName(slot0._bankName, slot0._eventName, slot1)
	end

	AudioMgr.instance:addAudioLog(slot0._audioId, "yellow", "播放音效开始")

	slot0._playingId = slot0._emitter.playingId
end

function slot0._fadeIn(slot0, slot1)
	if slot0._fadeInTime > 0 then
		slot0:_fade(0, 0)
	end

	slot0:_fade(slot1, slot0._fadeInTime)
end

function slot0._fadeOut(slot0)
	if slot0._fadeOutTime > 0 then
		TaskDispatcher.cancelTask(slot0._onStop, slot0)
		TaskDispatcher.runDelay(slot0._onStop, slot0, slot0._fadeOutTime)
		slot0:_fade(0, slot0._fadeOutTime)
	end
end

function slot0._fade(slot0, slot1, slot2)
	if not slot0._playingId then
		return
	end

	slot0:killTween()

	if slot2 > 0 then
		slot0.tweenId = ZProj.TweenHelper.DOTweenFloat(slot0._volume or 1, slot1, slot2, slot0._tweenFrameCallback, nil, slot0, nil, EaseType.Linear)
	else
		slot0:_tweenFrameCallback(slot1)
	end
end

function slot0._tweenFrameCallback(slot0, slot1)
	AudioMgr.instance:setGameObjectOutputBusVolume(slot0._go, slot1)

	slot0._volume = slot1
end

function slot0.killTween(slot0)
	if slot0.tweenId then
		ZProj.TweenHelper.KillById(slot0.tweenId)

		slot0.tweenId = nil
	end
end

function slot0._setAudioDuration(slot0, slot1)
	slot0._duration = (slot1 or 0) / 1000

	if slot0._loopNum <= slot0._playNum + 1 then
		slot0:_startDelayFadeOut()
	end
end

function slot0._startDelayFadeOut(slot0, slot1)
	if slot0._fadeOutTime <= 0 then
		return false
	end

	if not slot1 then
		if slot0._duration and slot0._duration > 0 then
			slot0._fadeOutTime = math.min(slot0._fadeOutTime, slot0._duration)
			slot1 = slot0._duration - slot0._fadeOutTime
		else
			slot1 = slot0._fadeOutTime
		end
	end

	TaskDispatcher.cancelTask(slot0._fadeOut, slot0)

	if math.max(slot1, 0) == 0 then
		slot0:_fadeOut()
	else
		TaskDispatcher.runDelay(slot0._fadeOut, slot0, slot1)
	end

	return true
end

function slot0._onAudioStop(slot0)
	if not slot0._audioId then
		return
	end

	slot0._playNum = slot0._playNum + 1

	if slot0._playNum < slot0._loopNum then
		TaskDispatcher.runDelay(slot0._play, slot0, 0)
	else
		slot0:_onStop()
	end
end

function slot0._onStop(slot0)
	if not slot0._audioId then
		return
	end

	if slot0._callback then
		slot0._callback(slot0._callbackTarget, slot0._audioId)
	end

	if slot0._playingId then
		AudioMgr.instance:stopPlayingID(slot0._playingId)
	end

	if slot0._playNum == 0 then
		AudioMgr.instance:addAudioLog(slot0._audioId, "red", "播放音效停止")
	elseif slot0._playNum == 1 then
		AudioMgr.instance:addAudioLog(slot0._audioId, "green", "播放音效结束")
	end

	TaskDispatcher.cancelTask(slot0._fadeOut, slot0)
	TaskDispatcher.cancelTask(slot0._onStop, slot0)
	TaskDispatcher.cancelTask(slot0._play, slot0)
	AudioEffectMgr.instance:_onStopAudio(slot0._audioId)

	slot0._audioId = nil
	slot0._playingId = nil
end

function slot0.isPlaying(slot0)
	return slot0._playingId
end

function slot0.release(slot0)
	slot0:reset()
	UnityEngine.GameObject.Destroy(slot0._go)

	slot0._go = nil
	slot0._emitter = nil
end

return slot0
