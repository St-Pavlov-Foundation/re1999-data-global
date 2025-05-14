module("modules.logic.main.controller.work.MainSignInWork", package.seeall)

local var_0_0 = class("MainSignInWork", BaseWork)

local function var_0_1()
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.SignIn) then
		return false
	end

	if not GuideModel.instance:isGuideFinish(108) then
		return false
	end

	if GuideModel.instance:isDoingClickGuide() and not GuideController.instance:isForbidGuides() then
		return false
	end

	local var_1_0 = SignInModel.instance:getCurDate()

	if SignInModel.instance:isSignDayRewardGet(var_1_0.day) then
		return false
	end

	return true
end

local function var_0_2()
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.MainViewGuideBlock) then
		return true
	end

	return not MainController.instance:isInMainView()
end

function var_0_0._isNeedWaitShow(arg_3_0)
	arg_3_0._isWaiting = var_0_2()

	return arg_3_0._isWaiting
end

function var_0_0.onStart(arg_4_0, arg_4_1)
	arg_4_0:clearWork()
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_4_0._onOpenViewFinish, arg_4_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_4_0._onCloseViewFinish, arg_4_0)
	arg_4_0:_tryStart()
end

function var_0_0._tryStart(arg_5_0)
	arg_5_0:_endBlock()

	if not arg_5_0:_isNeedWaitShow() then
		arg_5_0:_startSignInWork()
	end
end

function var_0_0._onOpenViewFinish(arg_6_0, arg_6_1)
	if arg_6_0._isWaiting then
		if arg_6_1 ~= ViewName.MainView then
			return
		end

		arg_6_0:_tryStart()
	elseif arg_6_0._isShowingLifeCircle then
		if arg_6_1 ~= ViewName.LifeCircleRewardView then
			return
		end

		arg_6_0:_endBlock()
	end
end

function var_0_0._onCloseViewFinish(arg_7_0, arg_7_1)
	if arg_7_0._isWaiting then
		arg_7_0:_tryStart()
	elseif arg_7_0._isShowingLifeCircle then
		local var_7_0 = ViewName.LifeCircleRewardView

		if arg_7_1 ~= var_7_0 then
			return
		end

		if ViewMgr.instance:isOpen(var_7_0) then
			return
		end

		arg_7_0:_showSignInDetailView()
	end
end

function var_0_0._startSignInWork(arg_8_0)
	arg_8_0:_startBlock()

	if not var_0_1() then
		arg_8_0:onDone(true)

		return
	end

	if LifeCircleController.instance:isClaimableAccumulateReward() then
		arg_8_0._isShowingLifeCircle = true

		LifeCircleController.instance:sendSignInTotalRewardAllRequest(function(arg_9_0, arg_9_1)
			arg_8_0:_endBlock()

			if arg_9_1 ~= 0 then
				arg_8_0:_showSignInDetailView()
			end
		end)

		return
	else
		arg_8_0:_showSignInDetailView()
	end
end

function var_0_0._showSignInDetailView(arg_10_0)
	arg_10_0._isShowingLifeCircle = false

	local var_10_0 = SignInModel.instance:getCurDate()

	SignInModel.instance:setTargetDate(tonumber(var_10_0.year), tonumber(var_10_0.month), tonumber(var_10_0.day))

	local var_10_1 = {
		callback = arg_10_0._closeSignInViewFinished,
		callbackObj = arg_10_0
	}

	ViewMgr.instance:openView(ViewName.SignInDetailView, var_10_1)
	arg_10_0:_endBlock()
end

function var_0_0._closeSignInViewFinished(arg_11_0)
	if not ViewMgr.instance:hasOpenFullView() and ViewMgr.instance:isOpen(ViewName.MainView) then
		arg_11_0:onDone(true)
	else
		TaskDispatcher.cancelTask(arg_11_0._onCheckEnterMainView, arg_11_0)
		TaskDispatcher.runRepeat(arg_11_0._onCheckEnterMainView, arg_11_0, 0.5)
	end
end

function var_0_0._onCheckEnterMainView(arg_12_0)
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
		arg_12_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_13_0)
	arg_13_0._isWaiting = false
	arg_13_0._isShowingLifeCircle = false

	TaskDispatcher.cancelTask(arg_13_0._onCheckEnterMainView, arg_13_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_13_0._onOpenViewFinish, arg_13_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_13_0._onCloseViewFinish, arg_13_0)
	arg_13_0:_endBlock()
end

function var_0_0._endBlock(arg_14_0)
	if not arg_14_0:_isBlock() then
		return
	end

	UIBlockMgr.instance:endBlock()
end

function var_0_0._startBlock(arg_15_0)
	if arg_15_0:_isBlock() then
		return
	end

	UIBlockMgr.instance:startBlock()
end

function var_0_0._isBlock(arg_16_0)
	return UIBlockMgr.instance:isBlock() and true or false
end

return var_0_0
