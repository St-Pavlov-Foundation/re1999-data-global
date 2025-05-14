module("modules.logic.bossrush.view.V1a4_BossRushLevelDetail", package.seeall)

local var_0_0 = class("V1a4_BossRushLevelDetail", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefull = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_full")
	arg_1_0._gospines = gohelper.findChild(arg_1_0.viewGO, "#go_spines")
	arg_1_0._goLeftBGEndless = gohelper.findChild(arg_1_0.viewGO, "#go_LeftBGEndless")
	arg_1_0._goLeftBG = gohelper.findChild(arg_1_0.viewGO, "#go_LeftBG")
	arg_1_0._goRightBGEndless = gohelper.findChild(arg_1_0.viewGO, "#go_RightBGEndless")
	arg_1_0._goRightBGLayer4 = gohelper.findChild(arg_1_0.viewGO, "#go_RightBGLayer4")
	arg_1_0._goRightBG = gohelper.findChild(arg_1_0.viewGO, "#go_RightBG")
	arg_1_0._btnSimple = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_Simple", AudioEnum.ui_activity.play_ui_activity_switch)
	arg_1_0._btnHard = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_Hard", AudioEnum.ui_activity.play_ui_activity_switch)
	arg_1_0._btnEndless = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_Endless", AudioEnum.ui_activity.play_ui_activity_switch)
	arg_1_0._btnLayer4 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_Layer4", AudioEnum.ui_activity.play_ui_activity_switch)
	arg_1_0._btnbonus = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_bonus", AudioEnum.ui_task.play_ui_task_page)
	arg_1_0._imageSliderFG = gohelper.findChildImage(arg_1_0.viewGO, "Left/#btn_bonus/image_SliderBG/#image_SliderFG")
	arg_1_0._goAssessIcon = gohelper.findChild(arg_1_0.viewGO, "Left/#btn_bonus/#go_AssessIcon")
	arg_1_0._goRedPoint1 = gohelper.findChild(arg_1_0.viewGO, "Left/#btn_bonus/#go_RedPoint1")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "DetailPanel/Title/#txt_Title")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "DetailPanel/Title/#txt_Title/#simage_Title")
	arg_1_0._imageIssxIcon = gohelper.findChildImage(arg_1_0.viewGO, "DetailPanel/Title/#txt_Title/#image_IssxIcon")
	arg_1_0._btnSearchIcon = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "DetailPanel/Title/#txt_Title/#btn_SearchIcon")
	arg_1_0._scrollDescr = gohelper.findChildScrollRect(arg_1_0.viewGO, "DetailPanel/#scroll_desc")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "DetailPanel/#scroll_desc/Viewport/#txt_Descr")
	arg_1_0._txtScoreTotalNum = gohelper.findChildText(arg_1_0.viewGO, "DetailPanel/Attention/Score/#txt_ScoreTotalNum")
	arg_1_0._txtLvNum = gohelper.findChildText(arg_1_0.viewGO, "DetailPanel/Attention/Lv/#txt_LvNum")
	arg_1_0._btnGo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "DetailPanel/#btn_Go", AudioEnum.ui_action.play_ui_action_mainstart)
	arg_1_0._txtDoubleTimes = gohelper.findChildText(arg_1_0.viewGO, "DetailPanel/#btn_Go/#txt_DoubleTimes")
	arg_1_0._gonormalbtn = gohelper.findChildImage(arg_1_0.viewGO, "DetailPanel/#btn_Go/#img_normal")
	arg_1_0._txtGoCn = gohelper.findChildText(arg_1_0.viewGO, "DetailPanel/#btn_Go/#img_normal/txt_Go")
	arg_1_0._txtGoEn = gohelper.findChildText(arg_1_0.viewGO, "DetailPanel/#btn_Go/#img_normal/txt_GoEn")
	arg_1_0._btnoffer = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "DetailPanel/#btn_Offer")
	arg_1_0._vxreceive1 = gohelper.findChild(arg_1_0.viewGO, "Left/vx_receive")
	arg_1_0._imageSliderFG2 = gohelper.findChildImage(arg_1_0.viewGO, "Left/#btn_bonus/image_SliderBG/#image_SliderFG/vx_receive_eff")
	arg_1_0._gomask = gohelper.findChild(arg_1_0.viewGO, "mask")
	arg_1_0._animEvent = arg_1_0.viewGO:GetComponent(gohelper.Type_AnimationEventWrap)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnSimple:AddClickListener(arg_2_0._btnSimpleOnClick, arg_2_0)
	arg_2_0._btnHard:AddClickListener(arg_2_0._btnHardOnClick, arg_2_0)
	arg_2_0._btnEndless:AddClickListener(arg_2_0._btnEndlessOnClick, arg_2_0)
	arg_2_0._btnLayer4:AddClickListener(arg_2_0._btnLayer4OnClick, arg_2_0)
	arg_2_0._btnbonus:AddClickListener(arg_2_0._btnbonusOnClick, arg_2_0)
	arg_2_0._btnSearchIcon:AddClickListener(arg_2_0._btnSearchIconOnClick, arg_2_0)
	arg_2_0._btnGo:AddClickListener(arg_2_0._btnGoOnClick, arg_2_0)
	arg_2_0._btnoffer:AddClickListener(arg_2_0._btnOfferOnClick, arg_2_0)
	arg_2_0._animEvent:AddEventListener(BossRushEnum.AnimEvtAchievementItem.onBtnGoEnter, arg_2_0._onBtnGoEnter, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnSimple:RemoveClickListener()
	arg_3_0._btnHard:RemoveClickListener()
	arg_3_0._btnEndless:RemoveClickListener()
	arg_3_0._btnLayer4:RemoveClickListener()
	arg_3_0._btnbonus:RemoveClickListener()
	arg_3_0._btnSearchIcon:RemoveClickListener()
	arg_3_0._btnGo:RemoveClickListener()
	arg_3_0._btnoffer:RemoveClickListener()
	arg_3_0._animEvent:AddEventListener(BossRushEnum.AnimEvtAchievementItem.onBtnGoEnter, arg_3_0._onBtnGoEnter, arg_3_0)
end

function var_0_0._btnbonusOnClick(arg_4_0)
	ViewMgr.instance:openView(ViewName.V1a6_BossRush_BonusView, arg_4_0.viewParam)
end

function var_0_0._btnOfferOnClick(arg_5_0)
	BossRushController.instance:openBossRushOfferRoleView()
end

local var_0_1 = {
	Layer4 = 4,
	Simple = 1,
	Endless = 3,
	Hard = 2
}
local var_0_2 = BossRushEnum.AnimEvtLevelDetail
local var_0_3 = RedDotEnum.DotNode
local var_0_4 = BossRushEnum.AnimLevelDetailBtn

function var_0_0._btnSearchIconOnClick(arg_6_0)
	local var_6_0, var_6_1 = arg_6_0:_getStageAndLayer()
	local var_6_2 = BossRushConfig.instance:getActivityId()

	EnemyInfoController.instance:openBossRushEnemyInfoView(var_6_2, var_6_0, var_6_1)
end

function var_0_0._btnSimpleOnClick(arg_7_0)
	arg_7_0:_setSelect(var_0_1.Simple, true)
end

function var_0_0._btnHardOnClick(arg_8_0)
	arg_8_0:_setSelect(var_0_1.Hard, true)
end

function var_0_0._btnEndlessOnClick(arg_9_0)
	arg_9_0:_setSelect(var_0_1.Endless, true)
end

function var_0_0._btnLayer4OnClick(arg_10_0)
	arg_10_0:_setSelect(var_0_1.Layer4, true)
end

function var_0_0._btnScheduleOnClick(arg_11_0)
	ViewMgr.instance:openView(ViewName.V1a4_BossRush_ScheduleView, arg_11_0.viewParam)
end

function var_0_0._btnScoreOnClick(arg_12_0)
	ViewMgr.instance:openView(ViewName.V1a4_BossRush_ScoreTaskAchievement, arg_12_0.viewParam)
end

function var_0_0._btnGoOnClick(arg_13_0)
	local var_13_0, var_13_1 = arg_13_0:_getStageAndLayer()

	BossRushController.instance:enterFightScene(var_13_0, var_13_1)
end

function var_0_0._btnBonusOnClick(arg_14_0)
	ViewMgr.instance:openView(ViewName.V1a6_BossRush_BonusView, arg_14_0.viewParam)
end

function var_0_0._editableInitView(arg_15_0)
	local var_15_0 = V1a4_BossRushLevelDetailItem

	arg_15_0._tabList = {
		MonoHelper.addNoUpdateLuaComOnceToGo(arg_15_0._btnSimple.gameObject, var_15_0),
		MonoHelper.addNoUpdateLuaComOnceToGo(arg_15_0._btnHard.gameObject, var_15_0),
		MonoHelper.addNoUpdateLuaComOnceToGo(arg_15_0._btnEndless.gameObject, var_15_0),
		(MonoHelper.addNoUpdateLuaComOnceToGo(arg_15_0._btnLayer4.gameObject, var_15_0))
	}

	arg_15_0:_initAssessIcon()

	arg_15_0._animSelf = arg_15_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_15_0._animEvent = arg_15_0.viewGO:GetComponent(gohelper.Type_AnimationEventWrap)
	arg_15_0._animSelf.enabled = false
	arg_15_0._txtDoubleTimes.text = ""
	arg_15_0._txtTitle.text = ""
	arg_15_0._txtLvNum.text = ""

	arg_15_0._animEvent:AddEventListener(var_0_2.onPlayCloseTransitionFinish, arg_15_0._onPlayCloseTransitionFinish, arg_15_0)
end

function var_0_0._initAssessIcon(arg_16_0)
	local var_16_0 = V1a4_BossRush_AssessIcon
	local var_16_1 = arg_16_0.viewContainer:getResInst(BossRushEnum.ResPath.v1a4_bossrush_leveldetail_assessicon, arg_16_0._goAssessIcon, var_16_0.__cname)

	arg_16_0._assessIcon = MonoHelper.addNoUpdateLuaComOnceToGo(var_16_1, var_16_0)

	arg_16_0._assessIcon:initData(arg_16_0, false)
end

function var_0_0.onUpdateParam(arg_17_0)
	return
end

function var_0_0._tryLayer2TabIndex(arg_18_0, arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0._stageLayerInfos) do
		if iter_18_1.layer == arg_18_1 then
			local var_18_0 = arg_18_0:_getStage()

			return BossRushModel.instance:isBossLayerOpen(var_18_0, arg_18_1) and iter_18_0 or 1
		end
	end
end

function var_0_0._getTabUnlockStates(arg_19_0)
	local var_19_0 = arg_19_0:_getStage()
	local var_19_1 = {}

	for iter_19_0, iter_19_1 in ipairs(arg_19_0._stageLayerInfos) do
		local var_19_2 = iter_19_1.layer

		var_19_1[iter_19_0] = BossRushRedModel.instance:getIsNewUnlockStageLayer(var_19_0, var_19_2)
	end

	return var_19_1
end

function var_0_0._tweenUnlockTabs(arg_20_0)
	local var_20_0 = arg_20_0:_getStage()
	local var_20_1 = arg_20_0:_getTabUnlockStates()

	arg_20_0:_refreshTabs(var_20_1)

	for iter_20_0, iter_20_1 in ipairs(var_20_1) do
		if iter_20_1 then
			local var_20_2 = arg_20_0._tabList[iter_20_0]
			local var_20_3 = arg_20_0._stageLayerInfos[iter_20_0].layer

			var_20_2:playUnlock()
			BossRushRedModel.instance:setIsNewUnlockStageLayer(var_20_0, var_20_3, false)
		end
	end
end

function var_0_0.onOpen(arg_21_0)
	arg_21_0._selectedIndex = nil

	local var_21_0 = arg_21_0.viewParam
	local var_21_1 = var_21_0.stage
	local var_21_2 = var_21_0.selectedIndex
	local var_21_3 = BossRushModel.instance:getStagePointInfo(var_21_1)

	arg_21_0._stageLayerInfos = BossRushModel.instance:getStageLayersInfo(var_21_1)

	if not var_21_2 then
		var_21_2 = arg_21_0:_tryLayer2TabIndex(BossRushModel.instance:getLastMarkSelectedLayer(var_21_1))
		var_21_0.selectedIndex = var_21_2
	end

	arg_21_0:_tweenUnlockTabs()
	arg_21_0:_setSelect(arg_21_0.viewParam.selectedIndex or var_0_1.Simple)
	arg_21_0:_refreshMonster()
	arg_21_0:_refreshRedDot()

	local var_21_4 = var_21_3.cur / var_21_3.max

	arg_21_0._imageSliderFG.fillAmount = var_21_4
	arg_21_0._imageSliderFG2.fillAmount = var_21_4
	arg_21_0._animSelf.enabled = true

	if var_21_2 == var_0_1.Endless then
		AudioMgr.instance:trigger(AudioEnum.ui_activity.play_ui_pkls_challenge_fail_bossrush)
		arg_21_0._animSelf:Play(BossRushEnum.AnimLevelDetail.EndlessEnter)
	elseif var_21_2 == var_0_1.Hard then
		arg_21_0._animSelf:Play(BossRushEnum.AnimLevelDetail.HardEnter)
	elseif var_21_2 == var_0_1.Simple then
		arg_21_0._animSelf:Play(BossRushEnum.AnimLevelDetail.NormalEnter)
	elseif var_21_2 == var_0_1.Layer4 then
		arg_21_0._animSelf:Play(BossRushEnum.AnimLevelDetail.Layer4)
	end

	arg_21_0:_refreshGoBtn(var_21_2)
	gohelper.setActive(arg_21_0._gomask, false)
	arg_21_0:_checkOfferBtn()
end

function var_0_0.onOpenFinish(arg_22_0)
	return
end

function var_0_0.playCloseTransition(arg_23_0)
	arg_23_0._animSelf:Play(BossRushEnum.AnimLevelDetail.CloseView)
	gohelper.setActive(arg_23_0._gomask, true)
end

function var_0_0._onPlayCloseTransitionFinish(arg_24_0)
	arg_24_0.viewContainer:onPlayCloseTransitionFinish()
end

function var_0_0.onClose(arg_25_0)
	local var_25_0 = arg_25_0.viewParam

	if var_25_0 then
		var_25_0.selectedIndex = nil
	end
end

function var_0_0.onDestroyView(arg_26_0)
	arg_26_0._animEvent:RemoveEventListener(var_0_2.onPlayCloseTransitionFinish)
	arg_26_0._simagefull:UnLoadImage()
	GameUtil.onDestroyViewMemberList(arg_26_0, "_tabList")
	GameUtil.onDestroyViewMemberList(arg_26_0, "_uiSpineList")
end

function var_0_0._refreshContent(arg_27_0)
	local var_27_0 = arg_27_0.viewParam
	local var_27_1 = var_27_0.stage
	local var_27_2 = var_27_0.stageCO
	local var_27_3 = arg_27_0._selectedIndex
	local var_27_4 = arg_27_0._stageLayerInfos[var_27_3].layerCO
	local var_27_5 = var_27_4.layer
	local var_27_6 = BossRushConfig.instance:getBattleMaxPoints(var_27_1, var_27_5)
	local var_27_7 = BossRushConfig.instance:getIssxIconName(var_27_1, var_27_5)
	local var_27_8 = BossRushModel.instance:getHighestPoint(var_27_1)
	local var_27_9 = BossRushConfig.instance:isInfinite(var_27_1, var_27_5)
	local var_27_10 = BossRushConfig.instance:getDungeonBattleId(var_27_1, var_27_5)

	UISpriteSetMgr.instance:setCommonSprite(arg_27_0._imageIssxIcon, var_27_7)
	arg_27_0._simagefull:LoadImage(BossRushConfig.instance:getBossRushLevelDetailFullBgSimage(var_27_1))

	local var_27_11 = BossRushModel.instance:getLayer4HightScore(var_27_1) == var_27_8

	arg_27_0._assessIcon:setData(var_27_1, var_27_8, var_27_11)

	local var_27_12 = BossRushConfig.instance:getAssessSpriteName(var_27_1, var_27_8, var_27_11)
	local var_27_13 = string.nilorempty(var_27_12)

	gohelper.setActive(arg_27_0._vxreceive1, not var_27_13)

	arg_27_0._txtTitle.text = ""

	if arg_27_0._scrollDescr then
		arg_27_0._scrollDescr.verticalNormalizedPosition = 1
	end

	arg_27_0._txtDescr.text = var_27_4.desc

	ZProj.UGUIHelper.RebuildLayout(arg_27_0._txtDescr.transform)

	arg_27_0._txtLvNum.text = var_27_4.recommendLevelDesc

	arg_27_0._simageTitle:LoadImage(BossRushConfig.instance:getResultViewNameSImage(var_27_1))

	arg_27_0._txtScoreTotalNum.text = var_27_6 == 0 and luaLang("v1a4_bossrushleveldetail_txt_scoretotalnum") or var_27_6

	if var_27_9 then
		local var_27_14 = BossRushModel.instance:getDoubleTimesInfo(var_27_1)
		local var_27_15 = {
			var_27_14.cur,
			var_27_14.max
		}

		arg_27_0._txtDoubleTimes.text = GameUtil.getSubPlaceholderLuaLang(luaLang("v1a4_bossrushleveldetail_txt_doubletimes"), var_27_15)
	else
		arg_27_0._txtDoubleTimes.text = ""
	end

	local var_27_16 = BossRushModel.instance:isSpecialLayer(var_27_5)

	gohelper.setActive(arg_27_0._goLeftBGEndless, not var_27_16 and var_27_9)
	gohelper.setActive(arg_27_0._goLeftBG, not var_27_16 and not var_27_9)
	gohelper.setActive(arg_27_0._goRightBGEndless, not var_27_16 and var_27_9)
	gohelper.setActive(arg_27_0._goRightBG, not var_27_16 and not var_27_9)
	gohelper.setActive(arg_27_0._goRightBGLayer4, var_27_16)
	arg_27_0:_doUpdateSelectIcon(var_27_10)
end

function var_0_0._refreshTabs(arg_28_0, arg_28_1)
	for iter_28_0, iter_28_1 in ipairs(arg_28_0._tabList) do
		iter_28_1:setSelect(false)

		local var_28_0 = arg_28_0._stageLayerInfos[iter_28_0]

		if var_28_0 then
			iter_28_1:setData(iter_28_0, var_28_0)

			if arg_28_1 and arg_28_1[iter_28_0] then
				iter_28_1:setIsLocked(true)
			end
		else
			gohelper.setActive(iter_28_1.go, false)
		end
	end
end

function var_0_0._setSelect(arg_29_0, arg_29_1, arg_29_2)
	if arg_29_0._selectedIndex == arg_29_1 then
		return
	end

	local var_29_0 = arg_29_0._selectedIndex

	if not arg_29_0:_isOpen(arg_29_1) then
		GameFacade.showToast(ToastEnum.V1a4_BossRushLayerLockTip)

		return
	end

	if arg_29_2 then
		if arg_29_1 == var_0_1.Endless then
			AudioMgr.instance:trigger(AudioEnum.ui_activity.play_ui_pkls_challenge_fail_bossrush)
			arg_29_0._animSelf:Play(BossRushEnum.AnimLevelDetail.SwitchToEndless)
		elseif arg_29_1 == var_0_1.Hard then
			arg_29_0._animSelf:Play(BossRushEnum.AnimLevelDetail.SwitchToHard)
		elseif arg_29_1 == var_0_1.Simple then
			arg_29_0._animSelf:Play(BossRushEnum.AnimLevelDetail.SwitchToNormal)
		elseif arg_29_1 == var_0_1.Layer4 then
			arg_29_0._animSelf:Play(BossRushEnum.AnimLevelDetail.SwitchToLayer4)
		end
	end

	if var_29_0 then
		local var_29_1 = arg_29_0._tabList[var_29_0]

		var_29_1:setSelect(false)
		var_29_1:playIdle()
	end

	local var_29_2 = arg_29_0._tabList[arg_29_1]

	var_29_2:setSelect(true)

	arg_29_0._selectedIndex = arg_29_1

	if arg_29_2 then
		var_29_2:plaAnim(var_0_4.Select, 0, 0)
	else
		arg_29_0:_checkOfferBtn()
	end

	arg_29_0:_refreshContent()

	local var_29_3, var_29_4 = arg_29_0:_getStageAndLayer()

	BossRushModel.instance:setLastMarkSelectedLayer(var_29_3, var_29_4)
end

function var_0_0._refreshMonster(arg_30_0)
	local var_30_0 = arg_30_0:_getStage()
	local var_30_1 = BossRushConfig.instance:getMonsterSkinIdList(var_30_0)
	local var_30_2 = BossRushConfig.instance:getMonsterSkinScaleList(var_30_0)
	local var_30_3 = BossRushConfig.instance:getMonsterSkinOffsetXYs(var_30_0)

	arg_30_0:_initMonsterSpines(#var_30_1)

	for iter_30_0, iter_30_1 in ipairs(arg_30_0._uiSpineList) do
		local var_30_4 = var_30_1[iter_30_0]
		local var_30_5 = var_30_2[iter_30_0]
		local var_30_6 = var_30_3[iter_30_0]

		iter_30_1:setData(var_30_4)
		iter_30_1:setScale(var_30_5)
		iter_30_1:setOffsetXY(var_30_6[1], var_30_6[2])
	end
end

function var_0_0._initMonsterSpines(arg_31_0, arg_31_1)
	local var_31_0 = V1a4_BossRushLevelDetail_Spine

	if not arg_31_0._uiSpineList or arg_31_1 > #arg_31_0._uiSpineList then
		arg_31_0._uiSpineList = arg_31_0._uiSpineList or {}

		for iter_31_0 = #arg_31_0._uiSpineList + 1, arg_31_1 do
			local var_31_1 = arg_31_0.viewContainer:getResInst(BossRushEnum.ResPath.v1a4_bossrushleveldetail_spine, arg_31_0._gospines, var_31_0.__name)

			arg_31_0._uiSpineList[iter_31_0] = MonoHelper.addNoUpdateLuaComOnceToGo(var_31_1, var_31_0)
		end
	end
end

function var_0_0._refreshRedDot(arg_32_0)
	local var_32_0 = arg_32_0:_getStage()
	local var_32_1
	local var_32_2
	local var_32_3 = var_0_3.BossRushBossReward
	local var_32_4 = BossRushRedModel.instance:getUId(var_32_3, var_32_0)

	RedDotController.instance:addRedDot(arg_32_0._goRedPoint1, var_32_3, var_32_4)
end

function var_0_0._getStage(arg_33_0)
	return arg_33_0.viewParam.stage
end

function var_0_0._getLayer(arg_34_0)
	local var_34_0 = arg_34_0._selectedIndex

	return arg_34_0._stageLayerInfos[var_34_0 or 1].layerCO.layer
end

function var_0_0._getStageAndLayer(arg_35_0)
	return arg_35_0:_getStage(), arg_35_0:_getLayer()
end

function var_0_0._isOpen(arg_36_0, arg_36_1)
	return arg_36_0._stageLayerInfos[arg_36_1].isOpen
end

function var_0_0._doUpdateSelectIcon(arg_37_0, arg_37_1)
	arg_37_0.viewContainer:getBossRushViewRule():refreshUI(arg_37_1)
end

function var_0_0._refreshGoBtn(arg_38_0, arg_38_1)
	local var_38_0 = BossRushEnum.LayerRes.EnterLevelBtn
	local var_38_1 = var_38_0[arg_38_1] or var_38_0[1]

	UISpriteSetMgr.instance:setV1a4BossRushSprite(arg_38_0._gonormalbtn, var_38_1)

	local var_38_2 = BossRushEnum.LayerRes.EnterLevelBtnTxtColor
	local var_38_3 = var_38_2[arg_38_1] or var_38_2[1]
	local var_38_4 = GameUtil.parseColor(var_38_3)

	arg_38_0._txtGoCn.color = var_38_4
	arg_38_0._txtGoEn.color = Color(var_38_4.r, var_38_4.g, var_38_4.b, 0.5)
end

function var_0_0._onBtnGoEnter(arg_39_0)
	arg_39_0:_refreshGoBtn(arg_39_0._selectedIndex)
	arg_39_0:_checkOfferBtn()
end

function var_0_0._checkOfferBtn(arg_40_0)
	local var_40_0, var_40_1 = arg_40_0:_getStageAndLayer()
	local var_40_2 = BossRushModel.instance:isEnhanceRole(var_40_0, var_40_1)

	gohelper.setActive(arg_40_0._btnoffer.gameObject, var_40_2)
end

return var_0_0
