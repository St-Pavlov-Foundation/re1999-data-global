module("modules.logic.bossrush.view.V1a4_BossRushLevelDetail", package.seeall)

slot0 = class("V1a4_BossRushLevelDetail", BaseView)

function slot0.onInitView(slot0)
	slot0._simagefull = gohelper.findChildSingleImage(slot0.viewGO, "#simage_full")
	slot0._gospines = gohelper.findChild(slot0.viewGO, "#go_spines")
	slot0._goLeftBGEndless = gohelper.findChild(slot0.viewGO, "#go_LeftBGEndless")
	slot0._goLeftBG = gohelper.findChild(slot0.viewGO, "#go_LeftBG")
	slot0._goRightBGEndless = gohelper.findChild(slot0.viewGO, "#go_RightBGEndless")
	slot0._goRightBGLayer4 = gohelper.findChild(slot0.viewGO, "#go_RightBGLayer4")
	slot0._goRightBG = gohelper.findChild(slot0.viewGO, "#go_RightBG")
	slot0._btnSimple = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/#btn_Simple", AudioEnum.ui_activity.play_ui_activity_switch)
	slot0._btnHard = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/#btn_Hard", AudioEnum.ui_activity.play_ui_activity_switch)
	slot0._btnEndless = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/#btn_Endless", AudioEnum.ui_activity.play_ui_activity_switch)
	slot0._btnLayer4 = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/#btn_Layer4", AudioEnum.ui_activity.play_ui_activity_switch)
	slot0._btnbonus = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/#btn_bonus", AudioEnum.ui_task.play_ui_task_page)
	slot0._imageSliderFG = gohelper.findChildImage(slot0.viewGO, "Left/#btn_bonus/image_SliderBG/#image_SliderFG")
	slot0._goAssessIcon = gohelper.findChild(slot0.viewGO, "Left/#btn_bonus/#go_AssessIcon")
	slot0._goRedPoint1 = gohelper.findChild(slot0.viewGO, "Left/#btn_bonus/#go_RedPoint1")
	slot0._txtTitle = gohelper.findChildText(slot0.viewGO, "DetailPanel/Title/#txt_Title")
	slot0._simageTitle = gohelper.findChildSingleImage(slot0.viewGO, "DetailPanel/Title/#txt_Title/#simage_Title")
	slot0._imageIssxIcon = gohelper.findChildImage(slot0.viewGO, "DetailPanel/Title/#txt_Title/#image_IssxIcon")
	slot0._btnSearchIcon = gohelper.findChildButtonWithAudio(slot0.viewGO, "DetailPanel/Title/#txt_Title/#btn_SearchIcon")
	slot0._scrollDescr = gohelper.findChildScrollRect(slot0.viewGO, "DetailPanel/#scroll_desc")
	slot0._txtDescr = gohelper.findChildText(slot0.viewGO, "DetailPanel/#scroll_desc/Viewport/#txt_Descr")
	slot0._txtScoreTotalNum = gohelper.findChildText(slot0.viewGO, "DetailPanel/Attention/Score/#txt_ScoreTotalNum")
	slot0._txtLvNum = gohelper.findChildText(slot0.viewGO, "DetailPanel/Attention/Lv/#txt_LvNum")
	slot0._btnGo = gohelper.findChildButtonWithAudio(slot0.viewGO, "DetailPanel/#btn_Go", AudioEnum.ui_action.play_ui_action_mainstart)
	slot0._txtDoubleTimes = gohelper.findChildText(slot0.viewGO, "DetailPanel/#btn_Go/#txt_DoubleTimes")
	slot0._gonormalbtn = gohelper.findChildImage(slot0.viewGO, "DetailPanel/#btn_Go/#img_normal")
	slot0._txtGoCn = gohelper.findChildText(slot0.viewGO, "DetailPanel/#btn_Go/#img_normal/txt_Go")
	slot0._txtGoEn = gohelper.findChildText(slot0.viewGO, "DetailPanel/#btn_Go/#img_normal/txt_GoEn")
	slot0._btnoffer = gohelper.findChildButtonWithAudio(slot0.viewGO, "DetailPanel/#btn_Offer")
	slot0._vxreceive1 = gohelper.findChild(slot0.viewGO, "Left/vx_receive")
	slot0._imageSliderFG2 = gohelper.findChildImage(slot0.viewGO, "Left/#btn_bonus/image_SliderBG/#image_SliderFG/vx_receive_eff")
	slot0._gomask = gohelper.findChild(slot0.viewGO, "mask")
	slot0._animEvent = slot0.viewGO:GetComponent(gohelper.Type_AnimationEventWrap)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnSimple:AddClickListener(slot0._btnSimpleOnClick, slot0)
	slot0._btnHard:AddClickListener(slot0._btnHardOnClick, slot0)
	slot0._btnEndless:AddClickListener(slot0._btnEndlessOnClick, slot0)
	slot0._btnLayer4:AddClickListener(slot0._btnLayer4OnClick, slot0)
	slot0._btnbonus:AddClickListener(slot0._btnbonusOnClick, slot0)
	slot0._btnSearchIcon:AddClickListener(slot0._btnSearchIconOnClick, slot0)
	slot0._btnGo:AddClickListener(slot0._btnGoOnClick, slot0)
	slot0._btnoffer:AddClickListener(slot0._btnOfferOnClick, slot0)
	slot0._animEvent:AddEventListener(BossRushEnum.AnimEvtAchievementItem.onBtnGoEnter, slot0._onBtnGoEnter, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnSimple:RemoveClickListener()
	slot0._btnHard:RemoveClickListener()
	slot0._btnEndless:RemoveClickListener()
	slot0._btnLayer4:RemoveClickListener()
	slot0._btnbonus:RemoveClickListener()
	slot0._btnSearchIcon:RemoveClickListener()
	slot0._btnGo:RemoveClickListener()
	slot0._btnoffer:RemoveClickListener()
	slot0._animEvent:AddEventListener(BossRushEnum.AnimEvtAchievementItem.onBtnGoEnter, slot0._onBtnGoEnter, slot0)
end

function slot0._btnbonusOnClick(slot0)
	ViewMgr.instance:openView(ViewName.V1a6_BossRush_BonusView, slot0.viewParam)
end

function slot0._btnOfferOnClick(slot0)
	BossRushController.instance:openBossRushOfferRoleView()
end

slot1 = {
	Layer4 = 4,
	Simple = 1,
	Endless = 3,
	Hard = 2
}
slot2 = BossRushEnum.AnimEvtLevelDetail
slot3 = RedDotEnum.DotNode
slot4 = BossRushEnum.AnimLevelDetailBtn

function slot0._btnSearchIconOnClick(slot0)
	slot1, slot2 = slot0:_getStageAndLayer()

	EnemyInfoController.instance:openBossRushEnemyInfoView(BossRushConfig.instance:getActivityId(), slot1, slot2)
end

function slot0._btnSimpleOnClick(slot0)
	slot0:_setSelect(uv0.Simple, true)
end

function slot0._btnHardOnClick(slot0)
	slot0:_setSelect(uv0.Hard, true)
end

function slot0._btnEndlessOnClick(slot0)
	slot0:_setSelect(uv0.Endless, true)
end

function slot0._btnLayer4OnClick(slot0)
	slot0:_setSelect(uv0.Layer4, true)
end

function slot0._btnScheduleOnClick(slot0)
	ViewMgr.instance:openView(ViewName.V1a4_BossRush_ScheduleView, slot0.viewParam)
end

function slot0._btnScoreOnClick(slot0)
	ViewMgr.instance:openView(ViewName.V1a4_BossRush_ScoreTaskAchievement, slot0.viewParam)
end

function slot0._btnGoOnClick(slot0)
	slot1, slot2 = slot0:_getStageAndLayer()

	BossRushController.instance:enterFightScene(slot1, slot2)
end

function slot0._btnBonusOnClick(slot0)
	ViewMgr.instance:openView(ViewName.V1a6_BossRush_BonusView, slot0.viewParam)
end

function slot0._editableInitView(slot0)
	slot1 = V1a4_BossRushLevelDetailItem
	slot0._tabList = {
		MonoHelper.addNoUpdateLuaComOnceToGo(slot0._btnSimple.gameObject, slot1),
		MonoHelper.addNoUpdateLuaComOnceToGo(slot0._btnHard.gameObject, slot1),
		MonoHelper.addNoUpdateLuaComOnceToGo(slot0._btnEndless.gameObject, slot1),
		MonoHelper.addNoUpdateLuaComOnceToGo(slot0._btnLayer4.gameObject, slot1)
	}

	slot0:_initAssessIcon()

	slot0._animSelf = slot0.viewGO:GetComponent(gohelper.Type_Animator)
	slot0._animEvent = slot0.viewGO:GetComponent(gohelper.Type_AnimationEventWrap)
	slot0._animSelf.enabled = false
	slot0._txtDoubleTimes.text = ""
	slot0._txtTitle.text = ""
	slot0._txtLvNum.text = ""

	slot0._animEvent:AddEventListener(uv0.onPlayCloseTransitionFinish, slot0._onPlayCloseTransitionFinish, slot0)
end

function slot0._initAssessIcon(slot0)
	slot1 = V1a4_BossRush_AssessIcon
	slot0._assessIcon = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.viewContainer:getResInst(BossRushEnum.ResPath.v1a4_bossrush_leveldetail_assessicon, slot0._goAssessIcon, slot1.__cname), slot1)

	slot0._assessIcon:initData(slot0, false)
