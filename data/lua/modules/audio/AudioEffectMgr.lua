module("modules.audio.AudioEffectMgr", package.seeall)

slot0 = class("AudioEffectMgr")
slot0.OnPlayAudio = 101

function slot0.ctor(slot0)
	slot0._pool = AudioItem.createPool()
	slot0._playingList = {}

	LuaEventSystem.addEventMechanism(slot0)
end

function slot0.setVolume(slot0, slot1, slot2, slot3)
	if not slot0._playingList[slot1] then
		return
	end

	slot4:setVolume(slot2, slot3)
end

function slot0.setSwitch(slot0, slot1, slot2, slot3)
	if not slot0._playingList[slot1] then
		return
	end

	slot4:setSwitch(slot2, slot3)
end

function slot0.playAudio(slot0, slot1, slot2, slot3)
	if slot0._playingList[slot1] then
		return
	end

	slot2 = slot2 or slot0:_getDefaultAudioParam()
	slot2.audioLang = slot3
	slot4 = slot0._pool:getObject()
	slot0._playingList[slot1] = slot4

	slot4:playAudio(slot1, slot2)
	slot0:dispatchEvent(uv0.OnPlayAudio, slot1, slot4)
end

function slot0._getDefaultAudioParam(slot0)
	slot0._defaultAudioParam = slot0._defaultAudioParam or AudioParam.New()

	slot0._defaultAudioParam:clear()

	slot0._defaultAudioParam.loopNum = 1
	slot0._defaultAudioParam.fadeInTime = 0
	slot0._defaultAudioParam.fadeOutTime = 0

	return slot0._defaultAudioParam
end

function slot0.seekPercent(slot0, slot1, slot2)
	if not slot0._playingList[slot1] then
		slot3:seekPercent(slot2)
	end
end

function slot0.seekMilliSeconds(slot0, slot1, slot2)
	if slot0._playingList[slot1] then
		slot3:seekMilliSeconds(slot2)
	end
end

function slot0.stopAudio(slot0, slot1, slot2)
	if not slot0._playingList[slot1] then
		return
	end

	slot0._playingList[slot1]:stopAudio(slot1, slot2)
end

function slot0.removePlayingAudio(slot0, slot1)
	slot0._playingList[slot1] = nil
end

function slot0.isPlaying(slot0, slot1)
	return slot0._playingList[slot1]
end

function slot0.getPlayingItemDict(slot0)
	return slot0._playingList
end

function slot0.playAudioByEffectPath(slot0, slot1, slot2, slot3)
	if AudioConfig.instance:getAudioConfig(slot1) then
		slot0:playAudio(slot4.audioId, slot0:_getEffectAudioParam(slot2, slot3))

		return slot4.audioId
	end
end

function slot0._getEffectAudioParam(slot0, slot1, slot2)
	slot0._effectAudioParam = slot0._effectAudioParam or AudioParam.New()

	slot0._effectAudioParam:clear()

	slot0._effectAudioParam.loopNum = 1
	slot0._effectAudioParam.fadeInTime = slot1
	slot0._effectAudioParam.fadeOutTime = slot2

	return slot0._effectAudioParam
end

function slot0.stopAudioByEffectPath(slot0, slot1, slot2)
	if AudioConfig.instance:getAudioConfig(slot1) then
		slot0:stopAudio(slot3.audioId, slot2)
	end
end

function slot0._onStopAudio(slot0, slot1)
	if not slot0._playingList[slot1] then
		return
	end

	slot0._pool:putObject(slot0._playingList[slot1])

	slot0._playingList[slot1] = nil
end

slot0.instance = slot0.New()

return slot0
