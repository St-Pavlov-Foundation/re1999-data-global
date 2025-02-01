module("modules.logic.guide.controller.GuideAudioMgr", package.seeall)

slot0 = class("GuideAudioMgr")
slot1 = 0.33

function slot0.ctor(slot0)
end

function slot0.playAudio(slot0, slot1)
	if AudioEffectMgr.instance:isPlaying(slot1) then
		return
	end

	if slot0._audioId then
		slot0:stopAudio(slot0._audioId)
	end

	slot0._setBusVolumeDict = {}

	for slot6, slot7 in pairs(AudioEffectMgr.instance:getPlayingItemDict()) do
		slot0._setBusVolumeDict[slot7] = true

		ZProj.AudioManager.Instance:SetGameObjectOutputBusVolume(slot7._go, uv0)
	end

	slot0._audioId = slot1

	AudioEffectMgr.instance:registerCallback(AudioEffectMgr.OnPlayAudio, slot0._onPlayAudio, slot0)
	AudioEffectMgr.instance:playAudio(slot0._audioId)
end

function slot0._onPlayAudio(slot0, slot1, slot2)
	if slot0._audioId and slot0._setBusVolumeDict and slot1 ~= slot0._audioId then
		slot0._setBusVolumeDict[slot2] = true

		ZProj.AudioManager.Instance:SetGameObjectOutputBusVolume(slot2._go, uv0)
	end
end

function slot0.stopAudio(slot0)
	AudioEffectMgr.instance:unregisterCallback(AudioEffectMgr.OnPlayAudio, slot0._onPlayAudio, slot0)

	if slot0._setBusVolumeDict then
		for slot4, slot5 in pairs(slot0._setBusVolumeDict) do
			if not gohelper.isNil(slot4._go) then
				ZProj.AudioManager.Instance:ResetListenersToDefault(slot4._go)
			end
		end

		slot0._setBusVolumeDict = nil
	end

	if slot0._audioId then
		AudioEffectMgr.instance:stopAudio(slot0._audioId)

		slot0._audioId = nil
	end
end

slot0.instance = slot0.New()

return slot0
