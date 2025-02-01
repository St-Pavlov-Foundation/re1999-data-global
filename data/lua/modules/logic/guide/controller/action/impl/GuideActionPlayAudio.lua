module("modules.logic.guide.controller.action.impl.GuideActionPlayAudio", package.seeall)

slot0 = class("GuideActionPlayAudio", BaseGuideAction)

function slot0.ctor(slot0, slot1, slot2, slot3)
	uv0.super.ctor(slot0, slot1, slot2, slot3)

	slot0._audioId = tonumber(slot3) or nil
end

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	if slot0._audioId then
		GuideAudioMgr.instance:playAudio(slot0._audioId)
	else
		logError("Guide audio id nil, guide_" .. slot0.guideId .. "_" .. slot0.stepId)
	end

	slot0:onDone(true)
end

function slot0.onDestroy(slot0, slot1)
	if slot0._audioId then
		GuideAudioMgr.instance:stopAudio()
	end
end

return slot0
