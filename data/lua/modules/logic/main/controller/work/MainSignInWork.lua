module("modules.logic.main.controller.work.MainSignInWork", package.seeall)

slot0 = class("MainSignInWork", BaseWork)

function slot0._checkShow()
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.SignIn) then
		return false
	end

	if not GuideModel.instance:isGuideFinish(108) then
		return false
	end

	if GuideModel.instance:isDoingClickGuide() and not GuideController.instance:isForbidGuides() then
		return false
	end

	if SignInModel.instance:isSignDayRewardGet(SignInModel.instance:getCurDate().day) then
		return false
	end

	return true
end

function slot0._needWaitShow()
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.MainViewGuideBlock) then
		return true
	end

	return not MainController.instance:isInMainView()
end

function slot0.onStart(slot0, slot1)
	UIBlockMgr.instance:startBlock("waitStartSignIn")
	TaskDispatcher.runDelay(slot0._waitStartSignInWork, slot0, 0.1)
end

function slot0._waitStartSignInWork(slot0)
	UIBlockMgr.instance:endBlock("waitStartSignIn")

	if uv0._needWaitShow() then
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0)
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._viewChangeCheckIsInMainView, slot0)

		return
	end

	slot0:_startSignInWork()
end

function slot0._removeViewChangeEvent(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._viewChangeCheckIsInMainView, slot0)
end

function slot0._onOpenViewFinish(slot0, slot1)
	if slot1 ~= ViewName.MainView then
		return
	end

	slot0:_viewChangeCheckIsInMainView()
end

function slot0._viewChangeCheckIsInMainView(slot0)
	if uv0._needWaitShow() then
		return
	end

	slot0:_removeViewChangeEvent()
	UIBlockMgr.instance:startBlock("waitStartSignIn")
	TaskDispatcher.runDelay(slot0._waitStartSignInWork, slot0, 0.6)
end

function slot0._startSignInWork(slot0)
	if not uv0._checkShow() then
		slot0:onDone(true)

		return
	end

	slot1 = SignInModel.instance:getCurDate()

	SignInModel.instance:setTargetDate(tonumber(slot1.year), tonumber(slot1.month), tonumber(slot1.day))
	ViewMgr.instance:openView(ViewName.SignInDetailView, {
		callback = slot0._closeSignInViewFinished,
		callbackObj = slot0
	})
end

function slot0._closeSignInViewFinished(slot0)
	if not ViewMgr.instance:hasOpenFullView() and ViewMgr.instance:isOpen(ViewName.MainView) then
		slot0:onDone(true)
	else
		TaskDispatcher.runRepeat(slot0._onCheckEnterMainView, slot0, 0.5)
	end
end

function slot0._onCheckEnterMainView(slot0)
	if not MainController.instance:isInMainView() then
		return
	end

	if GuideModel.instance:isDoingClickGuide() and not GuideController.instance:isForbidGuides() then
		return
	end

	if GuideController.instance:isGuiding() then
		return
	end

	if not ViewMgr.instance:hasOpenFullView() and ViewMgr.instance:isOpen(ViewName.MainView) then
		TaskDispatcher.cancelTask(slot0._onCheckEnterMainView, slot0)
		slot0:onDone(true)
	end
end

function slot0.onDestroy(slot0)
	slot0:_removeViewChangeEvent()
	UIBlockMgr.instance:endBlock("waitStartSignIn")
	TaskDispatcher.cancelTask(slot0._waitStartSignInWork, slot0)
	TaskDispatcher.cancelTask(slot0._onCheckEnterMainView, slot0)
end

return slot0
