module("modules.logic.fight.view.FightViewPartVisible", package.seeall)

slot0 = class("FightViewPartVisible", BaseView)
slot1 = false
slot2 = false
slot3 = false
slot4 = false
slot5 = false

function slot0.set(slot0, slot1, slot2, slot3, slot4)
	uv0 = slot0
	uv1 = slot1
	uv2 = slot2
	uv3 = slot3
	uv4 = slot4

	FightController.instance:dispatchEvent(FightEvent.UpdateUIPartVisible)
end

function slot0.setPlayStatus(slot0, slot1)
	uv0 = slot0

	if FightModel.instance:getVersion() >= 1 then
		return
	end

	uv1 = slot1
end

function slot0.setWaitingStatus(slot0)
	uv0 = slot0
end

function slot0.onInitView(slot0)
	slot0._clothSkillGO = gohelper.findChild(slot0.viewGO, "root/heroSkill")
	slot0._handCardGO = gohelper.findChild(slot0.viewGO, "root/handcards")
	slot0._handCardInnerGO = gohelper.findChild(slot0.viewGO, "root/handcards/handcards")
	slot0._playCardGO = gohelper.findChild(slot0.viewGO, "root/playcards")
	slot0._enemyRoundGO = gohelper.findChild(slot0.viewGO, "root/enemyRound")
	slot0._enemyRoundTextGO = gohelper.findChild(slot0.viewGO, "root/enemyRoundText")
	slot0._waitingAreaGO = gohelper.findChild(slot0.viewGO, "root/waitingArea")
	slot0._rogueSkillRoot = gohelper.findChild(slot0.viewGO, "root/rogueSkillRoot")
	uv0 = false
	uv1 = false
	uv2 = false
	uv3 = false
	uv4 = false
	slot0._play_card_origin_x, slot0._play_card_origin_y = recthelper.getAnchor(slot0._playCardGO.transform)
end

function slot0.addEvents(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.UpdateUIPartVisible, slot0._updateUI, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnCameraFocusChanged, slot0.onCameraFocusChanged, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnUniversalAppear, slot0._tweenHandCardContainerScale, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnPlayHandCard, slot0._onPlayHandCard, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnResetCard, slot0._tweenHandCardContainerScale, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnClothSkillExpand, slot0._onClothSkillExpand, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnClothSkillShrink, slot0._onClothSkillShrink, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnCombineOneCard, slot0._onCombineOneCard, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnStartSequenceFinish, slot0._onClothSkillShrink, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, slot0._onClothSkillShrink, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.SetPlayCardPartOutScreen, slot0._onSetPlayCardPartOutScreen, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.SetPlayCardPartOriginPos, slot0._onSetPlayCardPartOriginPos, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.GMHideFightView, slot0._updateUI, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.SetHandCardVisible, slot0._onSetHandCardVisible, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.CancelVisibleViewScaleTween, slot0._onCancelVisibleViewScaleTween, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.UpdateUIPartVisible, slot0._updateUI, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnCameraFocusChanged, slot0.onCameraFocusChanged, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnUniversalAppear, slot0._tweenHandCardContainerScale, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnPlayHandCard, slot0._onPlayHandCard, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnResetCard, slot0._tweenHandCardContainerScale, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnClothSkillExpand, slot0._onClothSkillExpand, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnClothSkillShrink, slot0._onClothSkillShrink, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnCombineOneCard, slot0._onCombineOneCard, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnStartSequenceFinish, slot0._onClothSkillShrink, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, slot0._onClothSkillShrink, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.SetPlayCardPartOutScreen, slot0._onSetPlayCardPartOutScreen, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.SetPlayCardPartOriginPos, slot0._onSetPlayCardPartOriginPos, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.GMHideFightView, slot0._updateUI, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.SetHandCardVisible, slot0._onSetHandCardVisible, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.CancelVisibleViewScaleTween, slot0._onCancelVisibleViewScaleTween, slot0)
end

function slot0.onOpen(slot0)
	slot0:_updateUI()

	slot0._clothSkillExpand = false

	slot0:_tweenHandCardContainerScale()
end

function slot0._onClothSkillExpand(slot0)
	slot0._clothSkillExpand = true

	slot0:_tweenHandCardContainerScale()
end

function slot0._onClothSkillShrink(slot0)
	slot0._clothSkillExpand = false

	slot0:_tweenHandCardContainerScale()
end

