module("modules.logic.versionactivity1_6.act152.controller.work.Activity152PatFaceWork", package.seeall)

slot0 = class("Activity152PatFaceWork", PatFaceWorkBase)

function slot0.onStart(slot0, slot1)
	if not ActivityModel.instance:isActOnLine(ActivityEnum.Activity.NewYearEve) then
		slot0:onDone(true)

		return
	end

	slot0:_startPatFaceWork()
end

function slot0._needWaitShow(slot0)
	if GuideModel.instance:isDoingClickGuide() and not GuideController.instance:isForbidGuides() then
		return true
	end

	return not MainController.instance:isInMainView()
end

function slot0._startCheckShow(slot0)
	TaskDispatcher.cancelTask(slot0._startPatFaceWork, slot0)
	TaskDispatcher.runRepeat(slot0._startPatFaceWork, slot0, 0.5)
end

function slot0._startPatFaceWork(slot0)
	if not ActivityModel.instance:isActOnLine(ActivityEnum.Activity.NewYearEve) then
		slot0:onDone(true)

		return
	end

	if slot0:_needWaitShow() then
		slot0:_startCheckShow()

		return
	end

	TaskDispatcher.cancelTask(slot0._startPatFaceWork, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0._checkRewardGet, slot0)

	if #Activity152Model.instance:getPresentUnaccepted() > 0 then
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onGetGift, slot0)
		Activity152Controller.instance:openNewYearGiftView(slot1[1])
	else
		slot0:onDone(true)
	end
end

function slot0._onGetGift(slot0, slot1)
	if slot1 ~= ViewName.NewYearEveGiftView then
		return
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onGetGift, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0._checkRewardGet, slot0)
	Activity152Rpc.instance:sendAct152AcceptPresentRequest(ActivityEnum.Activity.NewYearEve, Activity152Model.instance:getPresentUnaccepted()[1], slot0._enterNext, slot0)
end

function slot0._enterNext(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		slot0:onDone(true)

		return
	end

	Activity152Model.instance:setActivity152PresentGet(slot3.present.presentId)
end

function slot0._checkRewardGet(slot0, slot1)
	if slot1 ~= ViewName.CommonPropView then
		return
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0._checkRewardGet, slot0)
	slot0:_startPatFaceWork()
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._startPatFaceWork, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0._checkRewardGet, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onGetGift, slot0)
end

return slot0
