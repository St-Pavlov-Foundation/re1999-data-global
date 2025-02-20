module("modules.logic.fight.view.FightViewMgr", package.seeall)

slot0 = class("FightViewMgr", FightBaseView)

function slot0.onInitView(slot0)
	slot0._topLeft = gohelper.findChild(slot0.viewGO, "root/topLeftContent")
	slot0._topRightBtnRoot = gohelper.findChild(slot0.viewGO, "root/btns")
	slot0._fightSeasonChangeHero = gohelper.findChild(slot0.viewGO, "root/fightSeasonChangeHero")
	slot0._progressRoot = gohelper.findChild(slot0._topLeft, "#go_commonalityslider")

	gohelper.setActive(slot0._fightSeasonChangeHero, false)
	gohelper.setActive(slot0._progressRoot, false)
end

function slot0.addEvents(slot0)
	slot0:com_registFightEvent(FightEvent.BeforeEnterStepBehaviour, slot0._onBeforeEnterStepBehaviour)
	slot0:com_registMsg(FightMsgId.FightProgressValueChange, slot0._showFightProgress)
	slot0:com_registMsg(FightMsgId.FightMaxProgressValueChange, slot0._showFightProgress)
	slot0:com_registMsg(FightMsgId.ShowDouQuQuXianHouShou, slot0._onShowDouQuQuXianHouShou)
end

function slot0.removeEvents(slot0)
end

function slot0._onShowDouQuQuXianHouShou(slot0, slot1)
	slot0:com_openSubView(FightAct174StartFirstView, "ui/viewres/fight/fight_act174startfirstview.prefab", slot0.viewGO, slot1)
end

function slot0._onBeforeEnterStepBehaviour(slot0)
	if FightModel.instance:isSeason2() then
		gohelper.setActive(slot0._fightSeasonChangeHero, true)
		slot0:com_openSubView(FightSeasonChangeHeroView, slot0._fightSeasonChangeHero)
	end

	slot0:_showTopLeft()
end

function slot0._showTopLeft(slot0)
	slot0:_showFightProgress()
end

function slot0._showFightProgress(slot0)
	if FightDataHelper.fieldMgr.progressMax > 0 then
		if slot0._progressView then
			return
		end

		gohelper.setActive(slot0._progressRoot, true)

		slot0._progressView = slot0:com_openSubView(FightCommonalitySlider, "ui/viewres/fight/commonalityslider.prefab", slot0._progressRoot)
	end
end

function slot0.onOpen(slot0)
	slot0:_showCardDeckBtn()
end

function slot0._showCardDeckBtn(slot0)
	if FightDataHelper.fieldMgr:isDouQuQu() then
		return
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.CardDeck) then
		slot0:com_loadAsset("ui/viewres/fight/fightcarddeckbtnview.prefab", slot0._onBtnLoaded)
	end
end

function slot0._onBtnLoaded(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	slot4 = gohelper.clone(slot2:GetResource(), slot0._topRightBtnRoot, "cardBox")

	slot0:com_registClick(gohelper.getClickWithDefaultAudio(slot4), slot0._onCardBoxClick, slot0)
	gohelper.setAsFirstSibling(slot4)

	slot0._deckCardAnimator = gohelper.onceAddComponent(slot4, typeof(UnityEngine.Animator))
	slot0._deckBtnAniPlayer = SLFramework.AnimatorPlayer.Get(slot4)

	slot0:com_registFightEvent(FightEvent.CardDeckGenerate, slot0._onCardDeckGenerate)
	slot0:com_registFightEvent(FightEvent.CardDeckDelete, slot0._onCardDeckDelete)
end

function slot0._onCardBoxClick(slot0)
	if not FightDataHelper.stageMgr:isFree() then
		return
	end

	ViewMgr.instance:openView(ViewName.FightCardDeckView, {
		selectType = FightCardDeckView.SelectType.CardBox
	})
end

function slot0._deckAniFinish(slot0)
	slot0._deckCardAnimator.enabled = true

	slot0._deckCardAnimator:Play("idle")
end

function slot0._onCardDeckGenerate(slot0)
	slot0._deckBtnAniPlayer:Play("add", slot0._deckAniFinish, slot0)
end

function slot0._onCardDeckDelete(slot0)
	slot0._deckBtnAniPlayer:Play("delete", slot0._deckAniFinish, slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
