module("modules.spine.SpineVoiceAddAudio", package.seeall)

slot0 = class("SpineVoiceAddAudio")

function slot0.ctor(slot0)
end

function slot0.init(slot0, slot1, slot2)
	slot0._audioId = slot1

	if slot2 < 0.1 then
		slot0:_playAddAudio()

		return
	end

	TaskDispatcher.runDelay(slot0._playAddAudio, slot0, slot2)
end

function slot0._playAddAudio(slot0)
	if slot0._audioId and slot0._audioId > 0 then
		AudioMgr.instance:trigger(slot0._audioId)
	end
end

function slot0.onDestroy(slot0)
	if slot0._audioId and slot0._audioId > 0 then
		AudioMgr.instance:stopPlayingID(slot0._audioId)
	end

	slot0._audioId = nil

	TaskDispatcher.cancelTask(slot0._playAddAudio, slot0)
end

return slot0
