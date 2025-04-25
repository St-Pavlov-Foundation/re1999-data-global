module("modules.logic.main.controller.work.MainSignInWork", package.seeall)

slot0 = class("MainSignInWork", BaseWork)

function slot1()
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

function slot2()
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.MainViewGuideBlock) then
		return true
	end

	return not MainController.instance:isInMainView()
end

function slot0._isNeedWaitShow(slot0)
	slot0._isWaiting = uv0()

	return slot0._isWaiting
end

function slot0.onStart(slot0, slot1)
	slot0:clearWork()
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	slot0:_tryStart()
end

function slot0._tryStart(slot0)
	slot0:_endBlock()

	if not slot0:_isNeedWaitShow() then
		slot0:_startSignInWork()
	end
end

function slot0._onOpenViewFinish(slot0, slot1)
	if slot0._isWaiting then
		if slot1 ~= ViewName.MainView then
			return
		end

		slot0:_tryStart()
	elseif slot0._isShowingLifeCircle then
		if slot1 ~= ViewName.LifeCircleRewardView then
			return
		end

		slot0:_endBlock()
	end
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot0._isWaiting then
		slot0:_tryStart()
	elseif slot0._isShowingLifeCircle then
		if slot1 ~= ViewName.LifeCircleRewardView then
			return
		end

		if ViewMgr.instance:isOpen(slot2) then
			return
		end

		slot0:_showSignInDetailView()
	end
end

function slot0._startSignInWork(slot0)
	slot0:_startBlock()

	if not uv0() then
		slot0:onDone(true)

		return
	end

	if LifeCircleController.instance:isClaimableAccumulateReward() then
		slot0._isShowingLifeCircle = true

		LifeCircleController.instance:sendSignInTotalRewardAllRequest(function (slot0, slot1)
			uv0:_endBlock()

			if slot1 ~= 0 then
				uv0:_showSignInDetailView()
			end
		end)

		return
	else
		slot0:_showSignInDetailView()
	end
end

function slot0._showSignInDetailView(slot0)
	slot0._isShowingLifeCircle = false
	slot1 = SignInModel.instance:getCurDate()

	SignInModel.instance:setTargetDate(tonumber(slot1.year), tonumber(slot1.month), tonumber(slot1.day))
	ViewMgr.instance:openView(ViewName.SignInDetailView, {
		callback = slot0._closeSignInViewFinished,
		callbackObj = slot0
	})
	slot0:_endBlock()
end

function slot0._closeSignInViewFinished(slot0)
	if not ViewMgr.instance:hasOpenFullView() and ViewMgr.instance:isOpen(ViewName.MainView) then
		slot0:onDone(true)
	else
		TaskDispatcher.cancelTask(slot0._onCheckEnterMainView, slot0)
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
		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	slot0._isWaiting = false
	slot0._isShowingLifeCircle = false

	TaskDispatcher.cancelTask(slot0._onCheckEnterMainView, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	slot0:_endBlock()
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
