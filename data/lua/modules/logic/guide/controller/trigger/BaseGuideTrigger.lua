module("modules.logic.guide.controller.trigger.BaseGuideTrigger", package.seeall)

slot0 = class("BaseGuideTrigger")

function slot0.ctor(slot0, slot1)
	slot0._triggerKey = slot1
	slot0._guideIdList = nil
	slot0._canTrigger = false
end

function slot0.onReset(slot0)
	slot0._canTrigger = false
end

function slot0.setCanTrigger(slot0, slot1)
	slot0._canTrigger = slot1
end

function slot0.assertGuideSatisfy(slot0, slot1, slot2)
	return false
end

function slot0.getParam(slot0)
	return nil
end

function slot0.hasSatisfyGuide(slot0)
	slot0:_classifyGuide()

	for slot5 = 1, slot0._guideIdList and #slot0._guideIdList or 0 do
		slot6 = slot0._guideIdList[slot5]
		slot8 = GuideConfig.instance:getGuideCO(slot6)

		if (GuideModel.instance:getById(slot6) == nil or slot7.isFinish and slot8.restart == 1) and not GuideInvalidController.instance:isInvalid(slot6) then
			if slot8.parallel ~= 1 and slot0:assertGuideSatisfy(slot0:getParam(), GuideConfig.instance:getTriggerParam(slot6)) then
				return true
			end
		end
	end

	return false
end

function slot0.checkStartGuide(slot0, slot1, slot2)
	if not slot0._canTrigger then
		return
	end

	if slot2 then
		slot0:_checkStartOneGuide(slot1, slot2)
	else
		slot0:_classifyGuide()

		for slot6 = 1, #slot0._guideIdList do
			slot0:_checkStartOneGuide(slot1, slot0._guideIdList[slot6])
		end
	end
end

function slot0._checkStartOneGuide(slot0, slot1, slot2)
	slot4 = GuideConfig.instance:getGuideCO(slot2)

	if GuideModel.instance:getById(slot2) == nil or slot3.isFinish and slot4.restart == 1 then
		if not GuideInvalidController.instance:isInvalid(slot2) and slot0:assertGuideSatisfy(slot1, GuideConfig.instance:getTriggerParam(slot2)) then
			if slot4.parallel == 1 then
				GuideController.instance:startGudie(slot2)
			elseif GuideModel.instance:getDoingGuideId() == nil then
				GuideController.instance:toStartGudie(slot2)
			end
		end
	end
end

function slot0._classifyGuide(slot0)
	if slot0._guideIdList == nil then
		slot0._guideIdList = {}

		for slot5, slot6 in ipairs(GuideConfig.instance:getGuideList()) do
			if GuideConfig.instance:getTriggerType(slot6.id) == slot0._triggerKey then
				table.insert(slot0._guideIdList, slot6.id)
			end
		end
	end
end

return slot0
