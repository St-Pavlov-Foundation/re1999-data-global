module("modules.logic.battlepass.view.BpView", package.seeall)

slot0 = class("BpView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "left/#simage_icon")
	slot0._simagesignature = gohelper.findChildSingleImage(slot0.viewGO, "left/desc/#simage_signature")
	slot0._simagerewardbg = gohelper.findChildSingleImage(slot0.viewGO, "right/#simage_rewardbg")
	slot0._txtLevel = gohelper.findChildText(slot0.viewGO, "right/level/#txtLevel")
	slot0._txtScore = gohelper.findChildText(slot0.viewGO, "right/score/#txtScore")
	slot0._goWeeklyLimit = gohelper.findChild(slot0.viewGO, "right/weeklimit")
	slot0._txtWeeklyLimit = gohelper.findChildText(slot0.viewGO, "right/weeklimit/#txtWeeklyLimit")
	slot0._sliderScore = gohelper.findChildSlider(slot0.viewGO, "right/Slider")
	slot0._sliderImage = gohelper.findChildImage(slot0.viewGO, "right/slidervx")
	slot0._sliderAnim = gohelper.findChild(slot0.viewGO, "right/slidervx/ani")
	slot0._sliderBg = gohelper.findChild(slot0.viewGO, "right/Slider/Fill Area/Fill")
	slot0._goToggleGroup = gohelper.findChild(slot0.viewGO, "right/toggleGroup")
	slot0._bonusRedDot = gohelper.findChild(slot0.viewGO, "right/redDot/#go_bonus_reddot")
	slot0._taskRedDot = gohelper.findChild(slot0.viewGO, "right/redDot/#go_task_reddot")
	slot0._btnUpgrade = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#btnUpgrade", AudioEnum.UI.play_ui_role_pieces_open)
	slot0._gomax = gohelper.findChild(slot0.viewGO, "right/#go_max")
	slot0._btnInfo = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_info", AudioEnum.UI.UI_role_introduce_open)
	slot0._btnRule = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_rule")
	slot0._btnDetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "left/desc/#txt_skinname/#btn_faj", AudioEnum.UI.play_artificial_ui_carddisappear)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnUpgrade:AddClickListener(slot0._btnUpgradeOnClick, slot0)
	slot0._btnInfo:AddClickListener(slot0.openStoryTips, slot0)
	slot0._btnRule:AddClickListener(slot0.openTips, slot0)
	slot0._btnDetail:AddClickListener(slot0._btndetailOnClick, slot0)
	slot0:addEventCb(BpController.instance, BpEvent.OnGetInfo, slot0._updateLevelScore, slot0)
	slot0:addEventCb(BpController.instance, BpEvent.OnUpdateScore, slot0._updateLevelScore, slot0)
	slot0:addEventCb(BpController.instance, BpEvent.OnUpdatePayStatus, slot0._updateLevelScore, slot0)
	slot0:addEventCb(BpController.instance, BpEvent.OnBuyLevel, slot0._updateLevelScore, slot0)
	slot0:addEventCb(BpController.instance, BpEvent.ForcePlayBonusAnim, slot0._forcePlayBonusAnim, slot0)
	slot0.viewContainer:registerCallback(ViewEvent.ToSwitchTab, slot0._toSwitchTab, slot0)
	slot0.viewContainer:registerCallback(BpEvent.TaskTabChange, slot0._taskTabChange, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnUpgrade:RemoveClickListener()
	slot0._btnInfo:RemoveClickListener()
	slot0._btnRule:RemoveClickListener()
	slot0._btnDetail:RemoveClickListener()
	slot0:removeEventCb(BpController.instance, BpEvent.OnGetInfo, slot0._updateLevelScore, slot0)
	slot0:removeEventCb(BpController.instance, BpEvent.OnUpdateScore, slot0._updateLevelScore, slot0)
	slot0:removeEventCb(BpController.instance, BpEvent.OnUpdatePayStatus, slot0._updateLevelScore, slot0)
	slot0:removeEventCb(BpController.instance, BpEvent.OnBuyLevel, slot0._updateLevelScore, slot0)
	slot0:removeEventCb(BpController.instance, BpEvent.ForcePlayBonusAnim, slot0._forcePlayBonusAnim, slot0)
	slot0.viewContainer:unregisterCallback(ViewEvent.ToSwitchTab, slot0._toSwitchTab, slot0)
	slot0.viewContainer:unregisterCallback(BpEvent.TaskTabChange, slot0._taskTabChange, slot0)
end

function slot0._editableInitView(slot0)
	gohelper.addUIClickAudio(gohelper.findChild(slot0.viewGO, "right/toggleGroup/toggleBonus1"), AudioEnum.UI.UI_vertical_first_tabs_click)
	gohelper.addUIClickAudio(gohelper.findChild(slot0.viewGO, "right/toggleGroup/toggleTask2"), AudioEnum.UI.UI_vertical_first_tabs_click)
	slot0._simagesignature:LoadImage(ResUrl.getSignature(lua_character.configDict[lua_skin.configDict[BpConfig.instance:getCurSkinId(BpModel.instance.id)].characterId].signature))

	if BpConfig.instance:getBpCO(BpModel.instance.id) then
		gohelper.findChildTextMesh(slot0.viewGO, "left/desc/#txt_skinname").text = slot4.bpSkinDesc
		gohelper.findChildTextMesh(slot0.viewGO, "left/desc/#txt_skinname/#txt_name").text = slot4.bpSkinNametxt
		gohelper.findChildTextMesh(slot0.viewGO, "left/desc/#txt_skinname/#txt_name/#txt_enname").text = slot4.bpSkinEnNametxt
	end

	if BpModel.instance.firstShow then
		ViewMgr.instance:openView(ViewName.BpVideoView)

		BpModel.instance.firstShow = false

		BpRpc.instance:sendBpMarkFirstShowRequest()
	end

	RedDotController.instance:addRedDot(slot0._taskRedDot, RedDotEnum.DotNode.BattlePassTaskMain)
	RedDotController.instance:addRedDot(slot0._bonusRedDot, RedDotEnum.DotNode.BattlePassBonus)
	slot0:_initToggle()
end

function slot0._forcePlayBonusAnim(slot0)
	if not slot0._toggleWraps[1].toggleWrap.isOn then
		slot0._toggleWraps[1].toggleWrap.isOn = true
	else
		BpController.instance:dispatchEvent(BpEvent.ShowUnlockBonusAnim)
	end
end

function slot0._initToggle(slot0)
	slot0._toggleWraps = slot0:getUserDataTb_()

	for slot5 = 1, slot0._goToggleGroup.transform.childCount do
		if slot0._goToggleGroup.transform:GetChild(slot5 - 1).gameObject:GetComponent(gohelper.Type_Toggle) then
			slot0._toggleWraps[slot5] = {
				toggleWrap = gohelper.onceAddComponent(slot6, typeof(SLFramework.UGUI.ToggleWrap)),
				label = gohelper.findChildText(slot6, "Label"),
				image = gohelper.findChildImage(slot6, "Label/Image"),
				mask = gohelper.findChild(slot6, "Background/Checkmark")
			}
		end
	end
end

function slot0._toSwitchTab(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot0._toggleWraps) do
		SLFramework.UGUI.GuiHelper.SetColor(slot7.label, slot6 == slot2 and "#ffffff" or "#888888")
		SLFramework.UGUI.GuiHelper.SetColor(slot7.image, slot6 == slot2 and "#ffffff" or "#888888")
		gohelper.setActive(slot7.mask, slot6 == slot2)
	end

	slot0._tabIndex = slot2

	slot0:_checkLimitShow()
end

function slot0._taskTabChange(slot0, slot1)
	slot0._taskIndex = slot1

	slot0:_checkLimitShow()
end

function slot0._checkLimitShow(slot0)
	gohelper.setActive(slot0._goWeeklyLimit, slot0._tabIndex ~= 2 or slot0._tabIndex == 2 and slot0._taskIndex ~= 3)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simageicon:UnLoadImage()
	slot0._simagesignature:UnLoadImage()
	slot0._simagerewardbg:UnLoadImage()
end

function slot0.onOpen(slot0)
	slot0:_updateLevelScore(true)

	slot1 = 1

	if slot0.viewParam and slot0.viewParam.defaultTabIds and slot0.viewParam.defaultTabIds[2] then
		slot1 = slot0.viewParam.defaultTabIds[2]
	end

	slot0:_toSwitchTab(2, slot1)
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

function slot0._btnUpgradeOnClick(slot0)
	if math.floor(BpModel.instance.score / BpConfig.instance:getLevelScore(BpModel.instance.id)) < #BpConfig.instance:getBonusCOList(BpModel.instance.id) then
		ViewMgr.instance:openView(ViewName.BpBuyView)
	end
end

function slot0._btndetailOnClick(slot0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.HeroSkin, BpConfig.instance:getCurSkinId(BpModel.instance.id), false, nil, false)
end

function slot0.openStoryTips(slot0)
	ViewMgr.instance:openView(ViewName.BpInformationView)
end

function slot0.openTips(slot0)
	ViewMgr.instance:openView(ViewName.BpRuleTipsView)
end

function slot0._updateLevelScore(slot0, slot1)
	slot2 = BpConfig.instance:getLevelScore(BpModel.instance.id)
	slot0._txtLevel.text = math.floor(BpModel.instance.score / slot2)
	slot0._txtScore.text = BpModel.instance.score % slot2 .. "/" .. slot2

	if CommonConfig.instance:getConstNum(ConstEnum.BpWeeklyMaxScore) <= BpModel.instance.weeklyScore then
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

	slot11 = math.floor(BpModel.instance.score / slot2) >= #BpConfig.instance:getBonusCOList(BpModel.instance.id)

	gohelper.setActive(slot0._btnUpgrade.gameObject, not slot11)
	gohelper.setActive(slot0._gomax, slot11)
end

function slot0.setSliderValue(slot0, slot1)
	if slot1 < 0 then
		slot1 = slot1 + 1
	end

	slot0._sliderScore:SetValue(slot1)

	slot0._sliderImage.fillAmount = slot1
end

return slot0
