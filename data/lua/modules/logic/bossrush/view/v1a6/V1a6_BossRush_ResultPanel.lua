module("modules.logic.bossrush.view.v1a6.V1a6_BossRush_ResultPanel", package.seeall)

slot0 = class("V1a6_BossRush_ResultPanel", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._goscore = gohelper.findChild(slot0.viewGO, "#go_score")
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#go_score/#simage_FullBG")
	slot0._imgScorebg = gohelper.findChildImage(slot0.viewGO, "#go_score/Right/Score/image_ScoreBG")
	slot0._txtScore = gohelper.findChildText(slot0.viewGO, "#go_score/Right/Score/image_ScoreBG/#txt_Score")
	slot0._gonewrecord = gohelper.findChild(slot0.viewGO, "#go_score/Right/Title/go_newrecord")
	slot0._txtTitle = gohelper.findChildText(slot0.viewGO, "#go_score/Right/Title/txt_Title")
	slot0._txtTitleEn = gohelper.findChildText(slot0.viewGO, "#go_score/Right/Title/txt_TitleEn")
	slot0._goAffixItem = gohelper.findChild(slot0.viewGO, "#go_score/Right/Affix/#go_AffixItem")
	slot0._txtAffix = gohelper.findChildText(slot0.viewGO, "#go_score/Right/Affix/#go_AffixItem/#txt_Affix")
	slot0._goAssessNotEmpty = gohelper.findChild(slot0.viewGO, "#go_score/#go_AssessNotEmpty")
	slot0._imgAssessbg = gohelper.findChildImage(slot0.viewGO, "#go_score/#go_AssessNotEmpty/image_AssessLight")
	slot0._goAssessIcon = gohelper.findChild(slot0.viewGO, "#go_score/#go_AssessIcon")
	slot0._goassess = gohelper.findChild(slot0.viewGO, "#go_assess")
	slot0._goRigth = gohelper.findChild(slot0.viewGO, "#go_score/Right")
	slot0._go3s = gohelper.findChild(slot0.viewGO, "#go_score/3s")
	slot0._go4s = gohelper.findChild(slot0.viewGO, "#go_score/4s")
	slot0._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(slot0.viewGO)
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._animationEvent = slot0.viewGO:GetComponent(gohelper.Type_AnimationEventWrap)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	BossRushController.instance:registerCallback(BossRushEvent.OnReceiveGet128EvaluateReply, slot0.refreshEvaluate, slot0)
	slot0._animationEvent:AddEventListener(BossRushEnum.AnimEvtResultPanel.ScoreTween, slot0._scoreTweenCallback, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	BossRushController.instance:unregisterCallback(BossRushEvent.OnReceiveGet128EvaluateReply, slot0.refreshEvaluate, slot0)
	slot0._animationEvent:RemoveEventListener(BossRushEnum.AnimEvtResultPanel.ScoreTween)
end

function slot0._btncloseOnClick(slot0)
	if slot0._clickCount < 60 and not slot0._isCanSkip then
		slot0._clickCount = slot0._clickCount + 1

		return
	end

	slot0:_openResultView()
end

function slot0._editableInitView(slot0)
	slot0._curStage, slot0._curLayer = BossRushModel.instance:getBattleStageAndLayer()
	slot0.fightScore = BossRushModel.instance:getFightScore() or 0
	slot0._txtScore.text = 0
	slot0._isSpecialLayer = BossRushModel.instance:isSpecialLayer(slot0._curLayer)

	slot0:createResultAssess()
	slot0:setAssessIcon()
	slot0:initEvaluate()
	slot0:checkIsNewRecord()
end

function slot0._openResultView(slot0)
	ViewMgr.instance:openView(ViewName.V1a6_BossRush_ResultView, slot0.viewParam)
	slot0:closeThis()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._isCanSkip = false
	slot0._clickCount = 0
end

function slot0.onClose(slot0)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	slot0:_onTweenFinish()
end

function slot0.onDestroyView(slot0)
end

function slot0.onClickModalMask(slot0)
	slot0:_btncloseOnClick()
end

function slot0.setAssessIcon(slot0)
	slot2, slot3, slot4 = BossRushConfig.instance:getAssessSpriteName(slot0._curStage, slot0.fightScore, BossRushModel.instance:isSpecialLayer(slot0._curLayer))

	gohelper.setActive(slot0._goAssessNotEmpty, not string.nilorempty(slot2))

	if slot0._resultAssessItem then
		if not slot5 then
			slot0._resultAssessItem:setData(slot0._curStage, slot0.fightScore, slot3, slot0, slot0._isSpecialLayer)
		elseif not slot0._assessItem then
			slot0:createAssessIcon()
			slot0._assessItem:setData(slot0._curStage, slot0.fightScore, slot0._isSpecialLayer)
		end

		slot0._resultAssessItem:playAnim(slot5, slot0._animFinishCallback, slot0)
		slot0._resultAssessItem:refreshLayerGo(slot0._isSpecialLayer)
	end

	slot0._animatorPlayer:Play(slot5 and BossRushEnum.V1a6_ResultAnimName.OpenEmpty or BossRushEnum.V1a6_ResultAnimName.Open, slot0._openAnimCallback, slot0)

	slot7 = BossRushEnum.ScoreLevel.S_AA < (slot3 or -1)
	slot0._imgScorebg.color = slot7 and SLFramework.UGUI.GuiHelper.ParseColor("#D6816C") or Color.white
	slot0._imgAssessbg.color = slot7 and SLFramework.UGUI.GuiHelper.ParseColor("#E78263") or Color.white

	gohelper.setActive(slot0._go3s, not slot0._isSpecialLayer and not slot7)
	gohelper.setActive(slot0._go4s, not slot0._isSpecialLayer and slot7)
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "#go_score/Layer4"), slot0._isSpecialLayer)
end

