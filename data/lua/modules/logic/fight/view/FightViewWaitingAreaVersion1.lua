module("modules.logic.fight.view.FightViewWaitingAreaVersion1", package.seeall)

slot0 = class("FightViewWaitingAreaVersion1", BaseViewExtended)
slot1 = 0
slot0.StartPosX = 0

function slot0.onInitView(slot0)
	slot0._waitingAreaTran = gohelper.findChild(slot0.viewGO, "root/waitingArea").transform
	slot0._waitingAreaGO = gohelper.findChild(slot0.viewGO, "root/waitingArea/inner")
	slot0._skillTipsGO = gohelper.findChild(slot0.viewGO, "root/waitingArea/inner/skill")
	slot0._txtCardTitle = gohelper.findChildText(slot0._skillTipsGO, "txtTips/txtTitle")
	slot0._txtCardDesc = gohelper.findChildText(slot0._skillTipsGO, "txtTips")
	slot0._cardItemList = {}
	slot0._cardItemGOList = slot0:getUserDataTb_()
	slot0._cardObjModel = gohelper.findChild(slot0._waitingAreaGO, "cardItemModel")
	uv0.StartPosX = recthelper.getAnchorX(slot0._cardObjModel.transform)

	slot0:_refreshTipsVisibleState()
end

function slot0._refreshTipsVisibleState(slot0)
	gohelper.onceAddComponent(slot0._skillTipsGO, gohelper.Type_CanvasGroup).alpha = GMFightShowState.playSkillDes and 1 or 0
end

