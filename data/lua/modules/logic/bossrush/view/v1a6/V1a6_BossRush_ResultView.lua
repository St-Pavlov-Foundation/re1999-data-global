module("modules.logic.bossrush.view.v1a6.V1a6_BossRush_ResultView", package.seeall)

slot0 = class("V1a6_BossRush_ResultView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._simageFullBG1 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG1")
	slot0._simageFullBGLayer4 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG1Layer4")
	slot0._simageTitle = gohelper.findChildSingleImage(slot0.viewGO, "Title/#simage_Title")
	slot0._btnRank = gohelper.findChildButtonWithAudio(slot0.viewGO, "Title/#btn_Rank")
	slot0._simagePlayerHead = gohelper.findChildSingleImage(slot0.viewGO, "Player/PlayerHead/#simage_PlayerHead")
	slot0._txtPlayerName = gohelper.findChildText(slot0.viewGO, "Player/#txt_PlayerName")
	slot0._txtTime = gohelper.findChildText(slot0.viewGO, "Player/#txt_Time")
	slot0._imgScoreBg = gohelper.findChildImage(slot0.viewGO, "Right/image_ScoreBG")
	slot0._txtScore = gohelper.findChildText(slot0.viewGO, "Right/image_ScoreBG/#txt_Score")
	slot0._goGroup = gohelper.findChild(slot0.viewGO, "Right/#go_Group")
	slot0._goNotEmpty = gohelper.findChild(slot0.viewGO, "Right/#go_NotEmpty")
	slot0._imgAssessBG = gohelper.findChildImage(slot0.viewGO, "Right/#go_NotEmpty/image_AssessBG")
	slot0._simgAssessBG = gohelper.findChildSingleImage(slot0.viewGO, "Right/#go_NotEmpty/image_AssessBG")
	slot0._goAssessIcon = gohelper.findChild(slot0.viewGO, "Right/#go_AssessIcon")
	slot0._goEvaluate = gohelper.findChild(slot0.viewGO, "Right/#go_Evaluate")
	slot0._scrollaffix = gohelper.findChildScrollRect(slot0.viewGO, "Right/#go_Evaluate/#scroll_affix")
	slot0._goAffixItem = gohelper.findChild(slot0.viewGO, "Right/#go_Evaluate/#scroll_affix/Viewport/Content/#go_AffixItem")
	slot0._goTips = gohelper.findChild(slot0.viewGO, "Right/#go_Evaluate/Tips")
	slot0._scrollTips = gohelper.findChildScrollRect(slot0.viewGO, "Right/#go_Evaluate/Tips/#scroll_Tips")
	slot0._goInfoAffixItem = gohelper.findChild(slot0.viewGO, "Right/#go_Evaluate/Tips/#scroll_Tips/Viewport/Content/#txt_AffixDescr")
	slot0._txtAffixDescr = gohelper.findChildText(slot0.viewGO, "Right/#go_Evaluate/Tips/#scroll_Tips/Viewport/Content/#txt_AffixDescr")
	slot0._goAffixTitle = gohelper.findChild(slot0.viewGO, "Right/#go_Evaluate/Tips/#scroll_Tips/Viewport/Content/#txt_AffixDescr/#go_AffixTitle")
	slot0._btnaffix = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#go_Evaluate/#scroll_affix/#btn_affix")
	slot0._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(slot0.viewGO)
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._animationEvent = slot0.viewGO:GetComponent(gohelper.Type_AnimationEventWrap)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnRank:AddClickListener(slot0._btnRankOnClick, slot0)
	slot0._btnaffix:AddClickListener(slot0._btnaffixOnClick, slot0)
	slot0._animationEvent:AddEventListener(BossRushEnum.AnimEvtResultPanel.EvaluateItemAnim, slot0._evaluateItemAnimCallback, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnRank:RemoveClickListener()
	slot0._btnaffix:RemoveClickListener()
	slot0._animationEvent:RemoveEventListener(BossRushEnum.AnimEvtResultPanel.EvaluateItemAnim)
end

function slot0._btnaffixOnClick(slot0)
	slot0:activeEvaluateTip(not (slot0._tipActive or false))
end

function slot0._btncloseOnClick(slot0)
	if slot0._tipActive then
		slot0:activeEvaluateTip(false)
	else
		slot0:closeThis()
	end
end

function slot0._btnRankOnClick(slot0)
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function slot0._editableInitView(slot0)
	slot0:_initHeroGroup()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._curStage, slot0._curLayer = BossRushModel.instance:getBattleStageAndLayer()
	slot0.fightScore = BossRushModel.instance:getFightScore() or 0
	slot0._txtScore.text = slot0.fightScore
	slot0._isSpecialLayer = BossRushModel.instance:isSpecialLayer(slot0._curLayer)

	slot0:setAssessIcon()
	slot0:_initPlayerInfo()
	slot0:_initBoss()
	slot0:initEvaluate()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mane_post_1_6_appraise)
	gohelper.setActive(slot0._simageFullBG1.gameObject, not slot0._isSpecialLayer)
	gohelper.setActive(slot0._simageFullBGLayer4.gameObject, slot0._isSpecialLayer)
