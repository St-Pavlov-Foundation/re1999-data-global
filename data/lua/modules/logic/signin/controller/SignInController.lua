module("modules.logic.signin.controller.SignInController", package.seeall)

slot0 = class("SignInController", BaseController)

function slot0.onInit(slot0)
	slot0._curMonth = 0
end

function slot0.reInit(slot0)
	slot0:stopCheckEnterMainView()
end

function slot0.addConstEvents(slot0)
	MainController.instance:registerCallback(MainEvent.OnFuncUnlockRefresh, slot0._onFuncUnlock, slot0)
	MainController.instance:registerCallback(MainEvent.OnMainPopupFlowFinish, slot0._onCheckSignIn, slot0)
	GuideController.instance:registerCallback(GuideEvent.FinishGuideLastStep, slot0._onCheckSignIn, slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0._onDailyRefresh, slot0)
end

function slot0._onDailyRefresh(slot0)
	slot0:sendGetSignInInfoRequestIfUnlock()
end

function slot0._onFuncUnlock(slot0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.SignIn) then
		return
	end

	slot0:_onCheckSignIn()
end

function slot0._onCheckSignIn(slot0, slot1)
	if GuideController.instance:isGuiding() and slot1 ~= GuideModel.instance:lastForceGuideId() then
		slot0:stopCheckEnterMainView()

		return
	end

	slot0:stopCheckEnterMainView()

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.SignIn) then
		return
	end

	slot2 = SignInModel.instance:getCurDate()

	if ViewMgr.instance:isOpen(ViewName.SignInView) or ViewMgr.instance:isOpen(ViewName.SignInDetailView) then
		if SignInModel.instance:getSignTargetDate()[1] ~= tonumber(slot2.year) or slot3[2] ~= tonumber(slot2.month) or slot3[3] ~= tonumber(slot2.day) then
			SignInModel.instance:setTargetDate(tonumber(slot2.year), tonumber(slot2.month), tonumber(slot2.day))

			slot0._curMonth = slot2.month

			slot0:sendGetSignInInfoRequestIfUnlock()
		end
	else
		TaskDispatcher.runRepeat(slot0._onCheckEnterMainView, slot0, 0.5)
	end
end

function slot0._onCheckEnterMainView(slot0)
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.MainViewGuideBlock) then
		return
	end

	if not MainController.instance:isInMainView() then
		return
	end

	if SignInModel.instance:isSignDayRewardGet(SignInModel.instance:getCurDate().day) then
		slot0:stopCheckEnterMainView()

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
		slot0:sendGetSignInInfoRequestIfUnlock()
		slot0:openSignInDetailView({
			isBirthday = false
		})
		slot0:stopCheckEnterMainView()

		slot0._curMonth = slot3.month
	end
end

function slot0.stopCheckEnterMainView(slot0)
	TaskDispatcher.cancelTask(slot0._onCheckEnterMainView, slot0)
end

function slot0.openSignInView(slot0, slot1)
	slot2 = SignInModel.instance:getCurDate()

	SignInModel.instance:setTargetDate(tonumber(slot2.year), tonumber(slot2.month), tonumber(slot2.day))
	ViewMgr.instance:openView(ViewName.SignInView, slot1)
end

function slot0.openSignInDetailView(slot0, slot1)
	if SignInModel.instance:isSignDayRewardGet(SignInModel.instance:getCurDate().day) then
		slot0:openSignInView(slot1)

		return
	end

	SignInModel.instance:setTargetDate(tonumber(slot2.year), tonumber(slot2.month), tonumber(slot2.day))
	ViewMgr.instance:openView(ViewName.SignInDetailView, {
		isBirthday = slot1.isBirthday,
		callback = slot1.callback,
		callbackObj = slot1.callbackObj
	})
end

function slot0.setSigninReward(slot0, slot1)
	if slot0:checkIsBirthdayBlock(slot1) then
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, slot1)
	elseif SignInModel.instance:checkDailyAllowanceIsOpen() then
		if not SignInModel.instance:checkIsFirstGoldDay() then
			slot2 = SigninRewardMo.New()

			if SignInModel.instance:getDailyAllowanceBonus() then
				slot4 = string.splitToNumber(slot3, "#")

				slot2:initValue(slot4[1], slot4[2], slot4[3], nil, true)
				table.insert(slot1, slot2)
			end

			PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, slot1)
		else
			PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, slot1)
		end
	else
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, slot1)
	end
end

function slot0.checkIsBirthdayBlock(slot0, slot1)
	for slot5, slot6 in pairs(slot1) do
		if slot6 and slot6.materilType == MaterialEnum.MaterialType.SpecialBlock then
			return true
		end
	end

	return false
end

function slot0.sendGetSignInInfoRequestIfUnlock(slot0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.SignIn) then
		return
	end

	SignInRpc.instance:sendGetSignInInfoRequest()
end

slot0.instance = slot0.New()

return slot0
