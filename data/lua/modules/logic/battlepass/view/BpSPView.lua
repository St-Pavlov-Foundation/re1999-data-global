module("modules.logic.battlepass.view.BpSPView", package.seeall)

local var_0_0 = class("BpSPView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnSelectBonus = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left/#btn_faj")
	arg_1_0._txtLevel = gohelper.findChildText(arg_1_0.viewGO, "right/level/#txtLevel")
	arg_1_0._txtScore = gohelper.findChildText(arg_1_0.viewGO, "right/score/#txtScore")
	arg_1_0._goWeeklyLimit = gohelper.findChild(arg_1_0.viewGO, "right/weeklimit")
	arg_1_0._txtWeeklyLimit = gohelper.findChildText(arg_1_0.viewGO, "right/weeklimit/#txtWeeklyLimit")
	arg_1_0._sliderScore = gohelper.findChildSlider(arg_1_0.viewGO, "right/Slider")
	arg_1_0._sliderImage = gohelper.findChildImage(arg_1_0.viewGO, "right/slidervx")
	arg_1_0._sliderAnim = gohelper.findChild(arg_1_0.viewGO, "right/slidervx/ani")
	arg_1_0._sliderBg = gohelper.findChild(arg_1_0.viewGO, "right/Slider/Fill Area/Fill")
	arg_1_0._gomax = gohelper.findChild(arg_1_0.viewGO, "right/#go_max")
	arg_1_0._btnInfo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_info", AudioEnum.UI.UI_role_introduce_open)
	arg_1_0._btnRule = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_rule")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnSelectBonus:AddClickListener(arg_2_0._onClickSelectBonus, arg_2_0)
	arg_2_0._btnInfo:AddClickListener(arg_2_0.openStoryTips, arg_2_0)
	arg_2_0._btnRule:AddClickListener(arg_2_0.openTips, arg_2_0)
	arg_2_0:addEventCb(BpController.instance, BpEvent.OnGetInfo, arg_2_0._updateLevelScore, arg_2_0)
	arg_2_0:addEventCb(BpController.instance, BpEvent.OnUpdateScore, arg_2_0._updateLevelScore, arg_2_0)
	arg_2_0:addEventCb(BpController.instance, BpEvent.OnUpdatePayStatus, arg_2_0._updateLevelScore, arg_2_0)
	arg_2_0:addEventCb(BpController.instance, BpEvent.OnBuyLevel, arg_2_0._updateLevelScore, arg_2_0)
	arg_2_0:addEventCb(BpController.instance, BpEvent.ForcePlayBonusAnim, arg_2_0._forcePlayBonusAnim, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnSelectBonus:RemoveClickListener()
	arg_3_0._btnInfo:RemoveClickListener()
	arg_3_0._btnRule:RemoveClickListener()
	arg_3_0:removeEventCb(BpController.instance, BpEvent.OnGetInfo, arg_3_0._updateLevelScore, arg_3_0)
	arg_3_0:removeEventCb(BpController.instance, BpEvent.OnUpdateScore, arg_3_0._updateLevelScore, arg_3_0)
	arg_3_0:removeEventCb(BpController.instance, BpEvent.OnUpdatePayStatus, arg_3_0._updateLevelScore, arg_3_0)
	arg_3_0:removeEventCb(BpController.instance, BpEvent.OnBuyLevel, arg_3_0._updateLevelScore, arg_3_0)
	arg_3_0:removeEventCb(BpController.instance, BpEvent.ForcePlayBonusAnim, arg_3_0._forcePlayBonusAnim, arg_3_0)
end

function var_0_0._forcePlayBonusAnim(arg_4_0)
	if not arg_4_0._toggleWraps[1].toggleWrap.isOn then
		arg_4_0._toggleWraps[1].toggleWrap.isOn = true
	else
		BpController.instance:dispatchEvent(BpEvent.ShowUnlockBonusAnim)
	end
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:_updateLevelScore(true)
end

function var_0_0.onOpenFinish(arg_6_0)
	BpModel.instance.isViewLoading = nil

	BpController.instance:dispatchEvent(BpEvent.OnViewOpenFinish)
end

function var_0_0.onClose(arg_7_0)
	if arg_7_0._addScoreTween then
		ZProj.TweenHelper.KillById(arg_7_0._addScoreTween)

		arg_7_0._addScoreTween = nil
	end
end

function var_0_0.openStoryTips(arg_8_0)
	ViewMgr.instance:openView(ViewName.BpSPInformationView)
end

function var_0_0.openTips(arg_9_0)
	ViewMgr.instance:openView(ViewName.BpSPRuleTipsView)
end

function var_0_0._updateLevelScore(arg_10_0, arg_10_1)
	local var_10_0 = BpConfig.instance:getLevelScore(BpModel.instance.id)
	local var_10_1 = math.floor(BpModel.instance.score / var_10_0)
	local var_10_2 = BpModel.instance.score % var_10_0
	local var_10_3 = BpModel.instance.weeklyScore
	local var_10_4 = BpModel.instance:getWeeklyMaxScore()

	arg_10_0._txtLevel.text = var_10_1
	arg_10_0._txtScore.text = var_10_2 .. "/" .. var_10_0

	if var_10_4 <= var_10_3 then
		arg_10_0._txtWeeklyLimit.text = var_10_3 .. "/" .. var_10_4
	else
		arg_10_0._txtWeeklyLimit.text = "<color=#CAC8C5>" .. var_10_3 .. "/" .. var_10_4
	end

	local var_10_5 = var_10_2 / var_10_0
	local var_10_6 = arg_10_0._sliderScore:GetValue()

	if arg_10_1 then
		arg_10_0:setSliderValue(var_10_5)
	elseif math.abs(var_10_6 - var_10_5) > 0.01 then
		if arg_10_0._addScoreTween then
			ZProj.TweenHelper.KillById(arg_10_0._addScoreTween)

			arg_10_0._addScoreTween = nil
		end

		if var_10_5 < var_10_6 then
			var_10_6 = var_10_6 - 1
		end

		arg_10_0._addScoreTween = ZProj.TweenHelper.DOTweenFloat(var_10_6, var_10_5, BpEnum.AddScoreTime, arg_10_0.setSliderValue, nil, arg_10_0, nil, EaseType.OutQuart)
	end

	local var_10_7 = math.floor(BpModel.instance.score / var_10_0) >= #BpConfig.instance:getBonusCOList(BpModel.instance.id)

	gohelper.setActive(arg_10_0._gomax, var_10_7)
end

function var_0_0._onClickSelectBonus(arg_11_0)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.BpBonusSelectView)
end

function var_0_0.setSliderValue(arg_12_0, arg_12_1)
	if arg_12_1 < 0 then
		arg_12_1 = arg_12_1 + 1
	end

	arg_12_0._sliderScore:SetValue(arg_12_1)

	arg_12_0._sliderImage.fillAmount = arg_12_1
end

return var_0_0
