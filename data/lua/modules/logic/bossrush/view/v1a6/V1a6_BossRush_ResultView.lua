module("modules.logic.bossrush.view.v1a6.V1a6_BossRush_ResultView", package.seeall)

local var_0_0 = class("V1a6_BossRush_ResultView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simageFullBG1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG1")
	arg_1_0._simageFullBGLayer4 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG1Layer4")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "Title/#simage_Title")
	arg_1_0._btnRank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Title/#btn_Rank")
	arg_1_0._simagePlayerHead = gohelper.findChildSingleImage(arg_1_0.viewGO, "Player/PlayerHead/#simage_PlayerHead")
	arg_1_0._txtPlayerName = gohelper.findChildText(arg_1_0.viewGO, "Player/#txt_PlayerName")
	arg_1_0._txtTime = gohelper.findChildText(arg_1_0.viewGO, "Player/#txt_Time")
	arg_1_0._imgScoreBg = gohelper.findChildImage(arg_1_0.viewGO, "Right/image_ScoreBG")
	arg_1_0._txtScore = gohelper.findChildText(arg_1_0.viewGO, "Right/image_ScoreBG/#txt_Score")
	arg_1_0._goGroup = gohelper.findChild(arg_1_0.viewGO, "Right/#go_Group")
	arg_1_0._goNotEmpty = gohelper.findChild(arg_1_0.viewGO, "Right/#go_NotEmpty")
	arg_1_0._imgAssessBG = gohelper.findChildImage(arg_1_0.viewGO, "Right/#go_NotEmpty/image_AssessBG")
	arg_1_0._simgAssessBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "Right/#go_NotEmpty/image_AssessBG")
	arg_1_0._goAssessIcon = gohelper.findChild(arg_1_0.viewGO, "Right/#go_AssessIcon")
	arg_1_0._goEvaluate = gohelper.findChild(arg_1_0.viewGO, "Right/#go_Evaluate")
	arg_1_0._scrollaffix = gohelper.findChildScrollRect(arg_1_0.viewGO, "Right/#go_Evaluate/#scroll_affix")
	arg_1_0._goAffixItem = gohelper.findChild(arg_1_0.viewGO, "Right/#go_Evaluate/#scroll_affix/Viewport/Content/#go_AffixItem")
	arg_1_0._goTips = gohelper.findChild(arg_1_0.viewGO, "Right/#go_Evaluate/Tips")
	arg_1_0._scrollTips = gohelper.findChildScrollRect(arg_1_0.viewGO, "Right/#go_Evaluate/Tips/#scroll_Tips")
	arg_1_0._goInfoAffixItem = gohelper.findChild(arg_1_0.viewGO, "Right/#go_Evaluate/Tips/#scroll_Tips/Viewport/Content/#txt_AffixDescr")
	arg_1_0._txtAffixDescr = gohelper.findChildText(arg_1_0.viewGO, "Right/#go_Evaluate/Tips/#scroll_Tips/Viewport/Content/#txt_AffixDescr")
	arg_1_0._goAffixTitle = gohelper.findChild(arg_1_0.viewGO, "Right/#go_Evaluate/Tips/#scroll_Tips/Viewport/Content/#txt_AffixDescr/#go_AffixTitle")
	arg_1_0._btnaffix = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#go_Evaluate/#scroll_affix/#btn_affix")
	arg_1_0._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_1_0.viewGO)
	arg_1_0._animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._animationEvent = arg_1_0.viewGO:GetComponent(gohelper.Type_AnimationEventWrap)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnRank:AddClickListener(arg_2_0._btnRankOnClick, arg_2_0)
	arg_2_0._btnaffix:AddClickListener(arg_2_0._btnaffixOnClick, arg_2_0)
	arg_2_0._animationEvent:AddEventListener(BossRushEnum.AnimEvtResultPanel.EvaluateItemAnim, arg_2_0._evaluateItemAnimCallback, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnRank:RemoveClickListener()
	arg_3_0._btnaffix:RemoveClickListener()
	arg_3_0._animationEvent:RemoveEventListener(BossRushEnum.AnimEvtResultPanel.EvaluateItemAnim)
end

function var_0_0._btnaffixOnClick(arg_4_0)
	local var_4_0 = arg_4_0._tipActive or false

	arg_4_0:activeEvaluateTip(not var_4_0)
end

function var_0_0._btncloseOnClick(arg_5_0)
	if arg_5_0._tipActive then
		arg_5_0:activeEvaluateTip(false)
	else
		arg_5_0:closeThis()
	end
end

function var_0_0._btnRankOnClick(arg_6_0)
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0:_initHeroGroup()
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0._curStage, arg_9_0._curLayer = BossRushModel.instance:getBattleStageAndLayer()
	arg_9_0.fightScore = BossRushModel.instance:getFightScore() or 0
	arg_9_0._txtScore.text = arg_9_0.fightScore
	arg_9_0._isSpecialLayer = BossRushModel.instance:isSpecialLayer(arg_9_0._curLayer)

	arg_9_0:setAssessIcon()
	arg_9_0:_initPlayerInfo()
	arg_9_0:_initBoss()
	arg_9_0:initEvaluate()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mane_post_1_6_appraise)
	gohelper.setActive(arg_9_0._simageFullBG1.gameObject, not arg_9_0._isSpecialLayer)
	gohelper.setActive(arg_9_0._simageFullBGLayer4.gameObject, arg_9_0._isSpecialLayer)
