module("modules.logic.battlepass.view.BpView", package.seeall)

local var_0_0 = class("BpView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "left/#simage_icon")
	arg_1_0._simagesignature = gohelper.findChildSingleImage(arg_1_0.viewGO, "left/desc/#simage_signature")
	arg_1_0._simagerewardbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "right/#simage_rewardbg")
	arg_1_0._txtLevel = gohelper.findChildText(arg_1_0.viewGO, "right/level/#txtLevel")
	arg_1_0._txtScore = gohelper.findChildText(arg_1_0.viewGO, "right/score/#txtScore")
	arg_1_0._goWeeklyLimit = gohelper.findChild(arg_1_0.viewGO, "right/weeklimit")
	arg_1_0._txtWeeklyLimit = gohelper.findChildText(arg_1_0.viewGO, "right/weeklimit/#txtWeeklyLimit")
	arg_1_0._sliderScore = gohelper.findChildSlider(arg_1_0.viewGO, "right/Slider")
	arg_1_0._sliderImage = gohelper.findChildImage(arg_1_0.viewGO, "right/slidervx")
	arg_1_0._sliderAnim = gohelper.findChild(arg_1_0.viewGO, "right/slidervx/ani")
	arg_1_0._sliderBg = gohelper.findChild(arg_1_0.viewGO, "right/Slider/Fill Area/Fill")
	arg_1_0._goToggleGroup = gohelper.findChild(arg_1_0.viewGO, "right/toggleGroup")
	arg_1_0._bonusRedDot = gohelper.findChild(arg_1_0.viewGO, "right/redDot/#go_bonus_reddot")
	arg_1_0._taskRedDot = gohelper.findChild(arg_1_0.viewGO, "right/redDot/#go_task_reddot")
	arg_1_0._btnUpgrade = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#btnUpgrade", AudioEnum.UI.play_ui_role_pieces_open)
	arg_1_0._gomax = gohelper.findChild(arg_1_0.viewGO, "right/#go_max")
	arg_1_0._btnInfo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_info", AudioEnum.UI.UI_role_introduce_open)
	arg_1_0._btnRule = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_rule")
	arg_1_0._btnDetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left/desc/#txt_skinname/#btn_faj", AudioEnum.UI.play_artificial_ui_carddisappear)
	arg_1_0._goexpup = gohelper.findChild(arg_1_0.viewGO, "right/title/#go_expup")
	arg_1_0._btntitleClick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/title/#btn_titleClick")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnUpgrade:AddClickListener(arg_2_0._btnUpgradeOnClick, arg_2_0)
	arg_2_0._btnInfo:AddClickListener(arg_2_0.openStoryTips, arg_2_0)
	arg_2_0._btnRule:AddClickListener(arg_2_0.openTips, arg_2_0)
	arg_2_0._btnDetail:AddClickListener(arg_2_0._btndetailOnClick, arg_2_0)
	arg_2_0:addEventCb(BpController.instance, BpEvent.OnGetInfo, arg_2_0._updateLevelScore, arg_2_0)
	arg_2_0:addEventCb(BpController.instance, BpEvent.OnUpdateScore, arg_2_0._updateLevelScore, arg_2_0)
	arg_2_0:addEventCb(BpController.instance, BpEvent.OnUpdatePayStatus, arg_2_0._updateLevelScore, arg_2_0)
	arg_2_0:addEventCb(BpController.instance, BpEvent.OnBuyLevel, arg_2_0._updateLevelScore, arg_2_0)
	arg_2_0:addEventCb(BpController.instance, BpEvent.ForcePlayBonusAnim, arg_2_0._forcePlayBonusAnim, arg_2_0)
	arg_2_0.viewContainer:registerCallback(ViewEvent.ToSwitchTab, arg_2_0._toSwitchTab, arg_2_0)
	arg_2_0.viewContainer:registerCallback(BpEvent.TaskTabChange, arg_2_0._taskTabChange, arg_2_0)
	arg_2_0._btntitleClick:AddClickListener(arg_2_0._btntitleClickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnUpgrade:RemoveClickListener()
	arg_3_0._btnInfo:RemoveClickListener()
	arg_3_0._btnRule:RemoveClickListener()
	arg_3_0._btnDetail:RemoveClickListener()
	arg_3_0:removeEventCb(BpController.instance, BpEvent.OnGetInfo, arg_3_0._updateLevelScore, arg_3_0)
	arg_3_0:removeEventCb(BpController.instance, BpEvent.OnUpdateScore, arg_3_0._updateLevelScore, arg_3_0)
	arg_3_0:removeEventCb(BpController.instance, BpEvent.OnUpdatePayStatus, arg_3_0._updateLevelScore, arg_3_0)
	arg_3_0:removeEventCb(BpController.instance, BpEvent.OnBuyLevel, arg_3_0._updateLevelScore, arg_3_0)
	arg_3_0:removeEventCb(BpController.instance, BpEvent.ForcePlayBonusAnim, arg_3_0._forcePlayBonusAnim, arg_3_0)
	arg_3_0.viewContainer:unregisterCallback(ViewEvent.ToSwitchTab, arg_3_0._toSwitchTab, arg_3_0)
	arg_3_0.viewContainer:unregisterCallback(BpEvent.TaskTabChange, arg_3_0._taskTabChange, arg_3_0)
	arg_3_0._btntitleClick:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	gohelper.addUIClickAudio(gohelper.findChild(arg_4_0.viewGO, "right/toggleGroup/toggleBonus1"), AudioEnum.UI.UI_vertical_first_tabs_click)
	gohelper.addUIClickAudio(gohelper.findChild(arg_4_0.viewGO, "right/toggleGroup/toggleTask2"), AudioEnum.UI.UI_vertical_first_tabs_click)

	local var_4_0 = BpConfig.instance:getCurSkinId(BpModel.instance.id)
	local var_4_1 = lua_skin.configDict[var_4_0].characterId
	local var_4_2 = lua_character.configDict[var_4_1]

	arg_4_0._simagesignature:LoadImage(ResUrl.getSignature(var_4_2.signature))

	local var_4_3 = BpConfig.instance:getBpCO(BpModel.instance.id)

	if var_4_3 then
		local var_4_4 = gohelper.findChildTextMesh(arg_4_0.viewGO, "left/desc/#txt_skinname")
		local var_4_5 = gohelper.findChildTextMesh(arg_4_0.viewGO, "left/desc/#txt_skinname/#txt_name")
		local var_4_6 = gohelper.findChildTextMesh(arg_4_0.viewGO, "left/desc/#txt_skinname/#txt_name/#txt_enname")

		var_4_4.text = var_4_3.bpSkinDesc
		var_4_5.text = var_4_3.bpSkinNametxt
		var_4_6.text = var_4_3.bpSkinEnNametxt
	end

	if BpModel.instance.firstShow then
		ViewMgr.instance:openView(ViewName.BpVideoView)

		BpModel.instance.firstShow = false

		BpRpc.instance:sendBpMarkFirstShowRequest()
	end

	RedDotController.instance:addRedDot(arg_4_0._taskRedDot, RedDotEnum.DotNode.BattlePassTaskMain)
	RedDotController.instance:addRedDot(arg_4_0._bonusRedDot, RedDotEnum.DotNode.BattlePassBonus)
	arg_4_0:_initToggle()
	gohelper.setActive(arg_4_0._goexpup, BpModel.instance:isShowExpUp())
end

function var_0_0._forcePlayBonusAnim(arg_5_0)
	if not arg_5_0._toggleWraps[1].toggleWrap.isOn then
		arg_5_0._toggleWraps[1].toggleWrap.isOn = true
	else
		BpController.instance:dispatchEvent(BpEvent.ShowUnlockBonusAnim)
	end
end

function var_0_0._initToggle(arg_6_0)
	arg_6_0._toggleWraps = arg_6_0:getUserDataTb_()

	local var_6_0 = arg_6_0._goToggleGroup.transform.childCount

	for iter_6_0 = 1, var_6_0 do
		local var_6_1 = arg_6_0._goToggleGroup.transform:GetChild(iter_6_0 - 1).gameObject

		if var_6_1:GetComponent(gohelper.Type_Toggle) then
			local var_6_2 = {
				toggleWrap = gohelper.onceAddComponent(var_6_1, typeof(SLFramework.UGUI.ToggleWrap)),
				label = gohelper.findChildText(var_6_1, "Label"),
				image = gohelper.findChildImage(var_6_1, "Label/Image"),
				mask = gohelper.findChild(var_6_1, "Background/Checkmark")
			}

			arg_6_0._toggleWraps[iter_6_0] = var_6_2
		end
	end
end

function var_0_0._toSwitchTab(arg_7_0, arg_7_1, arg_7_2)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0._toggleWraps) do
		SLFramework.UGUI.GuiHelper.SetColor(iter_7_1.label, iter_7_0 == arg_7_2 and "#ffffff" or "#888888")
		SLFramework.UGUI.GuiHelper.SetColor(iter_7_1.image, iter_7_0 == arg_7_2 and "#ffffff" or "#888888")
		gohelper.setActive(iter_7_1.mask, iter_7_0 == arg_7_2)
	end

	arg_7_0._tabIndex = arg_7_2

	arg_7_0:_checkLimitShow()