end

function slot0.onUpdateParam(slot0)
end

function slot0._tryLayer2TabIndex(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._stageLayerInfos) do
		if slot6.layer == slot1 then
			return BossRushModel.instance:isBossLayerOpen(slot0:_getStage(), slot1) and slot5 or 1
		end
	end
end

function slot0._getTabUnlockStates(slot0)
	for slot6, slot7 in ipairs(slot0._stageLayerInfos) do
		-- Nothing
	end

	return {
		[slot6] = BossRushRedModel.instance:getIsNewUnlockStageLayer(slot0:_getStage(), slot7.layer)
	}
end

function slot0._tweenUnlockTabs(slot0)
	slot2 = slot0:_getTabUnlockStates()

	slot0:_refreshTabs(slot2)

	for slot6, slot7 in ipairs(slot2) do
		if slot7 then
			slot0._tabList[slot6]:playUnlock()
			BossRushRedModel.instance:setIsNewUnlockStageLayer(slot0:_getStage(), slot0._stageLayerInfos[slot6].layer, false)
		end
	end
end

function slot0.onOpen(slot0)
	slot0._selectedIndex = nil
	slot1 = slot0.viewParam
	slot2 = slot1.stage
	slot4 = BossRushModel.instance:getStagePointInfo(slot2)
	slot0._stageLayerInfos = BossRushModel.instance:getStageLayersInfo(slot2)

	if not slot1.selectedIndex then
		slot1.selectedIndex = slot0:_tryLayer2TabIndex(BossRushModel.instance:getLastMarkSelectedLayer(slot2))
	end

	slot0:_tweenUnlockTabs()
	slot0:_setSelect(slot0.viewParam.selectedIndex or uv0.Simple)
	slot0:_refreshMonster()
	slot0:_refreshRedDot()

	slot5 = slot4.cur / slot4.max
	slot0._imageSliderFG.fillAmount = slot5
	slot0._imageSliderFG2.fillAmount = slot5
	slot0._animSelf.enabled = true

	if slot3 == uv0.Endless then
		AudioMgr.instance:trigger(AudioEnum.ui_activity.play_ui_pkls_challenge_fail_bossrush)
		slot0._animSelf:Play(BossRushEnum.AnimLevelDetail.EndlessEnter)
	elseif slot3 == uv0.Hard then
		slot0._animSelf:Play(BossRushEnum.AnimLevelDetail.HardEnter)
	elseif slot3 == uv0.Simple then
		slot0._animSelf:Play(BossRushEnum.AnimLevelDetail.NormalEnter)
	elseif slot3 == uv0.Layer4 then
		slot0._animSelf:Play(BossRushEnum.AnimLevelDetail.Layer4)
	end

	slot0:_refreshGoBtn(slot3)
	gohelper.setActive(slot0._gomask, false)
	slot0:_checkOfferBtn()
