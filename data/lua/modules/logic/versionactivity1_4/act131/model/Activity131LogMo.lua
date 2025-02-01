module("modules.logic.versionactivity1_4.act131.model.Activity131LogMo", package.seeall)

slot0 = pureTable("Activity131LogMo")

function slot0.ctor(slot0)
	slot0.info = {}
end

function slot0.init(slot0, slot1, slot2, slot3)
	slot0._speaker = slot1
	slot0._speech = slot2
	slot0._audioId = slot3
end

function slot0.getSpeaker(slot0)
	return slot0._speaker
end

function slot0.getSpeech(slot0)
	return slot0._speech
end

function slot0.getAudioId(slot0)
	return slot0._audioId or 0
end

return slot0