end

function var_0_0.onClose(arg_10_0)
	FightController.onResultViewClose()
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0._simageFullBG:UnLoadImage()
	arg_11_0._simageTitle:UnLoadImage()
	arg_11_0._simagePlayerHead:UnLoadImage()
	arg_11_0._simgAssessBG:UnLoadImage()
	GameUtil.onDestroyViewMember(arg_11_0, "_heroGroup")
end

function var_0_0._initHeroGroup(arg_12_0)
	local var_12_0 = V1a4_BossRush_HeroGroup
	local var_12_1 = arg_12_0.viewContainer:getResInst(BossRushEnum.ResPath.v1a4_bossrush_herogroup, arg_12_0._goGroup, var_12_0.__cname)

	arg_12_0._heroGroup = MonoHelper.addNoUpdateLuaComOnceToGo(var_12_1, var_12_0, arg_12_0.viewContainer)

	arg_12_0._heroGroup:setDataByCurFightParam()
end

function var_0_0._initPlayerInfo(arg_13_0)
	local var_13_0 = PlayerModel.instance:getPlayinfo()

	if not arg_13_0._liveHeadIcon then
		arg_13_0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(arg_13_0._simagePlayerHead)
	end

	arg_13_0._liveHeadIcon:setLiveHead(var_13_0.portrait)

	arg_13_0._txtTime.text = TimeUtil.timestampToString(os.time())
	arg_13_0._txtPlayerName.text = var_13_0.name
end

function var_0_0._initBoss(arg_14_0)
	if arg_14_0._curStage then
		arg_14_0._simageFullBG:LoadImage(BossRushConfig.instance:getResultViewFullBgSImage(arg_14_0._curStage))
		arg_14_0._simageTitle:LoadImage(BossRushConfig.instance:getResultViewNameSImage(arg_14_0._curStage))

		for iter_14_0 = 1, 3 do
			local var_14_0 = gohelper.findChild(arg_14_0.viewGO, "boss_topbg" .. iter_14_0)

			gohelper.setActive(var_14_0, iter_14_0 == arg_14_0._curStage)
		end
	end
end

function var_0_0.setAssessIcon(arg_15_0)
	if not arg_15_0._assessItem then
		arg_15_0:createAssessIcon()
	end

	local var_15_0 = BossRushModel.instance:isSpecialLayer(arg_15_0._curLayer)
	local var_15_1, var_15_2 = arg_15_0._assessItem:setData(arg_15_0._curStage, arg_15_0.fightScore, var_15_0)
	local var_15_3 = string.nilorempty(var_15_1)

	gohelper.setActive(arg_15_0._goNotEmpty, not var_15_3)

	var_15_2 = var_15_2 or -1

	local var_15_4 = Color.white
	local var_15_5 = Color.white

	if var_15_0 then
		arg_15_0._simgAssessBG:LoadImage(ResUrl.getBossRushSinglebg("v2a1_bossrush_assessbg2"))
	else
		if var_15_2 > BossRushEnum.ScoreLevel.S_AA then
			var_15_4 = SLFramework.UGUI.GuiHelper.ParseColor("#D6816C")
			var_15_5 = SLFramework.UGUI.GuiHelper.ParseColor("#BC361D")
		end

		arg_15_0._simgAssessBG:LoadImage(ResUrl.getBossRushSinglebg("v1a6_bossrush_assessbg2"))

		arg_15_0._imgScoreBg.color = var_15_4
		arg_15_0._imgAssessBG.color = var_15_5
	end
end

function var_0_0.createAssessIcon(arg_16_0)
	local var_16_0 = BossRushEnum.ResPath.v1a4_bossrush_result_assess
	local var_16_1 = arg_16_0:getResInst(var_16_0, arg_16_0._goAssessIcon, "AssessIcon")

	arg_16_0._assessItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_16_1, V1a6_BossRush_AssessIcon)
end