function slot0.createResultAssess(slot0)
	slot0._resultAssessItem = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(BossRushEnum.ResPath.v1a6_bossrush_result_assess, slot0._goassess, "ResultAssess"), V1a6_BossRush_ResultAssess)
end

function slot0.createAssessIcon(slot0)
	slot0._assessItem = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(BossRushEnum.ResPath.v1a4_bossrush_result_assess, slot0._goAssessIcon.gameObject, "AssessIcon"), V1a6_BossRush_AssessIcon)
end

function slot0._animFinishCallback(slot0)
end

function slot0._openAnimCallback(slot0)
	if slot0._evaluateList then
		for slot4, slot5 in pairs(slot0._evaluateList) do
			slot5.anim:Play(BossRushEnum.V1a6_ResultAnimName.Open, 0, 0)
		end
	end
end

function slot0._scoreTweenCallback(slot0)
	slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, slot0.fightScore, 0.5, slot0._onTweenUpdate, slot0._onTweenFinish, slot0)
end

function slot0._onTweenUpdate(slot0, slot1)
	if slot0._txtScore then
		slot0._txtScore.text = Mathf.Ceil(slot1)
	end
end

function slot0._onTweenFinish(slot0)
	slot0._isCanSkip = true
end

function slot0.initEvaluate(slot0)
	gohelper.setActive(slot0._goAffixItem, false)
	UISpriteSetMgr.instance:setV1a4BossRushSprite(gohelper.findChildImage(slot0._goAffixItem, "image_AffixBG"), slot0._isSpecialLayer and "v2a1_bossrush_affixbg" or "v1a6_bossrush_affixbg")

	slot0._evaluateList = slot0:getUserDataTb_()

	slot0:refreshEvaluate()
end

function slot0.refreshEvaluate(slot0)
	if BossRushModel.instance:getEvaluateList() and #slot1 > 0 then
		for slot6, slot7 in pairs(slot1) do
			slot8 = slot0:getEvaluateItem(slot6)
			slot8.txt.text, slot10 = BossRushConfig.instance:getEvaluateInfo(slot7)

			gohelper.setActive(slot8.go, true)
		end

		if #slot0._evaluateList > #slot1 then
			for slot6 = #slot1 + 1, #slot0._evaluateList do
				gohelper.setActive(slot0._evaluateList[slot6].go, false)
			end
		end
	end
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

function slot0.checkIsNewRecord(slot0)
	if slot0._curStage then
		slot2 = BossRushModel.instance:checkIsNewHighestPointRecord(slot0._curStage) and "v1a4_bossrush_resultview_txt_newrecord" or "v1a4_bossrush_resultview_txt_score"
		slot0._txtTitle.text = luaLang(slot2)
		slot0._txtTitleEn.text = luaLang(slot2 .. "_en")

		gohelper.setActive(slot0._gonewrecord, slot1)
	end
end

return slot0
