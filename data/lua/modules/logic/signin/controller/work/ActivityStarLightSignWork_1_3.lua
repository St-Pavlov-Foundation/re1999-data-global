module("modules.logic.signin.controller.work.ActivityStarLightSignWork_1_3", package.seeall)

slot0 = class("ActivityStarLightSignWork_1_3", BaseWork)
slot1 = 0
slot2 = {
	ActivityEnum.Activity.StarLightSignPart1_1_3,
	ActivityEnum.Activity.StarLightSignPart2_1_3
}

function slot3()
	if not uv0.kViewNames then
		uv0.kViewNames = {
			ViewName.ActivityStarLightSignPart1PaiLianView_1_3,
			ViewName.ActivityStarLightSignPart2PaiLianView_1_3
		}
	end
end

function slot0.onStart(slot0)
	uv0()

	if slot0:_isExistGuide() then
		slot0:_endBlock()
		GuideController.instance:registerCallback(GuideEvent.FinishGuideLastStep, slot0._work, slot0)
	else
		slot0:_work()
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, slot0._refreshNorSignActivity, slot0)
end

function slot0._refreshNorSignActivity(slot0)
	if not slot0._actId then
		return
	end

	if not ActivityType101Model.instance:isType101RewardCouldGetAnyOne(slot0._actId) then
		if ViewMgr.instance:isOpen(slot0._viewName) then
			return
		end

		slot0:_work()

		return
	end

	ViewMgr.instance:openView(slot0._viewName)
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 ~= slot0._viewName then
		return
	end

	if ViewMgr.instance:isOpen(slot0._viewName) then
		return
	end

	slot0:_work()
end

function slot0._onOpenViewFinish(slot0, slot1)
	if slot1 ~= slot0._viewName then
		return
	end

	slot0:_endBlock()
end

function slot0.clearWork(slot0)
	if not slot0.isSuccess then
		slot0:_endBlock()
	end

	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideLastStep, slot0._work, slot0)
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, slot0._refreshNorSignActivity, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0)

	slot0._actId = nil
	slot0._viewName = nil
	uv0 = 0
end

function slot0._pop(slot0)
	uv0 = uv0 + 1

	return uv2[uv0], uv1.kViewNames[uv0]
end

function slot0._work(slot0)
	slot0:_startBlock()

	slot0._actId, slot0._viewName = slot0:_pop()

	if not slot0._actId then
		slot0:onDone(true)

		return
	end

	if ActivityModel.instance:isActOnLine(slot0._actId) then
		Activity101Rpc.instance:sendGet101InfosRequest(slot1)
	else
		return slot0:_work()
	end
end

function slot0._isExistGuide(slot0)
	if GuideModel.instance:isDoingClickGuide() and not GuideController.instance:isForbidGuides() then
		return true
	end

	if GuideController.instance:isGuiding() then
		return true
	end

	return false
end

function slot0._endBlock(slot0)
	if not slot0:_isBlock() then
		return
	end

	UIBlockMgr.instance:endBlock()
end

function slot0._startBlock(slot0)
	if slot0:_isBlock() then
		return
	end

	UIBlockMgr.instance:startBlock()
end

function slot0._isBlock(slot0)
	return UIBlockMgr.instance:isBlock() and true or false
end

return slot0
