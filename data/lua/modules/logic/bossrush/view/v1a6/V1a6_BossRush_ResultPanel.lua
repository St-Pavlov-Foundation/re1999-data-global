module("modules.logic.bossrush.view.v1a6.V1a6_BossRush_ResultPanel", package.seeall)

local var_0_0 = class("V1a6_BossRush_ResultPanel", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._goscore = gohelper.findChild(arg_1_0.viewGO, "#go_score")
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_score/#simage_FullBG")
	arg_1_0._imgScorebg = gohelper.findChildImage(arg_1_0.viewGO, "#go_score/Right/Score/image_ScoreBG")
	arg_1_0._txtScore = gohelper.findChildText(arg_1_0.viewGO, "#go_score/Right/Score/image_ScoreBG/#txt_Score")
	arg_1_0._gonewrecord = gohelper.findChild(arg_1_0.viewGO, "#go_score/Right/Title/go_newrecord")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "#go_score/Right/Title/txt_Title")
	arg_1_0._txtTitleEn = gohelper.findChildText(arg_1_0.viewGO, "#go_score/Right/Title/txt_TitleEn")
	arg_1_0._goAffixItem = gohelper.findChild(arg_1_0.viewGO, "#go_score/Right/Affix/#go_AffixItem")
	arg_1_0._txtAffix = gohelper.findChildText(arg_1_0.viewGO, "#go_score/Right/Affix/#go_AffixItem/#txt_Affix")
	arg_1_0._goAssessNotEmpty = gohelper.findChild(arg_1_0.viewGO, "#go_score/#go_AssessNotEmpty")
	arg_1_0._imgAssessbg = gohelper.findChildImage(arg_1_0.viewGO, "#go_score/#go_AssessNotEmpty/image_AssessLight")
	arg_1_0._goAssessIcon = gohelper.findChild(arg_1_0.viewGO, "#go_score/#go_AssessIcon")
	arg_1_0._goassess = gohelper.findChild(arg_1_0.viewGO, "#go_assess")
	arg_1_0._goRigth = gohelper.findChild(arg_1_0.viewGO, "#go_score/Right")
	arg_1_0._go3s = gohelper.findChild(arg_1_0.viewGO, "#go_score/3s")
	arg_1_0._go4s = gohelper.findChild(arg_1_0.viewGO, "#go_score/4s")
	arg_1_0._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_1_0.viewGO)
	arg_1_0._animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._animationEvent = arg_1_0.viewGO:GetComponent(gohelper.Type_AnimationEventWrap)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	BossRushController.instance:registerCallback(BossRushEvent.OnReceiveGet128EvaluateReply, arg_2_0.refreshEvaluate, arg_2_0)
	arg_2_0._animationEvent:AddEventListener(BossRushEnum.AnimEvtResultPanel.ScoreTween, arg_2_0._scoreTweenCallback, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	BossRushController.instance:unregisterCallback(BossRushEvent.OnReceiveGet128EvaluateReply, arg_3_0.refreshEvaluate, arg_3_0)
	arg_3_0._animationEvent:RemoveEventListener(BossRushEnum.AnimEvtResultPanel.ScoreTween)
end

function var_0_0._btncloseOnClick(arg_4_0)
	if arg_4_0._clickCount < 60 and not arg_4_0._isCanSkip then
		arg_4_0._clickCount = arg_4_0._clickCount + 1

		return
	end

	arg_4_0:_openResultView()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._curStage, arg_5_0._curLayer = BossRushModel.instance:getBattleStageAndLayer()
	arg_5_0.fightScore = BossRushModel.instance:getFightScore() or 0
	arg_5_0._txtScore.text = 0
	arg_5_0._isSpecialLayer = BossRushModel.instance:isSpecialLayer(arg_5_0._curLayer)

	arg_5_0:createResultAssess()
	arg_5_0:setAssessIcon()
	arg_5_0:initEvaluate()
	arg_5_0:checkIsNewRecord()
end

function var_0_0._openResultView(arg_6_0)
	ViewMgr.instance:openView(ViewName.V1a6_BossRush_ResultView, arg_6_0.viewParam)
	arg_6_0:closeThis()
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0._isCanSkip = false
	arg_8_0._clickCount = 0
end

function var_0_0.onClose(arg_9_0)
	if arg_9_0._tweenId then
		ZProj.TweenHelper.KillById(arg_9_0._tweenId)

		arg_9_0._tweenId = nil
	end

	arg_9_0:_onTweenFinish()
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

function var_0_0.onClickModalMask(arg_11_0)
	arg_11_0:_btncloseOnClick()
end

function var_0_0.setAssessIcon(arg_12_0)
	local var_12_0 = BossRushModel.instance:isSpecialLayer(arg_12_0._curLayer)
	local var_12_1, var_12_2, var_12_3 = BossRushConfig.instance:getAssessSpriteName(arg_12_0._curStage, arg_12_0.fightScore, var_12_0)
	local var_12_4 = string.nilorempty(var_12_1)

	gohelper.setActive(arg_12_0._goAssessNotEmpty, not var_12_4)

	if arg_12_0._resultAssessItem then
		if not var_12_4 then
			arg_12_0._resultAssessItem:setData(arg_12_0._curStage, arg_12_0.fightScore, var_12_2, arg_12_0, arg_12_0._isSpecialLayer)
		elseif not arg_12_0._assessItem then
			arg_12_0:createAssessIcon()
			arg_12_0._assessItem:setData(arg_12_0._curStage, arg_12_0.fightScore, arg_12_0._isSpecialLayer)
		end

		arg_12_0._resultAssessItem:playAnim(var_12_4, arg_12_0._animFinishCallback, arg_12_0)
		arg_12_0._resultAssessItem:refreshLayerGo(arg_12_0._isSpecialLayer)
	end

	local var_12_5 = var_12_4 and BossRushEnum.V1a6_ResultAnimName.OpenEmpty or BossRushEnum.V1a6_ResultAnimName.Open

	arg_12_0._animatorPlayer:Play(var_12_5, arg_12_0._openAnimCallback, arg_12_0)

	var_12_2 = var_12_2 or -1

	local var_12_6 = var_12_2 > BossRushEnum.ScoreLevel.S_AA
	local var_12_7 = var_12_6 and SLFramework.UGUI.GuiHelper.ParseColor("#D6816C") or Color.white
	local var_12_8 = var_12_6 and SLFramework.UGUI.GuiHelper.ParseColor("#E78263") or Color.white

	arg_12_0._imgScorebg.color = var_12_7
	arg_12_0._imgAssessbg.color = var_12_8

	gohelper.setActive(arg_12_0._go3s, not arg_12_0._isSpecialLayer and not var_12_6)
	gohelper.setActive(arg_12_0._go4s, not arg_12_0._isSpecialLayer and var_12_6)

	local var_12_9 = gohelper.findChild(arg_12_0.viewGO, "#go_score/Layer4")

	gohelper.setActive(var_12_9, arg_12_0._isSpecialLayer)
end

function var_0_0.createResultAssess(arg_13_0)
	local var_13_0 = BossRushEnum.ResPath.v1a6_bossrush_result_assess
	local var_13_1 = arg_13_0:getResInst(var_13_0, arg_13_0._goassess, "ResultAssess")

	arg_13_0._resultAssessItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_13_1, V1a6_BossRush_ResultAssess)