end

function slot0.onClose(slot0)
	FightController.onResultViewClose()
end

function slot0.onDestroyView(slot0)
	slot0._simageFullBG:UnLoadImage()
	slot0._simageTitle:UnLoadImage()
	slot0._simagePlayerHead:UnLoadImage()
	slot0._simgAssessBG:UnLoadImage()
	GameUtil.onDestroyViewMember(slot0, "_heroGroup")
end

function slot0._initHeroGroup(slot0)
	slot1 = V1a4_BossRush_HeroGroup
	slot0._heroGroup = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.viewContainer:getResInst(BossRushEnum.ResPath.v1a4_bossrush_herogroup, slot0._goGroup, slot1.__cname), slot1, slot0.viewContainer)

	slot0._heroGroup:setDataByCurFightParam()
end

function slot0._initPlayerInfo(slot0)
	slot1 = PlayerModel.instance:getPlayinfo()

	if not slot0._liveHeadIcon then
		slot0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(slot0._simagePlayerHead)
	end

	slot0._liveHeadIcon:setLiveHead(slot1.portrait)

	slot0._txtTime.text = TimeUtil.timestampToString(os.time())
	slot0._txtPlayerName.text = slot1.name
end

function slot0._initBoss(slot0)
	if slot0._curStage then
		slot0._simageFullBG:LoadImage(BossRushConfig.instance:getResultViewFullBgSImage(slot0._curStage))

		slot4 = BossRushConfig.instance
		slot4 = slot4.getResultViewNameSImage

		slot0._simageTitle:LoadImage(slot4(slot4, slot0._curStage))

		for slot4 = 1, 3 do
			gohelper.setActive(gohelper.findChild(slot0.viewGO, "boss_topbg" .. slot4), slot4 == slot0._curStage)
		end
	end
end

function slot0.setAssessIcon(slot0)
	if not slot0._assessItem then
		slot0:createAssessIcon()
	end

	slot2, slot3 = slot0._assessItem:setData(slot0._curStage, slot0.fightScore, BossRushModel.instance:isSpecialLayer(slot0._curLayer))

	gohelper.setActive(slot0._goNotEmpty, not string.nilorempty(slot2))

	slot3 = slot3 or -1
	slot5 = Color.white
	slot6 = Color.white

	if slot1 then
		slot0._simgAssessBG:LoadImage(ResUrl.getBossRushSinglebg("v2a1_bossrush_assessbg2"))
	else
		if BossRushEnum.ScoreLevel.S_AA < slot3 then
			slot5 = SLFramework.UGUI.GuiHelper.ParseColor("#D6816C")
			slot6 = SLFramework.UGUI.GuiHelper.ParseColor("#BC361D")
		end

		slot0._simgAssessBG:LoadImage(ResUrl.getBossRushSinglebg("v1a6_bossrush_assessbg2"))

		slot0._imgScoreBg.color = slot5
		slot0._imgAssessBG.color = slot6
	end