function slot0._onCombineOneCard(slot0)
	if FightModel.instance:getCurStage() == FightEnum.Stage.Card or FightModel.instance:getCurStage() == FightEnum.Stage.AutoCard then
		slot0:_onClothSkillShrink()
	end
end

function slot0._onPlayHandCard(slot0, slot1, slot2)
	if slot2 then
		return
	end

	slot0:_tweenHandCardContainerScale()
end

function slot0._tweenHandCardContainerScale(slot0)
	slot2 = FightCardModel.instance:getHandCardContainerScale(slot0._clothSkillExpand)
	slot0._scaleTweenId = ZProj.TweenHelper.DOScale(slot0._handCardGO.transform, slot2, slot2, slot2, FightWorkEffectDistributeCard.getHandCardScaleTime())
end

function slot0._onCancelVisibleViewScaleTween(slot0)
	if slot0._scaleTweenId then
		ZProj.TweenHelper.KillById(slot0._scaleTweenId)

		slot0._scaleTweenId = nil
	end
end

function slot0._updateUI(slot0)
	if not (slot0._playCardGO.activeInHierarchy and gohelper.onceAddComponent(slot0._playCardGO, typeof(UnityEngine.CanvasGroup)).alpha > 0.9) and uv0 then
		if GMFightShowState.cards then
			ZProj.TweenHelper.KillByObj(slot1)
			ZProj.TweenHelper.DOFadeCanvasGroup(slot0._playCardGO, 0, 1, 0.165)
		end
	elseif slot2 and not uv0 then
		ZProj.TweenHelper.KillByObj(slot1)
		ZProj.TweenHelper.DOFadeCanvasGroup(slot0._playCardGO, 1, 0, 0.165)
	end

	slot3 = PlayerClothModel.instance:getSpEpisodeClothID() or OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.LeadRoleSkill) and FightModel.instance.clothId > 0

	gohelper.setActive(slot0._clothSkillGO, uv1 and slot3 and GMFightShowState.clothSkill)

	if uv1 and slot3 and GMFightShowState.clothSkill then
		FightController.instance:dispatchEvent(FightEvent.OnGuideShowRougeSkill)
	end

	gohelper.setActive(slot0._rogueSkillRoot, slot4)
	gohelper.setActive(slot0._handCardGO, uv2)
	gohelper.setActive(slot0._playCardGO, uv0)
	gohelper.setActive(slot0._enemyRoundGO, uv3 and GMFightShowState.bottomEnemyRound)
	gohelper.setActive(slot0._enemyRoundTextGO, uv3 and GMFightShowState.bottomEnemyRound)
	gohelper.setActive(slot0._waitingAreaGO, uv4 and GMFightShowState.cards)
	slot0:setActiveCanvasGroup(slot0._handCardInnerGO, GMFightShowState.cards)
	slot0:setActiveCanvasGroup(slot0._playCardGO, GMFightShowState.cards)
	slot0:setActiveCanvasGroup(slot0._waitingAreaGO, GMFightShowState.cards)
end

function slot0.setActiveCanvasGroup(slot0, slot1, slot2)
	gohelper.onceAddComponent(slot1, gohelper.Type_CanvasGroup).alpha = slot2 and 1 or 0
end

function slot0.onCameraFocusChanged(slot0, slot1)
	if FightModel.instance:getCurStage() == FightEnum.Stage.Card or FightModel.instance:getCurStage() == FightEnum.Stage.ClothSkill then
		slot0:setActiveCanvasGroup(slot0._playCardGO, not slot1)
		gohelper.setActive(slot0._handCardGO, not slot1)
		gohelper.setActiveCanvasGroup(FightNameMgr.instance:getNameParent(), not slot1)
	end
end

function slot0._onSetPlayCardPartOutScreen(slot0)
	recthelper.setAnchor(slot0._playCardGO.transform, 10000, 10000)
end

function slot0._onSetPlayCardPartOriginPos(slot0)
	recthelper.setAnchor(slot0._playCardGO.transform, slot0._play_card_origin_x, slot0._play_card_origin_y)
end

function slot0._onSetHandCardVisible(slot0, slot1, slot2)
	if slot2 then
		gohelper.setActive(slot0._waitingAreaGO, uv0)
		gohelper.setActive(slot0._handCardGO, uv1)
	else
		gohelper.setActive(slot0._waitingAreaGO, false)
		gohelper.setActive(slot0._handCardGO, slot1)
	end
end

return slot0
