module("modules.logic.guide.controller.action.impl.GuideActionRoomFixBlockMaskPos", package.seeall)

slot0 = class("GuideActionRoomFixBlockMaskPos", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	if gohelper.isNil(gohelper.find(GuideModel.instance:getStepGOPath(slot0.guideId, slot0.stepId))) then
		logError(slot0.guideId .. "_" .. slot0.stepId .. " blockGO is nil: " .. slot2)
		slot0:onDone(true)

		return
	end

	if ViewMgr.instance:isOpenFinish(ViewName.GuideView) then
		slot0:_fixPos()
	else
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0._checkOpenView, slot0)
	end
end

function slot0._checkOpenView(slot0, slot1)
	if slot1 == ViewName.GuideView then
		slot0:_fixPos()
	end
end

function slot0._fixPos(slot0)
	slot4 = ViewMgr.instance:getContainer(ViewName.GuideView) and slot3.viewGO
	slot5 = slot4 and slot4.transform
	slot6 = gohelper.find(GuideModel.instance:getStepGOPath(slot0.guideId, slot0.stepId)).transform.position

	GuideController.instance:dispatchEvent(GuideEvent.SetMaskOffset, recthelper.worldPosToAnchorPos(RoomBendingHelper.worldToBendingSimple(slot6), slot5) - recthelper.worldPosToAnchorPos(slot6, slot5))
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0._checkOpenView, slot0)
end

function slot0.onDestroy(slot0)
	uv0.super.onDestroy(slot0)
	GuideController.instance:dispatchEvent(GuideEvent.SetMaskOffset, nil)
end

return slot0
