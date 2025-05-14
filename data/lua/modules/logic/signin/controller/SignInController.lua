module("modules.logic.signin.controller.SignInController", package.seeall)

local var_0_0 = class("SignInController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0._curMonth = 0
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:stopCheckEnterMainView()
end

function var_0_0.addConstEvents(arg_3_0)
	MainController.instance:registerCallback(MainEvent.OnFuncUnlockRefresh, arg_3_0._onFuncUnlock, arg_3_0)
	MainController.instance:registerCallback(MainEvent.OnMainPopupFlowFinish, arg_3_0._onCheckSignIn, arg_3_0)
	GuideController.instance:registerCallback(GuideEvent.FinishGuideLastStep, arg_3_0._onCheckSignIn, arg_3_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_3_0._onDailyRefresh, arg_3_0)
end

function var_0_0._onDailyRefresh(arg_4_0)
	arg_4_0:sendGetSignInInfoRequestIfUnlock()
end

function var_0_0._onFuncUnlock(arg_5_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.SignIn) then
		return
	end

	arg_5_0:_onCheckSignIn()
end

function var_0_0._onCheckSignIn(arg_6_0, arg_6_1)
	if GuideController.instance:isGuiding() and arg_6_1 ~= GuideModel.instance:lastForceGuideId() then
		arg_6_0:stopCheckEnterMainView()

		return
	end

	arg_6_0:stopCheckEnterMainView()

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.SignIn) then
		return
	end

	local var_6_0 = SignInModel.instance:getCurDate()

	if ViewMgr.instance:isOpen(ViewName.SignInView) or ViewMgr.instance:isOpen(ViewName.SignInDetailView) then
		local var_6_1 = SignInModel.instance:getSignTargetDate()

		if var_6_1[1] ~= tonumber(var_6_0.year) or var_6_1[2] ~= tonumber(var_6_0.month) or var_6_1[3] ~= tonumber(var_6_0.day) then
			SignInModel.instance:setTargetDate(tonumber(var_6_0.year), tonumber(var_6_0.month), tonumber(var_6_0.day))

			arg_6_0._curMonth = var_6_0.month

			arg_6_0:sendGetSignInInfoRequestIfUnlock()
		end
	else
		TaskDispatcher.runRepeat(arg_6_0._onCheckEnterMainView, arg_6_0, 0.5)
	end
end

function var_0_0._onCheckEnterMainView(arg_7_0)
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.MainViewGuideBlock) then
		return
	end

	if not MainController.instance:isInMainView() then
		return
	end

	local var_7_0 = SignInModel.instance:getCurDate()

	if SignInModel.instance:isSignDayRewardGet(var_7_0.day) then
		arg_7_0:stopCheckEnterMainView()

		return
	end

	if GuideModel.instance:isDoingClickGuide() and not GuideController.instance:isForbidGuides() then
		return
	end

	if GuideController.instance:isGuiding() then
		return
	end

	if not ViewMgr.instance:hasOpenFullView() and ViewMgr.instance:isOpen(ViewName.MainView) then
		SignInModel.instance:setAutoSign(true)
		arg_7_0:sendGetSignInInfoRequestIfUnlock()

		local var_7_1 = {}

		var_7_1.isBirthday = false

		arg_7_0:openSignInDetailView(var_7_1)
		arg_7_0:stopCheckEnterMainView()

		arg_7_0._curMonth = var_7_0.month
	end
end

function var_0_0.stopCheckEnterMainView(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._onCheckEnterMainView, arg_8_0)
end

function var_0_0.openSignInView(arg_9_0, arg_9_1)
	local var_9_0 = SignInModel.instance:getCurDate()

	SignInModel.instance:setTargetDate(tonumber(var_9_0.year), tonumber(var_9_0.month), tonumber(var_9_0.day))
	ViewMgr.instance:openView(ViewName.SignInView, arg_9_1)
end

function var_0_0.openSignInDetailView(arg_10_0, arg_10_1)
	local var_10_0 = SignInModel.instance:getCurDate()

	if SignInModel.instance:isSignDayRewardGet(var_10_0.day) then
		arg_10_0:openSignInView(arg_10_1)

		return
	end

	local var_10_1 = {
		isBirthday = arg_10_1.isBirthday,
		callback = arg_10_1.callback,
		callbackObj = arg_10_1.callbackObj
	}

	SignInModel.instance:setTargetDate(tonumber(var_10_0.year), tonumber(var_10_0.month), tonumber(var_10_0.day))
	ViewMgr.instance:openView(ViewName.SignInDetailView, var_10_1)
end

function var_0_0.setSigninReward(arg_11_0, arg_11_1)
	if arg_11_0:checkIsBirthdayBlock(arg_11_1) then
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, arg_11_1)
	elseif SignInModel.instance:checkDailyAllowanceIsOpen() then
		if not SignInModel.instance:checkIsFirstGoldDay() then
			local var_11_0 = SigninRewardMo.New()
			local var_11_1 = SignInModel.instance:getDailyAllowanceBonus()

			if var_11_1 then
				local var_11_2 = string.splitToNumber(var_11_1, "#")

				var_11_0:initValue(var_11_2[1], var_11_2[2], var_11_2[3], nil, true)
				table.insert(arg_11_1, var_11_0)
			end

			PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, arg_11_1)
		else
			PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, arg_11_1)
		end
	else
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, arg_11_1)
	end
end

function var_0_0.checkIsBirthdayBlock(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in pairs(arg_12_1) do
		if iter_12_1 and iter_12_1.materilType == MaterialEnum.MaterialType.SpecialBlock then
			return true
		end
	end

	return false
end

function var_0_0.sendGetSignInInfoRequestIfUnlock(arg_13_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.SignIn) then
		return
	end

	SignInRpc.instance:sendGetSignInInfoRequest()
end

var_0_0.instance = var_0_0.New()

return var_0_0