end

function slot0.onOpenFinish(slot0)
end

function slot0.playCloseTransition(slot0)
	slot0._animSelf:Play(BossRushEnum.AnimLevelDetail.CloseView)
	gohelper.setActive(slot0._gomask, true)
end

function slot0._onPlayCloseTransitionFinish(slot0)
	slot0.viewContainer:onPlayCloseTransitionFinish()
end

function slot0.onClose(slot0)
	if slot0.viewParam then
		slot1.selectedIndex = nil
	end
end

function slot0.onDestroyView(slot0)
	slot0._animEvent:RemoveEventListener(uv0.onPlayCloseTransitionFinish)
	slot0._simagefull:UnLoadImage()
	GameUtil.onDestroyViewMemberList(slot0, "_tabList")
	GameUtil.onDestroyViewMemberList(slot0, "_uiSpineList")
end

function slot0._refreshContent(slot0)
	slot1 = slot0.viewParam
	slot2 = slot1.stage
	slot3 = slot1.stageCO
	slot7 = slot0._stageLayerInfos[slot0._selectedIndex].layerCO.layer
	slot8 = BossRushConfig.instance:getBattleMaxPoints(slot2, slot7)
	slot11 = BossRushConfig.instance:isInfinite(slot2, slot7)
	slot12 = BossRushConfig.instance:getDungeonBattleId(slot2, slot7)

	UISpriteSetMgr.instance:setCommonSprite(slot0._imageIssxIcon, BossRushConfig.instance:getIssxIconName(slot2, slot7))
	slot0._simagefull:LoadImage(BossRushConfig.instance:getBossRushLevelDetailFullBgSimage(slot2))

	slot13 = BossRushModel.instance:getLayer4HightScore(slot2) == BossRushModel.instance:getHighestPoint(slot2)

	slot0._assessIcon:setData(slot2, slot10, slot13)
	gohelper.setActive(slot0._vxreceive1, not string.nilorempty(BossRushConfig.instance:getAssessSpriteName(slot2, slot10, slot13)))

	slot0._txtTitle.text = ""

	if slot0._scrollDescr then
		slot0._scrollDescr.verticalNormalizedPosition = 1
	end

	slot0._txtDescr.text = slot6.desc

	ZProj.UGUIHelper.RebuildLayout(slot0._txtDescr.transform)

	slot0._txtLvNum.text = slot6.recommendLevelDesc

	slot0._simageTitle:LoadImage(BossRushConfig.instance:getResultViewNameSImage(slot2))

	slot0._txtScoreTotalNum.text = slot8 == 0 and luaLang("v1a4_bossrushleveldetail_txt_scoretotalnum") or slot8

	if slot11 then
		slot16 = BossRushModel.instance:getDoubleTimesInfo(slot2)
		slot0._txtDoubleTimes.text = GameUtil.getSubPlaceholderLuaLang(luaLang("v1a4_bossrushleveldetail_txt_doubletimes"), {
			slot16.cur,
			slot16.max
		})
	else
		slot0._txtDoubleTimes.text = ""
	end

	gohelper.setActive(slot0._goLeftBGEndless, not BossRushModel.instance:isSpecialLayer(slot7) and slot11)
	gohelper.setActive(slot0._goLeftBG, not slot16 and not slot11)
	gohelper.setActive(slot0._goRightBGEndless, not slot16 and slot11)
	gohelper.setActive(slot0._goRightBG, not slot16 and not slot11)
	gohelper.setActive(slot0._goRightBGLayer4, slot16)
	slot0:_doUpdateSelectIcon(slot12)