end

function slot0.createAssessIcon(slot0)
	slot0._assessItem = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(BossRushEnum.ResPath.v1a4_bossrush_result_assess, slot0._goAssessIcon, "AssessIcon"), V1a6_BossRush_AssessIcon)
end

function slot0.initEvaluate(slot0)
	slot0:activeEvaluateTip(false)
	gohelper.setActive(slot0._goAffixItem, false)
	gohelper.setActive(slot0._goInfoAffixItem, false)

	slot3 = slot0._isSpecialLayer and "v2a1_bossrush_affixbg" or "v1a6_bossrush_affixbg"

	UISpriteSetMgr.instance:setV1a4BossRushSprite(gohelper.findChildImage(slot0._goAffixItem, "image_AffixBG"), slot3)
	UISpriteSetMgr.instance:setV1a4BossRushSprite(gohelper.findChildImage(slot0._goInfoAffixItem, "#go_AffixTitle/image_AffixBG"), slot3)

	slot0._evaluateList = slot0:getUserDataTb_()
	slot0._evaluateInfoList = slot0:getUserDataTb_()

	slot0:refreshEvaluate()
end

function slot0.refreshEvaluate(slot0)
	if BossRushModel.instance:getEvaluateList() then
		for slot5, slot6 in pairs(slot1) do
			slot7 = slot0:getEvaluateItem(slot5)
			slot8, slot10.titledesc.text = BossRushConfig.instance:getEvaluateInfo(slot6)
			slot7.txt.text = slot8

			gohelper.setActive(slot7.go, true)

			slot10 = slot0:getEvaluateInfoItem(slot5)
			slot10.titleTxt.text = slot8

			gohelper.setActive(slot10.go, true)
		end

		if #slot0._evaluateList > #slot1 then
			for slot5 = #slot1 + 1, #slot0._evaluateList do
				gohelper.setActive(slot0._evaluateList[slot5].go, false)
			end
		end

		if #slot0._evaluateInfoList > #slot1 then
			for slot5 = #slot1 + 1, #slot0._evaluateInfoList do
				gohelper.setActive(slot0._evaluateInfoList[slot5].go, false)
			end
		end
	end

	slot2 = slot1 and #slot1 > 0

	gohelper.setActive(slot0._goEvaluate, slot2)
	slot0._animatorPlayer:Play(slot2 and BossRushEnum.V1a6_ResultAnimName.HasEvaluate or BossRushEnum.V1a6_ResultAnimName.NoEvaluate, slot0._animCallback, slot0)
end

function slot0.getEvaluateItem(slot0, slot1)
	if not slot0._evaluateList[slot1] then
		slot3 = gohelper.cloneInPlace(slot0._goAffixItem, "evaluate_" .. slot1)
		slot0._evaluateList[slot1] = {
			go = slot3,
			txt = gohelper.findChildText(slot3, "#txt_Affix"),
			anim = slot3:GetComponent(typeof(UnityEngine.Animator))
		}
	end

	return slot2
end

function slot0.getEvaluateInfoItem(slot0, slot1)
	if not slot0._evaluateInfoList[slot1] then
		slot3 = gohelper.cloneInPlace(slot0._goInfoAffixItem, "evaluateInfo_" .. slot1)
		slot0._evaluateInfoList[slot1] = {
			go = slot3,
			titleTxt = gohelper.findChildText(slot3, "#go_AffixTitle/#txt_Affix"),
			titledesc = slot3:GetComponent(gohelper.Type_TextMesh)
		}
	end

	return slot2
end

function slot0.activeEvaluateTip(slot0, slot1)
	gohelper.setActive(slot0._goTips, slot1)

	slot0._tipActive = slot1
end

function slot0._evaluateItemAnimCallback(slot0)
	if slot0._evaluateList then
		for slot4, slot5 in pairs(slot0._evaluateList) do
			slot5.anim:Play(BossRushEnum.V1a6_ResultAnimName.Open, 0, 0)
		end
	end
end

function slot0._animCallback(slot0)
end

return slot0