function var_0_0.initEvaluate(arg_17_0)
	arg_17_0:activeEvaluateTip(false)
	gohelper.setActive(arg_17_0._goAffixItem, false)
	gohelper.setActive(arg_17_0._goInfoAffixItem, false)

	local var_17_0 = gohelper.findChildImage(arg_17_0._goAffixItem, "image_AffixBG")
	local var_17_1 = gohelper.findChildImage(arg_17_0._goInfoAffixItem, "#go_AffixTitle/image_AffixBG")
	local var_17_2 = arg_17_0._isSpecialLayer and "v2a1_bossrush_affixbg" or "v1a6_bossrush_affixbg"

	UISpriteSetMgr.instance:setV1a4BossRushSprite(var_17_0, var_17_2)
	UISpriteSetMgr.instance:setV1a4BossRushSprite(var_17_1, var_17_2)

	arg_17_0._evaluateList = arg_17_0:getUserDataTb_()
	arg_17_0._evaluateInfoList = arg_17_0:getUserDataTb_()

	arg_17_0:refreshEvaluate()
end

function var_0_0.refreshEvaluate(arg_18_0)
	local var_18_0 = BossRushModel.instance:getEvaluateList()

	if var_18_0 then
		for iter_18_0, iter_18_1 in pairs(var_18_0) do
			local var_18_1 = arg_18_0:getEvaluateItem(iter_18_0)
			local var_18_2, var_18_3 = BossRushConfig.instance:getEvaluateInfo(iter_18_1)

			var_18_1.txt.text = var_18_2

			gohelper.setActive(var_18_1.go, true)

			local var_18_4 = arg_18_0:getEvaluateInfoItem(iter_18_0)

			var_18_4.titleTxt.text = var_18_2
			var_18_4.titledesc.text = var_18_3

			gohelper.setActive(var_18_4.go, true)
		end

		if #arg_18_0._evaluateList > #var_18_0 then
			for iter_18_2 = #var_18_0 + 1, #arg_18_0._evaluateList do
				gohelper.setActive(arg_18_0._evaluateList[iter_18_2].go, false)
			end
		end

		if #arg_18_0._evaluateInfoList > #var_18_0 then
			for iter_18_3 = #var_18_0 + 1, #arg_18_0._evaluateInfoList do
				gohelper.setActive(arg_18_0._evaluateInfoList[iter_18_3].go, false)
			end
		end
	end

	local var_18_5 = var_18_0 and #var_18_0 > 0

	gohelper.setActive(arg_18_0._goEvaluate, var_18_5)

	local var_18_6 = var_18_5 and BossRushEnum.V1a6_ResultAnimName.HasEvaluate or BossRushEnum.V1a6_ResultAnimName.NoEvaluate

	arg_18_0._animatorPlayer:Play(var_18_6, arg_18_0._animCallback, arg_18_0)
end

function var_0_0.getEvaluateItem(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0._evaluateList[arg_19_1]

	if not var_19_0 then
		local var_19_1 = gohelper.cloneInPlace(arg_19_0._goAffixItem, "evaluate_" .. arg_19_1)

		var_19_0 = {
			go = var_19_1,
			txt = gohelper.findChildText(var_19_1, "#txt_Affix"),
			anim = var_19_1:GetComponent(typeof(UnityEngine.Animator))
		}
		arg_19_0._evaluateList[arg_19_1] = var_19_0
	end

	return var_19_0
end

function var_0_0.getEvaluateInfoItem(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0._evaluateInfoList[arg_20_1]

	if not var_20_0 then
		local var_20_1 = gohelper.cloneInPlace(arg_20_0._goInfoAffixItem, "evaluateInfo_" .. arg_20_1)

		var_20_0 = {
			go = var_20_1,
			titleTxt = gohelper.findChildText(var_20_1, "#go_AffixTitle/#txt_Affix"),
			titledesc = var_20_1:GetComponent(gohelper.Type_TextMesh)
		}
		arg_20_0._evaluateInfoList[arg_20_1] = var_20_0
	end

	return var_20_0
end

function var_0_0.activeEvaluateTip(arg_21_0, arg_21_1)
	gohelper.setActive(arg_21_0._goTips, arg_21_1)

	arg_21_0._tipActive = arg_21_1
end

function var_0_0._evaluateItemAnimCallback(arg_22_0)
	if arg_22_0._evaluateList then
		for iter_22_0, iter_22_1 in pairs(arg_22_0._evaluateList) do
			iter_22_1.anim:Play(BossRushEnum.V1a6_ResultAnimName.Open, 0, 0)
		end
	end
end

function var_0_0._animCallback(arg_23_0)
	return
end

return var_0_0
