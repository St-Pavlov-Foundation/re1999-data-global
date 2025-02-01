module("modules.logic.main.controller.work.ActivityRoleSignWorkBase", package.seeall)

slot0 = class("ActivityRoleSignWorkBase", BaseWork)
slot1 = 0

function slot2(slot0)
	if not slot0._viewNames then
		slot0._viewNames = assert(slot0:onGetViewNames())
	end
end

function slot3(slot0)
	if not slot0._actIds then
		slot0._actIds = assert(slot0:onGetActIds())
	end
end

function slot0.onStart(slot0)
	uv0(slot0)
	uv1(slot0)

	uv2 = 0

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
	slot2 = slot0._viewName

	if not slot0._actId then
		return
	end

	if not ActivityType101Model.instance:isType101RewardCouldGetAnyOne(slot1) then
		if ViewMgr.instance:isOpen(slot2) then
			return
		end

		slot0:_work()

		return
	end

	ViewMgr.instance:openView(slot2, {
		actId = slot1
	})
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
	slot0:_endBlock()
	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideLastStep, slot0._work, slot0)
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, slot0._refreshNorSignActivity, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0)

	slot0._actId = nil
	slot0._viewName = nil
end

function slot0._pop(slot0)
	uv0 = uv0 + 1

	return slot0._actIds[uv0], slot0._viewNames[uv0]
end

function slot0._work(slot0)
	slot0:_startBlock()

	slot0._actId, slot0._viewName = slot0:_pop()

	if not slot0._actId then
		slot0:onDone(true)

		return
	end

	if ActivityType101Model.instance:isOpen(slot1) then
		Activity101Rpc.instance:sendGet101InfosRequest(slot1)

		return
	end

	slot0:_work()
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

function slot0.onGetViewNames(slot0)
	assert(false, "please override this function")
end

function slot0.onGetActIds(slot0)
	assert(false, "please override this function")
end

return slot0