end

function slot0._refreshTabs(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._tabList) do
		slot6:setSelect(false)

		if slot0._stageLayerInfos[slot5] then
			slot6:setData(slot5, slot7)

			if slot1 and slot1[slot5] then
				slot6:setIsLocked(true)
			end
		else
			gohelper.setActive(slot6.go, false)
		end
	end
end

function slot0._setSelect(slot0, slot1, slot2)
	if slot0._selectedIndex == slot1 then
		return
	end

	slot3 = slot0._selectedIndex

	if not slot0:_isOpen(slot1) then
		GameFacade.showToast(ToastEnum.V1a4_BossRushLayerLockTip)

		return
	end

	if slot2 then
		if slot1 == uv0.Endless then
			AudioMgr.instance:trigger(AudioEnum.ui_activity.play_ui_pkls_challenge_fail_bossrush)
			slot0._animSelf:Play(BossRushEnum.AnimLevelDetail.SwitchToEndless)
		elseif slot1 == uv0.Hard then
			slot0._animSelf:Play(BossRushEnum.AnimLevelDetail.SwitchToHard)
		elseif slot1 == uv0.Simple then
			slot0._animSelf:Play(BossRushEnum.AnimLevelDetail.SwitchToNormal)
		elseif slot1 == uv0.Layer4 then
			slot0._animSelf:Play(BossRushEnum.AnimLevelDetail.SwitchToLayer4)
		end
	end

	if slot3 then
		slot4 = slot0._tabList[slot3]

		slot4:setSelect(false)
		slot4:playIdle()
	end

	slot0._tabList[slot1]:setSelect(true)

	slot0._selectedIndex = slot1

	if slot2 then
		slot4:plaAnim(uv1.Select, 0, 0)
	else
		slot0:_checkOfferBtn()
	end

	slot0:_refreshContent()

	slot5, slot6 = slot0:_getStageAndLayer()

	BossRushModel.instance:setLastMarkSelectedLayer(slot5, slot6)
