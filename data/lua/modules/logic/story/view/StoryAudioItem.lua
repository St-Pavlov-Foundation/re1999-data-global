module("modules.logic.story.view.StoryAudioItem", package.seeall)

slot0 = class("StoryAudioItem")

function slot0.init(slot0, slot1)
	slot0._audioId = slot1
	slot0._playCount = 1
end

function slot0.pause(slot0, slot1)
end

function slot0.stop(slot0, slot1)
	AudioEffectMgr.instance:stopAudio(slot0._audioId, slot1)
	slot0:onDestroy()
end

function slot0.play(slot0, slot1, slot2, slot3)
	slot0._hasDestroy = false
	slot4 = AudioParam.New()
	slot4.loopNum = slot0._playCount
	slot4.fadeInTime = slot1
	slot4.fadeOutTime = slot2
	slot4.volume = 100 * slot3

	AudioEffectMgr.instance:playAudio(slot0._audioId, slot4)
	AudioEffectMgr.instance:setSwitch(slot0._audioId, AudioMgr.instance:getIdFromString("plot_music_stae_strength"), AudioMgr.instance:getIdFromString("strength0" .. tostring(slot0._audioParam.audioState)))
end

function slot0.setLoop(slot0)
	slot0._playCount = 999999
end

function slot0.setCount(slot0, slot1)
	slot0._playCount = slot1
end

function slot0.isPause(slot0)
end

function slot0._resetAudio(slot0)
	AudioEffectMgr.instance:setVolume(slot0._audioId, 100 * slot0._audioParam.volume, slot0._audioParam.transTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	AudioEffectMgr.instance:setSwitch(slot0._audioId, AudioMgr.instance:getIdFromString("plot_music_stae_strength"), AudioMgr.instance:getIdFromString("strength0" .. tostring(slot0._audioParam.audioState)))
end

function slot0.setAudio(slot0, slot1)
	if slot1.orderType == StoryEnum.AudioOrderType.Destroy and slot0._hasDestroy then
		return
	end

	slot0._hasDestroy = false

	if slot1.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		slot0:_startAudio(slot1)
	else
		TaskDispatcher.runDelay(function ()
			if not ViewMgr.instance:isOpen(ViewName.StoryView) then
				return
			end

			if uv0._hasDestroy then
				return
			end

			uv0:_startAudio(uv1)
		end, slot0, slot2)
	end
end

function slot0._startAudio(slot0, slot1)
	slot0._audioParam = slot1

	if slot0._audioParam.orderType == StoryEnum.AudioOrderType.Continuity then
		slot0:_playLoop()
	elseif slot0._audioParam.orderType == StoryEnum.AudioOrderType.Single then
		slot0:_playSingle()
	elseif slot0._audioParam.orderType == StoryEnum.AudioOrderType.Destroy then
		slot0:_stopAudio()
	elseif slot0._audioParam.orderType == StoryEnum.AudioOrderType.Adjust then
		slot0:_resetAudio()
	end
end

function slot0._playSingle(slot0)
	slot0:setCount(slot0._audioParam.count)
	slot0:play(slot0._audioParam.transTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], slot0._audioParam.transTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], slot0._audioParam.volume)
end

function slot0._playLoop(slot0)
	slot0:setLoop()
	slot0:play(slot0._audioParam.transTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], slot0._audioParam.transTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], slot0._audioParam.volume)
end

function slot0._stopAudio(slot0)
	slot0:stop(slot0._audioParam.transTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function slot0.onDestroy(slot0)
	slot0._hasDestroy = true

	TaskDispatcher.cancelTask(slot0._dealAudio, slot0)
	TaskDispatcher.cancelTask(slot0._playLoop, slot0)
	TaskDispatcher.cancelTask(slot0._playSingle, slot0)
	TaskDispatcher.cancelTask(slot0._stopAudio, slot0)
	TaskDispatcher.cancelTask(slot0._resetAudio, slot0)
end

return slot0
