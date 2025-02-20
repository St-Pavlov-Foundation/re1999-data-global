module("modules.logic.guide.controller.action.impl.GuideActionAdditionCondition", package.seeall)

slot0 = class("GuideActionAdditionCondition", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot2 = string.split(slot0.actionParam, "#")
	slot6 = slot2[4]

	if slot0[slot2[1]] and slot7(slot0, slot2[2]) then
		slot0:additionStepId(slot0.sourceGuideId or slot0.guideId, slot2[3])
	else
		slot0:additionStepId(slot0.sourceGuideId or slot0.guideId, slot6)
	end

	slot0:onDone(true)
end

function slot0.additionStepId(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	if not GuideStepController.instance:getActionFlow(slot1) then
		return
	end

	if not string.nilorempty(slot2) then
		slot3:addWork(GuideActionBuilder.buildAction(slot1, 0, string.gsub(string.gsub(slot2, "&", "|"), "*", "#")))
	end
end

function slot0.checkRoomTaskHasFinished(slot0)
	slot1, slot2 = RoomSceneTaskController.instance:isFirstTaskFinished()

	return slot1
end

return slot0