end

function slot0._refreshMonster(slot0)
	slot1 = slot0:_getStage()

	slot0:_initMonsterSpines(#BossRushConfig.instance:getMonsterSkinIdList(slot1))

	for slot8, slot9 in ipairs(slot0._uiSpineList) do
		slot12 = BossRushConfig.instance:getMonsterSkinOffsetXYs(slot1)[slot8]

		slot9:setData(slot2[slot8])
		slot9:setScale(BossRushConfig.instance:getMonsterSkinScaleList(slot1)[slot8])
		slot9:setOffsetXY(slot12[1], slot12[2])
	end
end

function slot0._initMonsterSpines(slot0, slot1)
	slot2 = V1a4_BossRushLevelDetail_Spine

	if not slot0._uiSpineList or slot1 > #slot0._uiSpineList then
		slot0._uiSpineList = slot0._uiSpineList or {}

		for slot7 = #slot0._uiSpineList + 1, slot1 do
			slot0._uiSpineList[slot7] = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.viewContainer:getResInst(BossRushEnum.ResPath.v1a4_bossrushleveldetail_spine, slot0._gospines, slot2.__name), slot2)
		end
	end
end

function slot0._refreshRedDot(slot0)
	slot2, slot3 = nil
	slot2 = uv0.BossRushBossReward

	RedDotController.instance:addRedDot(slot0._goRedPoint1, slot2, BossRushRedModel.instance:getUId(slot2, slot0:_getStage()))
end

function slot0._getStage(slot0)
	return slot0.viewParam.stage
end

function slot0._getLayer(slot0)
	return slot0._stageLayerInfos[slot0._selectedIndex or 1].layerCO.layer
end

function slot0._getStageAndLayer(slot0)
	return slot0:_getStage(), slot0:_getLayer()
end

function slot0._isOpen(slot0, slot1)
	return slot0._stageLayerInfos[slot1].isOpen
end

function slot0._doUpdateSelectIcon(slot0, slot1)
	slot0.viewContainer:getBossRushViewRule():refreshUI(slot1)
end

function slot0._refreshGoBtn(slot0, slot1)
	UISpriteSetMgr.instance:setV1a4BossRushSprite(slot0._gonormalbtn, BossRushEnum.LayerRes.EnterLevelBtn[slot1] or slot2[1])

	slot6 = GameUtil.parseColor(BossRushEnum.LayerRes.EnterLevelBtnTxtColor[slot1] or slot4[1])
	slot0._txtGoCn.color = slot6
	slot0._txtGoEn.color = Color(slot6.r, slot6.g, slot6.b, 0.5)
end

function slot0._onBtnGoEnter(slot0)
	slot0:_refreshGoBtn(slot0._selectedIndex)
	slot0:_checkOfferBtn()
end

function slot0._checkOfferBtn(slot0)
	slot1, slot2 = slot0:_getStageAndLayer()

	gohelper.setActive(slot0._btnoffer.gameObject, BossRushModel.instance:isEnhanceRole(slot1, slot2))
end

return slot0