end

function var_0_0.createAssessIcon(arg_14_0)
	local var_14_0 = BossRushEnum.ResPath.v1a4_bossrush_result_assess
	local var_14_1 = arg_14_0:getResInst(var_14_0, arg_14_0._goAssessIcon.gameObject, "AssessIcon")

	arg_14_0._assessItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_14_1, V1a6_BossRush_AssessIcon)
end

function var_0_0._animFinishCallback(arg_15_0)
	return
end

function var_0_0._openAnimCallback(arg_16_0)
	if arg_16_0._evaluateList then
		for iter_16_0, iter_16_1 in pairs(arg_16_0._evaluateList) do
			iter_16_1.anim:Play(BossRushEnum.V1a6_ResultAnimName.Open, 0, 0)
		end
	end
end

function var_0_0._scoreTweenCallback(arg_17_0)
	arg_17_0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, arg_17_0.fightScore, 0.5, arg_17_0._onTweenUpdate, arg_17_0._onTweenFinish, arg_17_0)
end

function var_0_0._onTweenUpdate(arg_18_0, arg_18_1)
	if arg_18_0._txtScore then
		arg_18_0._txtScore.text = Mathf.Ceil(arg_18_1)
	end
end

function var_0_0._onTweenFinish(arg_19_0)
	arg_19_0._isCanSkip = true
	arg_19_0._txtScore.text = arg_19_0.fightScore
end

function var_0_0.initEvaluate(arg_20_0)
	gohelper.setActive(arg_20_0._goAffixItem, false)

	local var_20_0 = gohelper.findChildImage(arg_20_0._goAffixItem, "image_AffixBG")
	local var_20_1 = arg_20_0._isSpecialLayer and "v2a1_bossrush_affixbg" or "v1a6_bossrush_affixbg"

	UISpriteSetMgr.instance:setV1a4BossRushSprite(var_20_0, var_20_1)

	arg_20_0._evaluateList = arg_20_0:getUserDataTb_()

	arg_20_0:refreshEvaluate()
end

function var_0_0.refreshEvaluate(arg_21_0)
	local var_21_0 = BossRushModel.instance:getEvaluateList()

	if var_21_0 and #var_21_0 > 0 then
		for iter_21_0, iter_21_1 in pairs(var_21_0) do
			local var_21_1 = arg_21_0:getEvaluateItem(iter_21_0)
			local var_21_2, var_21_3 = BossRushConfig.instance:getEvaluateInfo(iter_21_1)

			var_21_1.txt.text = var_21_2

			gohelper.setActive(var_21_1.go, true)
		end

		if #arg_21_0._evaluateList > #var_21_0 then
			for iter_21_2 = #var_21_0 + 1, #arg_21_0._evaluateList do
				gohelper.setActive(arg_21_0._evaluateList[iter_21_2].go, false)
			end
		end
	end
end

function var_0_0.getEvaluateItem(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0._evaluateList[arg_22_1]

	if not var_22_0 then
		local var_22_1 = gohelper.cloneInPlace(arg_22_0._goAffixItem, "evaluate_" .. arg_22_1)

		var_22_0 = {
			go = var_22_1,
			txt = gohelper.findChildText(var_22_1, "#txt_Affix"),
			anim = var_22_1:GetComponent(typeof(UnityEngine.Animator))
		}
		arg_22_0._evaluateList[arg_22_1] = var_22_0
	end

	return var_22_0
end

function var_0_0.checkIsNewRecord(arg_23_0)
	if arg_23_0._curStage then
		local var_23_0 = BossRushModel.instance:checkIsNewHighestPointRecord(arg_23_0._curStage)
		local var_23_1 = var_23_0 and "v1a4_bossrush_resultview_txt_newrecord" or "v1a4_bossrush_resultview_txt_score"

		arg_23_0._txtTitle.text = luaLang(var_23_1)
		arg_23_0._txtTitleEn.text = luaLang(var_23_1 .. "_en")

		gohelper.setActive(arg_23_0._gonewrecord, var_23_0)
	end
end

return var_0_0
