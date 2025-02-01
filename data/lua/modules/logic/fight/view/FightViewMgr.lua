slot0 = class("FightViewMgr", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._topRightBtnRoot = gohelper.findChild(slot0.viewGO, "root/btns")
	slot0._fightSeasonChangeHero = gohelper.findChild(slot0.viewGO, "root/fightSeasonChangeHero")

	gohelper.setActive(slot0._fightSeasonChangeHero, false)
end

function slot0.addEvents(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.BeforeEnterStepBehaviour, slot0._onBeforeEnterStepBehaviour, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._onBeforeEnterStepBehaviour(slot0)
	if FightModel.instance:isSeason2() then
		gohelper.setActive(slot0._fightSeasonChangeHero, true)
		slot0:openSubView(FightSeasonChangeHeroView, slot0._fightSeasonChangeHero)
	end
end

function slot0.onOpen(slot0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.CardDeck) then
		slot0:com_loadAsset("ui/viewres/fight/fightcarddeckbtnview.prefab", slot0._onBtnLoaded)
	end
end

function slot0._onBtnLoaded(slot0, slot1)
	slot3 = gohelper.clone(slot1:GetResource(), slot0._topRightBtnRoot, "cardBox")

	slot0:addClickCb(gohelper.getClickWithDefaultAudio(slot3), slot0._onCardBoxClick, slot0)
	gohelper.setAsFirstSibling(slot3)

	slot0._deckCardAnimator = gohelper.onceAddComponent(slot3, typeof(UnityEngine.Animator))
	slot0._deckBtnAniPlayer = SLFramework.AnimatorPlayer.Get(slot3)

	slot0:addEventCb(FightController.instance, FightEvent.CardDeckGenerate, slot0._onCardDeckGenerate, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.CardDeckDelete, slot0._onCardDeckDelete, slot0)
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
