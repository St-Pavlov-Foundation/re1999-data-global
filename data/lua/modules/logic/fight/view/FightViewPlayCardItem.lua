module("modules.logic.fight.view.FightViewPlayCardItem", package.seeall)

slot0 = class("FightViewPlayCardItem", LuaCompBase)
slot1 = 0.76

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.tr = slot1.transform
	slot0._emtpyGO = gohelper.findChild(slot1, "imgEmpty")
	slot0._emptyNormal = gohelper.findChild(slot1, "imgEmpty/emptyNormal")
	slot0._moveGO = gohelper.findChild(slot1, "imgMove")
	slot0._moveAnimComp = slot0._moveGO:GetComponent(typeof(UnityEngine.Animation))
	slot0._lockGO = gohelper.findChild(slot1, "lock")
	slot2 = ViewMgr.instance:getContainer(ViewName.FightView)
	slot0._innerGO = slot2:getResInst(slot2:getSetting().otherRes[1], slot0.go, "card")

	transformhelper.setLocalScale(slot0._innerGO.transform, uv0, uv0, uv0)
	gohelper.setSiblingBefore(slot0._innerGO, slot0._lockGO)

	slot0._click = SLFramework.UGUI.UIClickListener.Get(slot0.go)
	slot0._goEffect1 = gohelper.create2d(slot0.go, "effect1")
	slot0._goEffect2 = gohelper.create2d(slot0.go, "effect2")
	slot0._goEffect3 = gohelper.create2d(slot0.go, "effect3")

	gohelper.setSiblingBefore(slot0._goEffect1, slot0._innerGO)
	gohelper.setSiblingAfter(slot0._goEffect2, slot0._innerGO)
	gohelper.setSiblingAfter(slot0._goEffect3, slot0._innerGO)
	transformhelper.setLocalScale(slot0._goEffect1.transform, uv0, uv0, uv0)
	transformhelper.setLocalScale(slot0._goEffect2.transform, uv0, uv0, uv0)
	transformhelper.setLocalScale(slot0._goEffect3.transform, uv0, uv0, uv0)
	gohelper.setActive(slot0._goEffect1, false)
	gohelper.setActive(slot0._goEffect2, false)
	gohelper.setActive(slot0._goEffect3, false)

	slot0._effectLoader1 = nil
	slot0._effectLoader2 = nil
	slot0._effectLoader3 = nil
	slot0._conversionGO = gohelper.findChild(slot1, "conversion")
	slot0.rankChangeRoot = gohelper.findChild(slot1, "#go_Grade")
	slot0._seasonRoot = gohelper.findChild(slot1, "imgEmpty/SeasonRoot")
	slot0._seasonEmpty1 = gohelper.findChild(slot1, "imgEmpty/SeasonRoot/imgEmpty1")
	slot0._seasonEmpty2 = gohelper.findChild(slot1, "imgEmpty/SeasonRoot/imgEmpty2")
	slot0._seasonCurActIndex = gohelper.findChild(slot1, "imgEmpty/SeasonRoot/#go_Selected")
	slot0._seasonCurActArrow = gohelper.findChild(slot1, "imgEmpty/SeasonRoot/image_SelectedArrow")
	slot4 = FightModel.instance:isSeason2()

	gohelper.setActive(slot0._seasonRoot, slot4)
	gohelper.setActive(slot0._emptyNormal, not slot4)

	slot0.goASFD = gohelper.findChild(slot1, "asfd_icon")
	slot0.asfdAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(slot0.goASFD)
	slot0.txtASFDEnergy = gohelper.findChildText(slot1, "asfd_icon/#txt_Num")

	gohelper.setSiblingAfter(slot0.goASFD, slot0._innerGO)
end

function slot0.refreshSeasonArrowShow(slot0, slot1)
	gohelper.setActive(slot0._seasonEmpty1, slot1)
	gohelper.setActive(slot0._seasonEmpty2, not slot1)
	gohelper.setActive(slot0._seasonCurActIndex, slot1)
	gohelper.setActive(slot0._seasonCurActArrow, slot1)
end

