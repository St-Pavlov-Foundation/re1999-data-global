module("modules.logic.guide.controller.action.impl.WaitGuideActionRoomLineLvUpSatisfy", package.seeall)

slot0 = class("WaitGuideActionRoomLineLvUpSatisfy", BaseGuideAction)
slot1 = "1#190007#8"

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)
	BackpackController.instance:registerCallback(BackpackEvent.UpdateItemList, slot0._check, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0._check, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._check, slot0)
	RoomController.instance:registerCallback(RoomEvent.GuideOpenInitBuilding1, slot0._delayCheck, slot0)
	RoomController.instance:registerCallback(RoomEvent.GuideOpenInitBuilding2, slot0._delayCheck, slot0)

	slot0._nextStepBtn = GuideConfig.instance:getStepCO(slot0.guideId, GuideConfig.instance:getNextStepId(slot0.guideId, slot0.stepId)) and slot3.goPath
	slot0._material = GameUtil.splitString2(uv1, true)
	slot0._openView = ViewName.RoomInitBuildingView
	slot0._blockViews = {
		[ViewName.CommonPropView] = true,
		[ViewName.GuideView] = true
	}
end

function slot0._delayCheck(slot0)
	TaskDispatcher.runRepeat(slot0._check, slot0, 0.0333, 30)
end

function slot0._check(slot0)
	if slot0:_checkOpenView() and slot0:_checkMaterials() and slot0:_checkBtnExist() then
		slot0:onDone(true)
	end
end

function slot0._checkBtnExist(slot0)
	return GuideUtil.isGOShowInScreen(gohelper.find(slot0._nextStepBtn))
end

function slot0._checkOpenView(slot0)
	if ViewMgr.instance:isOpenFinish(slot0._openView) then
		for slot5 = #ViewMgr.instance:getOpenViewNameList(), 1, -1 do
			if slot1[slot5] == slot0._openView then
				return true
			end

			if ViewMgr.instance:isFull(slot6) or ViewMgr.instance:isModal(slot6) or slot0._blockViews[slot6] then
				return false
			end
		end
	end
end

function slot0._checkMaterials(slot0)
	slot1 = true

	for slot5, slot6 in ipairs(slot0._material) do
		if ItemModel.instance:getItemQuantity(slot6[1], slot6[2]) < slot6[3] then
			slot1 = false

			break
		end
	end

	if slot1 then
		return true
	end
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._check, slot0)
	BackpackController.instance:unregisterCallback(BackpackEvent.UpdateItemList, slot0._checkMaterials, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0._check, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._check, slot0)
	RoomController.instance:unregisterCallback(RoomEvent.GuideOpenInitBuilding1, slot0._delayCheck, slot0)
	RoomController.instance:unregisterCallback(RoomEvent.GuideOpenInitBuilding2, slot0._delayCheck, slot0)
end

return slot0