end

function var_0_0._taskTabChange(arg_8_0, arg_8_1)
	arg_8_0._taskIndex = arg_8_1

	arg_8_0:_checkLimitShow()
end

function var_0_0._checkLimitShow(arg_9_0)
	gohelper.setActive(arg_9_0._goWeeklyLimit, arg_9_0._tabIndex ~= 2 or arg_9_0._tabIndex == 2 and arg_9_0._taskIndex ~= 3)
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0._simagebg:UnLoadImage()
	arg_10_0._simageicon:UnLoadImage()
	arg_10_0._simagesignature:UnLoadImage()
	arg_10_0._simagerewardbg:UnLoadImage()
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0:_updateLevelScore(true)

	local var_11_0 = 1

	if arg_11_0.viewParam and arg_11_0.viewParam.defaultTabIds and arg_11_0.viewParam.defaultTabIds[2] then
		var_11_0 = arg_11_0.viewParam.defaultTabIds[2]
	end

	arg_11_0:_toSwitchTab(2, var_11_0)
end

function var_0_0.onOpenFinish(arg_12_0)
	BpModel.instance.isViewLoading = nil

	BpController.instance:dispatchEvent(BpEvent.OnViewOpenFinish)
end

function var_0_0.onClose(arg_13_0)
	if arg_13_0._addScoreTween then
		ZProj.TweenHelper.KillById(arg_13_0._addScoreTween)

		arg_13_0._addScoreTween = nil
	end