function slot0.addEventListeners(slot0)
	slot0._click:AddClickListener(slot0._onClickThis, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._click:RemoveClickListener()
	TaskDispatcher.cancelTask(slot0._delayHideEffect, slot0)
	TaskDispatcher.cancelTask(slot0._delayDisableMoveAnim, slot0)
end

function slot0.onDestroy(slot0)
	if slot0._effectLoader1 then
		slot0._effectLoader1:dispose()

		slot0._effectLoader1 = nil
	end

	if slot0._effectLoader2 then
		slot0._effectLoader2:dispose()

		slot0._effectLoader2 = nil
	end

	if slot0._effectLoader3 then
		slot0._effectLoader3:dispose()

		slot0._effectLoader3 = nil
	end

	slot0._tailEffectGO = nil
end

function slot0.updateItem(slot0, slot1)
	slot0.fightBeginRoundOp = slot1
	slot2 = slot1
	slot4 = slot2 and (slot2:isMoveCard() or slot2:isMoveUniversal())
	slot5 = slot2 and (slot2:isPlayCard() or slot2:isAssistBossPlayCard() or slot2:isPlayerFinisherSkill())

	gohelper.setActive(slot0._emtpyGO, not slot2)
	gohelper.setActive(slot0._moveGO, slot4)
	TaskDispatcher.cancelTask(slot0._delayDisableMoveAnim, slot0)

	if slot4 then
		slot0._moveAnimComp.enabled = true

		TaskDispatcher.runDelay(slot0._delayDisableMoveAnim, slot0, 1)
	end

	gohelper.setActive(slot0._innerGO, slot5)

	if slot5 then
		if not slot0._cardItem then
			slot0._cardItem = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._innerGO, FightViewCardItem, FightEnum.CardShowType.Operation)
		end

		slot0._cardItem:updateItem(slot2.belongToEntityId, slot2.skillId)

		slot7 = FightBuffHelper.simulateBuffList(FightDataHelper.entityMgr:getById(slot2.belongToEntityId), slot2)

		FightViewHandCardItemLock.setCardLock(slot2 and slot2.belongToEntityId, slot2 and slot2.skillId, slot0._lockGO, false, slot7)
		slot0:_setCardPreRemove(slot2, slot7)
		slot0._cardItem:detectShowBlueStar()
		slot0._cardItem:updateResistanceByBeginRoundOp(slot1)

		if slot2:isPlayerFinisherSkill() then
			gohelper.setActive(slot0._lockGO, false)
		end
	else
		gohelper.setActive(slot0._lockGO, false)
	end

	if slot0.fightBeginRoundOp then
		if slot0.PARENTVIEW and slot0.PARENTVIEW.refreshRankUpDown then
			slot0.PARENTVIEW:refreshRankUpDown()
		end
	else
		gohelper.setActive(slot0.rankChangeRoot, false)
	end

	slot0:refreshASFDEnergy()
	slot0:refreshRedAndBlueArea()
end

function slot0.refreshRedAndBlueArea(slot0)
	if not slot0._cardItem then
		return
	end

	slot1 = slot0.fightBeginRoundOp and slot0.fightBeginRoundOp.cardColor

	slot0._cardItem:setActiveRed(slot1 == FightEnum.CardColor.Both or slot1 == FightEnum.CardColor.Red)
	slot0._cardItem:setActiveBlue(slot1 == FightEnum.CardColor.Both or slot1 == FightEnum.CardColor.Blue)
end

function slot0.refreshASFDEnergy(slot0)
	slot1 = slot0.fightBeginRoundOp and slot0.fightBeginRoundOp.cardInfoMO
	slot2 = slot1 and slot1.energy
	slot3 = slot2 and slot2 > 0

	gohelper.setActive(slot0.goASFD, slot3)

	if slot3 then
		slot0.txtASFDEnergy.text = slot2

		if slot0.goASFD.activeSelf then
			slot0.asfdAnimatorPlayer:Play("open", slot0.resetToASFDIdle, slot0)
		end
	end
end

function slot0.resetToASFDIdle(slot0)
	slot0.asfdAnimatorPlayer:Play("idle")
end

function slot0.playASFDCloseAnim(slot0)
	slot0.asfdAnimatorPlayer:Play("close", slot0.hideASFD, slot0)
end

function slot0.hideASFD(slot0)
	gohelper.setActive(slot0.goASFD, false)
end

function slot0.setCopyCard(slot0)
	slot0._isCopyCard = true
end

function slot0.isCopyCard(slot0)
	return slot0._isCopyCard
end

slot2 = Color.New(1, 1, 1, 0.5)

function slot0._setCardPreRemove(slot0, slot1, slot2)
	if slot1 == nil then
		return
	end

	if FightViewHandCardItemLock.canUseCardSkill(slot1.belongToEntityId, slot1.skillId, slot2) then
		return
	end

	if FightViewHandCardItemLock.canPreRemove(slot1.belongToEntityId, slot1.skillId, slot1, slot2) then
		FightViewHandCardItemLock.setCardPreRemove(slot1.belongToEntityId, slot1.skillId, slot0._lockGO, false)
	end
end

function slot0.showPlayCardEffect(slot0, slot1, slot2)
	gohelper.setActive(slot0._emtpyGO, false)
end

function slot0._delayHideEffect(slot0)
	gohelper.setActive(slot0._goEffect1, false)
	gohelper.setActive(slot0._goEffect2, false)
	gohelper.setActive(slot0._goEffect3, false)
	gohelper.destroy(slot0._tailEffectGO)

	slot0._tailEffectGO = nil
end

function slot0.hideExtMoveEffect(slot0)
	gohelper.setActive(slot0._conversionGO, false)
end

function slot0.showExtMoveEffect(slot0)
	gohelper.setActive(slot0._conversionGO, true)
end

function slot0.showExtMoveEndEffect(slot0)
	gohelper.setActive(slot0._conversionGO, false)
end

function slot0._delayDisableMoveAnim(slot0)
	slot0._moveAnimComp.enabled = false
end

slot3 = {}

function slot0._onClickThis(slot0)
	if FightViewHandCard.blockOperate or FightModel.instance:isAuto() then
		return
	end

	if FightReplayModel.instance:isReplay() then
		return
	end

	if FightCardModel.instance:isCardOpEnd() then
		return
	end

	if FightDataHelper.stageMgr:getCurOperateState() == FightStageMgr.OperateStateType.Discard then
		FightDataHelper.stageMgr:exitOperateState(FightStageMgr.OperateStateType.Discard)
	end

	if not FightDataHelper.stageMgr:isFree(uv0) then
		return
	end

	FightRpc.instance:sendResetRoundRequest()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_FightResetCard)
	FightAudioMgr.instance:stopAllCardAudio()
end

return slot0
