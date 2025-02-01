module("modules.logic.guide.controller.GuideAudioPreloadController", package.seeall)

slot0 = class("GuideAudioPreloadController", BaseController)
slot1 = {
	[106.0] = true,
	[206.0] = true,
	[104.0] = true,
	[205.0] = true,
	[101.0] = true
}

function slot0.addConstEvents(slot0)
	GuideController.instance:registerCallback(GuideEvent.GuideEvent.StartGuideStep, slot0._onStartGuideStep, slot0)
	GuideController.instance:registerCallback(GuideEvent.GuideEvent.FinishGuideLastStep, slot0._onFinishGuide, slot0)
end

function slot0.onInit(slot0)
	slot0._preloadGuideIdDict = {}
end

function slot0.reInit(slot0)
	for slot4, slot5 in pairs(slot0._preloadGuideIdDict) do
		slot0:unload(slot4)
	end

	slot0._preloadGuideIdDict = {}
end

function slot0._onStartGuideStep(slot0, slot1, slot2)
	slot0:preload(slot1)
end

function slot0._onFinishGuide(slot0, slot1, slot2)
	slot0:unload(slot1)
end

function slot0.preload(slot0, slot1)
	if not uv0[slot1] then
		return
	end

	if slot0._preloadGuideIdDict[slot1] then
		return
	end

	slot0._preloadGuideIdDict[slot1] = {}

	for slot7, slot8 in ipairs(GuideConfig.instance:getStepList(slot1)) do
		slot9 = AudioConfig.instance:getAudioCOById(slot8.audio)

		if slot8.audio > 0 and slot9 then
			slot2[slot9.bankName] = true
		end
	end

	for slot7, slot8 in pairs(slot2) do
		ZProj.AudioManager.Instance:LoadBank(slot7)
	end
end

function slot0.unload(slot0, slot1)
	if slot0._preloadGuideIdDict[slot1] then
		slot0._preloadGuideIdDict[slot1] = nil

		for slot6, slot7 in pairs(slot2) do
			ZProj.AudioManager.Instance:UnloadBank(slot6)
		end
	end
end

slot0.instance = slot0.New()

return slot0