end

function var_0_0._btnUpgradeOnClick(arg_14_0)
	local var_14_0 = BpConfig.instance:getLevelScore(BpModel.instance.id)

	if math.floor(BpModel.instance.score / var_14_0) < #BpConfig.instance:getBonusCOList(BpModel.instance.id) then
		ViewMgr.instance:openView(ViewName.BpBuyView)
	end
end

function var_0_0._btndetailOnClick(arg_15_0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.HeroSkin, BpConfig.instance:getCurSkinId(BpModel.instance.id), false, nil, false)
end

function var_0_0.openStoryTips(arg_16_0)
	ViewMgr.instance:openView(ViewName.BpInformationView)
end

function var_0_0.openTips(arg_17_0)
	ViewMgr.instance:openView(ViewName.BpRuleTipsView)
end

function var_0_0._updateLevelScore(arg_18_0, arg_18_1)
	local var_18_0 = BpConfig.instance:getLevelScore(BpModel.instance.id)
	local var_18_1 = math.floor(BpModel.instance.score / var_18_0)
	local var_18_2 = BpModel.instance.score % var_18_0
	local var_18_3 = BpModel.instance.weeklyScore
	local var_18_4 = BpModel.instance:getWeeklyMaxScore()

	arg_18_0._txtLevel.text = var_18_1
	arg_18_0._txtScore.text = var_18_2 .. "/" .. var_18_0

	if var_18_4 <= var_18_3 then
		arg_18_0._txtWeeklyLimit.text = var_18_3 .. "/" .. var_18_4
	else
		arg_18_0._txtWeeklyLimit.text = "<color=#CAC8C5>" .. var_18_3 .. "/" .. var_18_4
	end

	local var_18_5 = var_18_2 / var_18_0
	local var_18_6 = arg_18_0._sliderScore:GetValue()

	if arg_18_1 then
		arg_18_0:setSliderValue(var_18_5)
	elseif math.abs(var_18_6 - var_18_5) > 0.01 then
		if arg_18_0._addScoreTween then
			ZProj.TweenHelper.KillById(arg_18_0._addScoreTween)

			arg_18_0._addScoreTween = nil
		end

		if var_18_5 < var_18_6 then
			var_18_6 = var_18_6 - 1
		end

		arg_18_0._addScoreTween = ZProj.TweenHelper.DOTweenFloat(var_18_6, var_18_5, BpEnum.AddScoreTime, arg_18_0.setSliderValue, nil, arg_18_0, nil, EaseType.OutQuart)
	end

	local var_18_7 = BpModel.instance:isMaxLevel()

	gohelper.setActive(arg_18_0._btnUpgrade.gameObject, not var_18_7)
	gohelper.setActive(arg_18_0._gomax, var_18_7)
end

function var_0_0.setSliderValue(arg_19_0, arg_19_1)
	if arg_19_1 < 0 then
		arg_19_1 = arg_19_1 + 1
	end

	arg_19_0._sliderScore:SetValue(arg_19_1)

	arg_19_0._sliderImage.fillAmount = arg_19_1
end

function var_0_0._btntitleClickOnClick(arg_20_0)
	if BpModel.instance:isShowExpUp() then
		ToastController.instance:showToast(ToastEnum.BpExpUp)
	end
end

return var_0_0
