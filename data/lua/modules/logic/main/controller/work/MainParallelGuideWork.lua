module("modules.logic.main.controller.work.MainParallelGuideWork", package.seeall)

slot0 = class("MainParallelGuideWork", BaseWork)

function slot0.onStart(slot0, slot1)
	if GuideController.instance:isForbidGuides() then
		slot0:onDone(true)

		return
	end

	slot0:onDone(not slot0:_checkDoGuide())
end

function slot0._checkDoGuide(slot0)
	if tonumber(GuideModel.instance:getFlagValue(GuideModel.GuideFlag.MainViewGuideId)) and slot1 > 0 and (MainViewGuideCondition.getCondition(slot1) == nil and true or slot2()) then
		GuideController.instance:dispatchEvent(GuideEvent.DoMainViewGuide, slot1)

		return true
	end

	return false
end

return slot0
