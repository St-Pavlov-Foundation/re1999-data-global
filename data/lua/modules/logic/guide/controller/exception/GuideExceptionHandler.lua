module("modules.logic.guide.controller.exception.GuideExceptionHandler", package.seeall)

slot0 = _M

function slot0.finishStep(slot0, slot1)
	GuideController.instance:finishStep(slot0, slot1, true)
end

function slot0.finishGuide(slot0, slot1, slot2)
	GuideController.instance:oneKeyFinishGuide(slot0, true)
end

function slot0.gotoStep(slot0, slot1, slot2)
	slot4 = tonumber(slot2)
	slot5, slot6 = nil

	for slot11 = #GuideConfig.instance:getStepList(slot0), 1, -1 do
		if slot7[slot11].stepId == GuideModel.instance:getById(slot0).currStepId then
			if slot12.keyStep == 1 then
				slot6 = slot13
			end

			break
		elseif slot5 then
			if slot12.keyStep == 1 then
				slot6 = slot13

				break
			end
		elseif slot13 == slot4 then
			slot5 = true
		end
	end

	if slot6 then
		slot3:toGotoStep(slot4)
		GuideRpc.instance:sendFinishGuideRequest(slot0, slot6)
	else
		slot3:gotoStep(slot4)
		GuideStepController.instance:clearFlow(slot0)
		GuideController.instance:execNextStep(slot0)
	end
end

function slot0.openView(slot0, slot1, slot2)
	ViewMgr.instance:openView(slot2)
end

function slot0.closeView(slot0, slot1, slot2)
	ViewMgr.instance:closeView(slot2, true)
end

return slot0
