module("modules.logic.battlepass.view.BpSPView", package.seeall)

slot0 = class("BpSPView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnSelectBonus = gohelper.findChildButtonWithAudio(slot0.viewGO, "left/#btn_faj")
	slot0._txtLevel = gohelper.findChildText(slot0.viewGO, "right/level/#txtLevel")
	slot0._txtScore = gohelper.findChildText(slot0.viewGO, "right/score/#txtScore")
	slot0._goWeeklyLimit = gohelper.findChild(slot0.viewGO, "right/weeklimit")
	slot0._txtWeeklyLimit = gohelper.findChildText(slot0.viewGO, "right/weeklimit/#txtWeeklyLimit")
	slot0._sliderScore = gohelper.findChildSlider(slot0.viewGO, "right/Slider")
	slot0._sliderImage = gohelper.findChildImage(slot0.viewGO, "right/slidervx")
	slot0._sliderAnim = gohelper.findChild(slot0.viewGO, "right/slidervx/ani")
	slot0._sliderBg = gohelper.findChild(slot0.viewGO, "right/Slider/Fill Area/Fill")
	slot0._gomax = gohelper.findChild(slot0.viewGO, "right/#go_max")
	slot0._btnInfo = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_info", AudioEnum.UI.UI_role_introduce_open)
	slot0._btnRule = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_rule")
end

function slot0.addEvents(slot0)
	slot0._btnSelectBonus:AddClickListener(slot0._onClickSelectBonus, slot0)
	slot0._btnInfo:AddClickListener(slot0.openStoryTips, slot0)
	slot0._btnRule:AddClickListener(slot0.openTips, slot0)
	slot0:addEventCb(BpController.instance, BpEvent.OnGetInfo, slot0._updateLevelScore, slot0)
	slot0:addEventCb(BpController.instance, BpEvent.OnUpdateScore, slot0._updateLevelScore, slot0)
	slot0:addEventCb(BpController.instance, BpEvent.OnUpdatePayStatus, slot0._updateLevelScore, slot0)
	slot0:addEventCb(BpController.instance, BpEvent.OnBuyLevel, slot0._updateLevelScore, slot0)
	slot0:addEventCb(BpController.instance, BpEvent.ForcePlayBonusAnim, slot0._forcePlayBonusAnim, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnSelectBonus:RemoveClickListener()
	slot0._btnInfo:RemoveClickListener()
	slot0._btnRule:RemoveClickListener()
	slot0:removeEventCb(BpController.instance, BpEvent.OnGetInfo, slot0._updateLevelScore, slot0)
	slot0:removeEventCb(BpController.instance, BpEvent.OnUpdateScore, slot0._updateLevelScore, slot0)
	slot0:removeEventCb(BpController.instance, BpEvent.OnUpdatePayStatus, slot0._updateLevelScore, slot0)
	slot0:removeEventCb(BpController.instance, BpEvent.OnBuyLevel, slot0._updateLevelScore, slot0)
	slot0:removeEventCb(BpController.instance, BpEvent.ForcePlayBonusAnim, slot0._forcePlayBonusAnim, slot0)
end

function slot0._forcePlayBonusAnim(slot0)
	if not slot0._toggleWraps[1].toggleWrap.isOn then
		slot0._toggleWraps[1].toggleWrap.isOn = true
	else
		BpController.instance:dispatchEvent(BpEvent.ShowUnlockBonusAnim)
	end
end

function slot0.onOpen(slot0)
	slot0:_updateLevelScore(true)
end

function slot0.onOpenFinish(slot0)
	BpModel.instance.isViewLoading = nil

	BpController.instance:dispatchEvent(BpEvent.OnViewOpenFinish)
end

function slot0.onClose(slot0)
	if slot0._addScoreTween then
		ZProj.TweenHelper.KillById(slot0._addScoreTween)

		slot0._addScoreTween = nil
	end
end

function slot0.openStoryTips(slot0)
	ViewMgr.instance:openView(ViewName.BpSPInformationView)
end

function slot0.openTips(slot0)
	ViewMgr.instance:openView(ViewName.BpSPRuleTipsView)
end

function slot0._updateLevelScore(slot0, slot1)
	slot2 = BpConfig.instance:getLevelScore(BpModel.instance.id)
	slot0._txtLevel.text = math.floor(BpModel.instance.score / slot2)
	slot0._txtScore.text = BpModel.instance.score % slot2 .. "/" .. slot2

	if BpModel.instance:getWeeklyMaxScore() <= BpModel.instance.weeklyScore then
		slot0._txtWeeklyLimit.text = slot5 .. "/" .. slot6
	else
		slot0._txtWeeklyLimit.text = "<color=#CAC8C5>" .. slot5 .. "/" .. slot6
	end

	slot8 = slot0._sliderScore:GetValue()

	if slot1 then
		slot0:setSliderValue(slot4 / slot2)
	elseif math.abs(slot8 - slot7) > 0.01 then
		if slot0._addScoreTween then
			ZProj.TweenHelper.KillById(slot0._addScoreTween)

			slot0._addScoreTween = nil
		end

		if slot7 < slot8 then
			slot8 = slot8 - 1
		end

		slot0._addScoreTween = ZProj.TweenHelper.DOTweenFloat(slot8, slot7, BpEnum.AddScoreTime, slot0.setSliderValue, nil, slot0, nil, EaseType.OutQuart)
	end

	gohelper.setActive(slot0._gomax, math.floor(BpModel.instance.score / slot2) >= #BpConfig.instance:getBonusCOList(BpModel.instance.id))
end

function slot0._onClickSelectBonus(slot0)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.BpBonusSelectView)
end

function slot0.setSliderValue(slot0, slot1)
	if slot1 < 0 then
		slot1 = slot1 + 1
	end

	slot0._sliderScore:SetValue(slot1)

	slot0._sliderImage.fillAmount = slot1
end

return slot0
