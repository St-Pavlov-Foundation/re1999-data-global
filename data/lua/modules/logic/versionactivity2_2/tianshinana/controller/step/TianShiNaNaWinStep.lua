module("modules.logic.versionactivity2_2.tianshinana.controller.step.TianShiNaNaWinStep", package.seeall)

slot0 = class("TianShiNaNaWinStep", TianShiNaNaStepBase)

function slot0.onStart(slot0, slot1)
	if TianShiNaNaModel.instance.episodeCo.storyClear > 0 then
		slot0._initMaskActive = PostProcessingMgr.instance:getUIPPValue("LocalMaskActive")
		slot0._initDistortStrength = PostProcessingMgr.instance:getUIPPValue("LocalDistortStrength")

		PostProcessingMgr.instance:setUIPPValue("LocalMaskActive", false)
		PostProcessingMgr.instance:setUIPPValue("localDistortStrength", 0)
		StoryController.instance:playStory(slot2, nil, slot0._onStoryEnd, slot0)
	else
		slot0:_onStoryEnd()
	end
end

function slot0._onStoryEnd(slot0)
	ViewMgr.instance:openView(ViewName.TianShiNaNaResultView, {
		isWin = true,
		star = slot0._data.star
	})
	slot0:onDone(false)
end

function slot0.clearWork(slot0)
	if slot0._initMaskActive ~= nil then
		PostProcessingMgr.instance:setUIPPValue("LocalMaskActive", slot0._initMaskActive)
		PostProcessingMgr.instance:setUIPPValue("LocalDistortStrength", slot0._initDistortStrength)
	end
end

return slot0