function slot0.onOpen(slot0)
	slot0:_makeTipsOutofSight()
	slot0:addEventCb(FightController.instance, FightEvent.ShowSimulateClientUsedCard, slot0._onShowSimulateClientUsedCard, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.SetUseCards, slot0._onSetUseCards, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, slot0._onEndRound, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.BeforePlaySkill, slot0._beforePlaySkill, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, slot0._onBuffUpdate, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.ASFD_OnStart, slot0.onASFDStart, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.ASFD_OnDone, slot0.onASFDDone, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.InvalidUsedCard, slot0._onInvalidUsedCard, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.InvalidPreUsedCard, slot0._onInvalidPreUsedCard, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.FixWaitingAreaItemCount, slot0._fixWaitingAreaItemCount, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.GMHideFightView, slot0._refreshTipsVisibleState, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.ParallelPlayNextSkillDoneThis, slot0._onParallelPlayNextSkillDoneThis, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.ForceEndSkillStep, slot0._onForceEndSkillStep, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.PlayCardAroundUpRank, slot0._onPlayCardAroundUpRank, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.PlayCardAroundDownRank, slot0._onPlayCardAroundDownRank, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.PlayCardAroundSetGray, slot0._onPlayCardAroundSetGray, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.AddUseCard, slot0._onAddUseCard, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.PlayChangeRankFail, slot0._onPlayChangeRankFail, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.CardLevelChangeDone, slot0._onCardLevelChangeDone, slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	if slot0._addUseCardFlow then
		slot0._addUseCardFlow:stop()

		slot0._addUseCardFlow = nil
	end

	for slot4, slot5 in ipairs(slot0._cardItemList) do
		slot5:releaseEffectFlow()
	end

	slot0:_releaseScalseTween()

	if slot0.LYCard then
		slot0.LYCard:dispose()

		slot0.LYCard = nil
	end
end

function slot0._onAddUseCard(slot0, slot1)
	if FightPlayCardModel.instance:getUsedCards()[slot1] then
		slot3.CUSTOMADDUSECARD = true

		if not slot0._addUseCardFlow then
			slot0._addUseCardFlow = FlowSequence.New()

			slot0._addUseCardFlow:addWork(FightViewWorkAddUseCard)
		end

		slot0._addUseCardFlow:stop()
		slot0._addUseCardFlow:start(slot0)
	end
end

function slot0._onPlayChangeRankFail(slot0, slot1, slot2)
	if slot0._cardItemList[slot1] then
		slot3:playChangeRankFail(slot2)
	end
end

function slot0._fixWaitingAreaItemCount(slot0, slot1)
	for slot5 = 1, slot1 do
		recthelper.setAnchorX((gohelper.findChild(slot0._waitingAreaGO, "cardItem" .. slot5) or gohelper.cloneInPlace(slot0._cardObjModel, "cardItem" .. slot5)).transform, uv0.getCardPos(slot5, slot1))
	end
end

function slot0.getCardPos(slot0, slot1)
	slot2 = 0

	if FightDataHelper.LYDataMgr:hasCountBuff() then
		slot2 = 1
	end

	return uv0.StartPosX - 192 * (slot1 - (slot0 - slot2))
end

function slot0._onSetUseCards(slot0)
	slot1 = FightPlayCardModel.instance:getUsedCards()

	slot0:_fixWaitingAreaItemCount(#slot1)
	slot0:_updateView()

	for slot5, slot6 in ipairs(slot1) do
		slot6.custom_lock = FightViewHandCardItemLock.setCardLock(slot6.uid, slot6.skillId, gohelper.findChild(slot0._cardItemList[slot5].tr.parent.gameObject, "lock"), false)
	end
end

function slot0._onShowSimulateClientUsedCard(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(FightCardModel.instance:getPlayCardOpList()) do
		table.insert(slot1, slot6.cardInfoMO)
	end

	slot0:_fixWaitingAreaItemCount(#slot1)

	slot5 = 0

	slot0:_updateView(slot1, slot5)

	for slot5, slot6 in ipairs(slot1) do
		slot6.custom_lock = FightViewHandCardItemLock.setCardLock(slot6.uid, slot6.skillId, gohelper.findChild(slot0._cardItemList[slot5].tr.parent.gameObject, "lock"), false)
	end

	if slot0.LYCard then
		slot0.LYCard:resetState()
		slot0.LYCard:playAnim("in")
	end
end

function slot0._onEndRound(slot0)
	slot0:_makeTipsOutofSight()
end

function slot0._onInvalidUsedCard(slot0, slot1, slot2)
	if not slot0._cardItemList[slot1] then
		return
	end

	gohelper.setActive(gohelper.findChild(slot3.tr.parent.gameObject, "lock"), false)

	if slot2 == -1 then
		slot3:disappearCard()
	else
		slot3:dissolveCard()
	end
end

function slot0._onInvalidPreUsedCard(slot0, slot1)
	for slot5 = FightPlayCardModel.instance:getCurIndex() + 1, slot1 - 1 do
		slot0:_onInvalidUsedCard(slot5)
	end
end

function slot0._onParallelPlayNextSkillDoneThis(slot0, slot1)
	slot0:_onForceEndSkillStep(slot1)
end

function slot0._onForceEndSkillStep(slot0, slot1)
	if not FightHelper.isPlayerCardSkill(slot1) then
		return
	end

	if not slot0._cardItemList[slot1.cardIndex] then
		return
	end

	slot3:releaseEffectFlow()
	gohelper.setActive(slot3.go, false)
	slot0:_makeTipsOutofSight()
end

function slot0._beforePlaySkill(slot0, slot1, slot2, slot3)
	if not FightHelper.isPlayerCardSkill(slot3) then
		return
	end

	if slot3.cardIndex <= FightPlayCardModel.instance:getCurIndex() then
		return
	end

	FightPlayCardModel.instance:playCard(slot3.cardIndex)

	if FightModel.instance:getCurStage() == FightEnum.Stage.Play then
		slot4 = lua_skill.configDict[slot2]

		recthelper.setHeight(slot0._skillTipsGO.transform, GameUtil.getTextHeightByLine(slot0._txtCardDesc, FightConfig.instance:getEntitySkillDesc(slot1.id, slot4), 38) + 83)

		slot0._txtCardTitle.text = slot4 and slot4.name or ""
		slot0._txtCardDesc.text = slot4 and HeroSkillModel.instance:skillDesToSpot(slot5) or ""

		slot0:_displayFlow(slot1.id, slot2, FightPlayCardModel.instance:getCurIndex())
	end
end

function slot0._displayFlow(slot0, slot1, slot2, slot3)
	if not slot0._cardItemList[slot3] then
		return
	end

	for slot7 = 1, slot3 - 1 do
		slot0._cardItemList[slot7]:releaseEffectFlow()
		gohelper.setActive(slot0._cardItemList[slot7].go, false)
		gohelper.setActive(gohelper.findChild(slot0._cardItemList[slot7].tr.parent.gameObject, "lock"), false)
	end

	slot0._cardItemList[slot3]:playUsedCardDisplay(slot0._skillTipsGO)
end

function slot0._onSkillPlayFinish(slot0, slot1, slot2, slot3)
	if not FightHelper.isPlayerCardSkill(slot3) then
		return
	end

	if not slot0._cardItemList[slot3.cardIndex] then
		return
	end

	slot0._cardItemList[slot3.cardIndex]:playUsedCardFinish(slot0._skillTipsGO, slot0._waitingAreaGO)
end

function slot0.onASFDStart(slot0, slot1, slot2, slot3)
	if slot3.cardIndex <= FightPlayCardModel.instance:getCurIndex() then
		return
	end

	FightPlayCardModel.instance:playCard(slot3.cardIndex)

	if FightModel.instance:getCurStage() == FightEnum.Stage.Play then
		slot4 = lua_skill.configDict[slot2]

		recthelper.setHeight(slot0._skillTipsGO.transform, GameUtil.getTextHeightByLine(slot0._txtCardDesc, FightConfig.instance:getEntitySkillDesc(slot1.id, slot4), 38) + 83)

		slot0._txtCardTitle.text = slot4 and slot4.name or ""
		slot0._txtCardDesc.text = slot4 and HeroSkillModel.instance:skillDesToSpot(slot5) or ""

		slot0:_displayFlow(slot1.id, slot2, FightPlayCardModel.instance:getCurIndex())
	end
end

function slot0.onASFDDone(slot0, slot1)
	if not slot0._cardItemList[slot1] then
		return
	end

	slot0._cardItemList[slot1]:playUsedCardFinish(slot0._skillTipsGO, slot0._waitingAreaGO)
end

function slot0._onBuffUpdate(slot0, slot1, slot2, slot3)
	if not FightDataHelper.entityMgr:getById(slot1) or slot4.side ~= FightEnum.EntitySide.MySide then
		return
	end

	slot5 = FightPlayCardModel.instance:getUsedCards()
	slot6 = FightPlayCardModel.instance:getCurIndex()
	slot7 = false

	if FightConfig.instance:hasBuffFeature(slot3, FightEnum.BuffFeature.SkillLevelJudgeAdd) then
		slot7 = true
	end

	for slot11 = slot6 + 1, #slot5 do
		if slot0._cardItemList[slot11] then
			slot13 = slot5[slot11]

			if slot13.custom_lock ~= not FightViewHandCardItemLock.canUseCardSkill(slot13.uid, slot13.skillId) then
				slot13.custom_lock = slot15

				if slot15 then
					FightViewHandCardItemLock.setCardLock(slot13.uid, slot13.skillId, gohelper.findChild(slot12.tr.parent.gameObject, "lock"), false)
				else
					gohelper.setActive(slot16, false)
				end
			end

			if slot7 then
				slot12:detectShowBlueStar()
			end
		end
	end
end

function slot0._makeTipsOutofSight(slot0)
	recthelper.setAnchorX(slot0._skillTipsGO.transform, 9999999)
end

function slot0._updateView(slot0, slot1, slot2)
	slot4 = slot2 or FightPlayCardModel.instance:getCurIndex()

	gohelper.setActive(slot0._waitingAreaGO, #(slot1 or FightPlayCardModel.instance:getUsedCards()) > 0)

	for slot9 = 1, slot5 do
		slot10 = slot3[slot9]
		slot11 = slot10.uid
		slot12 = slot10.skillId

		if not slot0._cardItemList[slot9] then
			slot16 = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], gohelper.findChild(slot0._waitingAreaGO, "cardItem" .. slot9) or gohelper.cloneInPlace(slot0._cardObjModel, "cardItem" .. slot9), "card")

			gohelper.setAsFirstSibling(slot16)
			table.insert(slot0._cardItemList, MonoHelper.addNoUpdateLuaComOnceToGo(slot16, FightViewCardItem, FightEnum.CardShowType.PlayCard))
		end

		transformhelper.setLocalScale(slot13.tr, 1, 1, 1)
		recthelper.setAnchor(slot13.tr, 0, 0)

		gohelper.onceAddComponent(slot13.go, typeof(UnityEngine.CanvasGroup)).alpha = 1

		gohelper.setActive(slot13.go, true)

		slot10.custom_playedCard = true

		slot13:updateItem(slot11, slot12, slot10)
		slot13:detectShowBlueStar()
		slot0:refreshCardRedAndBlue(slot13, slot10)
		gohelper.setActive(slot13.go, slot4 < slot9)
	end

	for slot9 = slot5 + 1, #slot0._cardItemList do
		slot10 = slot0._cardItemList[slot9]

		gohelper.setActive(gohelper.findChild(slot10.tr.parent.gameObject, "lock"), false)
		gohelper.setActive(slot10.go, false)
	end

	slot0:playScaleTween(slot5)
	slot0:refreshLYCard(slot3)
end

function slot0.refreshCardRedAndBlue(slot0, slot1, slot2)
	slot3 = slot2 and slot2.areaRedOrBlue

	slot1:setActiveRed(slot3 == FightEnum.CardColor.Red)
	slot1:setActiveBlue(slot3 == FightEnum.CardColor.Blue)
	slot1:setActiveBoth(slot3 == FightEnum.CardColor.Both)
end

function slot0.refreshLYCard(slot0, slot1)
	if FightDataHelper.LYDataMgr:hasCountBuff() then
		slot0.LYCard = slot0.LYCard or FightLYWaitAreaCard.Create(slot0._waitingAreaGO)

		slot0.LYCard:setScale(FightEnum.LYCardWaitAreaScale)
	end

	if slot0.LYCard then
		slot0.LYCard:refreshLYCard()

		slot2 = slot1 and #slot1 or 0

		slot0.LYCard:setAnchorX(uv0.getCardPos(slot2 + 1, slot2))
	end
end

function slot0.playScaleTween(slot0, slot1)
	slot0:_releaseScalseTween()

	if (slot1 > 7 and 1 - (slot1 - 7) * 0.12 or 1) < 0 then
		slot2 = 0.5
	end

	slot3 = 1 / slot2

	transformhelper.setLocalScale(slot0._skillTipsGO.transform, slot3, slot3, slot3)

	slot0._tweenScale = ZProj.TweenHelper.DOScale(slot0._waitingAreaTran, slot2, slot2, slot2, 0.1)
end

function slot0._releaseScalseTween(slot0)
	if slot0._tweenScale then
		ZProj.TweenHelper.KillById(slot0._tweenScale)

		slot0._tweenScale = nil
	end
end

function slot0._onPlayCardAroundUpRank(slot0, slot1, slot2)
	if slot0._cardItemList[slot1] then
		gohelper.setActive(gohelper.findChild(slot3.tr.parent.gameObject, "lock"), false)
		slot3:playCardLevelChange(nil, slot2)
	end
end

function slot0._onPlayCardAroundDownRank(slot0, slot1, slot2)
	if slot0._cardItemList[slot1] then
		gohelper.setActive(gohelper.findChild(slot3.tr.parent.gameObject, "lock"), false)
		slot3:playCardLevelChange(nil, slot2)
	end
end

function slot0._onCardLevelChangeDone(slot0, slot1)
	if slot0._cardItemList then
		for slot5, slot6 in ipairs(slot0._cardItemList) do
			if slot6._cardInfoMO == slot1 and FightPlayCardModel.instance:getCurIndex() < slot5 then
				FightViewHandCardItemLock.setCardLock(slot1.uid, slot1.skillId, gohelper.findChild(slot6.tr.parent.gameObject, "lock"), false)

				break
			end
		end
	end
end

function slot0._onPlayCardAroundSetGray(slot0, slot1)
	if slot0._cardItemList[slot1] then
		slot2:playCardAroundSetGray()
	end
end

return slot0
