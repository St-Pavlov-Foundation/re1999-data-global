module("modules.logic.fight.view.FightViewWaitingAreaVersion1", package.seeall)

local var_0_0 = class("FightViewWaitingAreaVersion1", BaseViewExtended)
local var_0_1 = 0

var_0_0.StartPosX = 0

function var_0_0.onInitView(arg_1_0)
	arg_1_0._waitingAreaTran = gohelper.findChild(arg_1_0.viewGO, "root/waitingArea").transform
	arg_1_0._waitingAreaGO = gohelper.findChild(arg_1_0.viewGO, "root/waitingArea/inner")
	arg_1_0._skillTipsGO = gohelper.findChild(arg_1_0.viewGO, "root/waitingArea/inner/skill")
	arg_1_0._txtCardTitle = gohelper.findChildText(arg_1_0._skillTipsGO, "txtTips/txtTitle")
	arg_1_0._txtCardDesc = gohelper.findChildText(arg_1_0._skillTipsGO, "txtTips")
	arg_1_0._cardItemList = {}
	arg_1_0._cardItemGOList = arg_1_0:getUserDataTb_()
	arg_1_0._cardObjModel = gohelper.findChild(arg_1_0._waitingAreaGO, "cardItemModel")
	var_0_0.StartPosX = recthelper.getAnchorX(arg_1_0._cardObjModel.transform)

	arg_1_0:_refreshTipsVisibleState()
end

function var_0_0._refreshTipsVisibleState(arg_2_0)
	gohelper.onceAddComponent(arg_2_0._skillTipsGO, gohelper.Type_CanvasGroup).alpha = GMFightShowState.playSkillDes and 1 or 0
end

function var_0_0.onOpen(arg_3_0)
	arg_3_0:_makeTipsOutofSight()
	arg_3_0:addEventCb(FightController.instance, FightEvent.ShowSimulateClientUsedCard, arg_3_0._onShowSimulateClientUsedCard, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.SetUseCards, arg_3_0._onSetUseCards, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, arg_3_0._onEndRound, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.BeforePlaySkill, arg_3_0._beforePlaySkill, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, arg_3_0._onSkillPlayFinish, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, arg_3_0._onBuffUpdate, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.ASFD_OnStart, arg_3_0.onASFDStart, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.ASFD_OnDone, arg_3_0.onASFDDone, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.InvalidUsedCard, arg_3_0._onInvalidUsedCard, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.InvalidPreUsedCard, arg_3_0._onInvalidPreUsedCard, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.FixWaitingAreaItemCount, arg_3_0._fixWaitingAreaItemCount, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.GMHideFightView, arg_3_0._refreshTipsVisibleState, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.ParallelPlayNextSkillDoneThis, arg_3_0._onParallelPlayNextSkillDoneThis, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.ForceEndSkillStep, arg_3_0._onForceEndSkillStep, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.PlayCardAroundUpRank, arg_3_0._onPlayCardAroundUpRank, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.PlayCardAroundDownRank, arg_3_0._onPlayCardAroundDownRank, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.PlayCardAroundSetGray, arg_3_0._onPlayCardAroundSetGray, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.AddUseCard, arg_3_0._onAddUseCard, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.PlayChangeRankFail, arg_3_0._onPlayChangeRankFail, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.CardLevelChangeDone, arg_3_0._onCardLevelChangeDone, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.ALF_AddCardEffectAppear, arg_3_0._onAlfAddCardEffectAppear, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.ALF_AddCardEffectEnd, arg_3_0._onAlfAddCardEffectEnd, arg_3_0)
end

function var_0_0._onAlfAddCardEffectAppear(arg_4_0)
	arg_4_0:updateCardLockObj()
end

function var_0_0._onAlfAddCardEffectEnd(arg_5_0)
	arg_5_0:updateCardLockObj()
end

function var_0_0.onClose(arg_6_0)
	return
end

function var_0_0.onDestroyView(arg_7_0)
	if arg_7_0._addUseCardFlow then
		arg_7_0._addUseCardFlow:stop()

		arg_7_0._addUseCardFlow = nil
	end

	for iter_7_0, iter_7_1 in ipairs(arg_7_0._cardItemList) do
		iter_7_1:releaseEffectFlow()
	end

	arg_7_0:_releaseScalseTween()

	if arg_7_0.LYCard then
		arg_7_0.LYCard:dispose()

		arg_7_0.LYCard = nil
	end
end

function var_0_0._onAddUseCard(arg_8_0, arg_8_1)
	local var_8_0 = FightPlayCardModel.instance:getUsedCards()
	local var_8_1 = false

	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		local var_8_2 = var_8_0[iter_8_1]

		if var_8_2 then
			var_8_2.CUSTOMADDUSECARD = true
			var_8_1 = true
		end
	end

	if var_8_1 then
		if not arg_8_0._addUseCardFlow then
			arg_8_0._addUseCardFlow = FlowSequence.New()

			arg_8_0._addUseCardFlow:addWork(FightViewWorkAddUseCard)
		end

		arg_8_0._addUseCardFlow:stop()
		arg_8_0._addUseCardFlow:start(arg_8_0)
	end
end

function var_0_0._onPlayChangeRankFail(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0._cardItemList[arg_9_1]

	if var_9_0 then
		var_9_0:playChangeRankFail(arg_9_2)
	end
end

function var_0_0._fixWaitingAreaItemCount(arg_10_0, arg_10_1)
	for iter_10_0 = 1, arg_10_1 do
		local var_10_0 = gohelper.findChild(arg_10_0._waitingAreaGO, "cardItem" .. iter_10_0) or gohelper.cloneInPlace(arg_10_0._cardObjModel, "cardItem" .. iter_10_0)

		recthelper.setAnchorX(var_10_0.transform, var_0_0.getCardPos(iter_10_0, arg_10_1))
	end
end

function var_0_0.getCardPos(arg_11_0, arg_11_1)
	local var_11_0 = 0

	if FightDataHelper.LYDataMgr:hasCountBuff() then
		var_11_0 = 1
	end

	arg_11_0 = arg_11_0 - var_11_0

	return var_0_0.StartPosX - 192 * (arg_11_1 - arg_11_0)
end

function var_0_0._onSetUseCards(arg_12_0)
	local var_12_0 = FightPlayCardModel.instance:getUsedCards()

	arg_12_0:_fixWaitingAreaItemCount(#var_12_0)
	arg_12_0:_updateView()
	arg_12_0:updateCardLockObj()
end

function var_0_0.updateCardLockObj(arg_13_0)
	local var_13_0 = FightPlayCardModel.instance:getUsedCards()

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		local var_13_1 = gohelper.findChild(arg_13_0._cardItemList[iter_13_0].tr.parent.gameObject, "lock")

		iter_13_1.clientData.custom_lock = FightViewHandCardItemLock.setCardLock(iter_13_1.uid, iter_13_1.skillId, var_13_1, false)
	end
end

function var_0_0._onShowSimulateClientUsedCard(arg_14_0)
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in ipairs(FightDataHelper.operationDataMgr:getPlayCardOpList()) do
		table.insert(var_14_0, iter_14_1.cardInfoMO)
	end

	arg_14_0:_fixWaitingAreaItemCount(#var_14_0)
	arg_14_0:_updateView(var_14_0, 0)

	for iter_14_2, iter_14_3 in ipairs(var_14_0) do
		local var_14_1 = gohelper.findChild(arg_14_0._cardItemList[iter_14_2].tr.parent.gameObject, "lock")

		iter_14_3.clientData.custom_lock = FightViewHandCardItemLock.setCardLock(iter_14_3.uid, iter_14_3.skillId, var_14_1, false)
	end

	if arg_14_0.LYCard then
		arg_14_0.LYCard:resetState()
		arg_14_0.LYCard:playAnim("in")
	end
end

function var_0_0._onEndRound(arg_15_0)
	arg_15_0:_makeTipsOutofSight()
end

function var_0_0._onInvalidUsedCard(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0._cardItemList[arg_16_1]

	if not var_16_0 then
		return
	end

	local var_16_1 = gohelper.findChild(var_16_0.tr.parent.gameObject, "lock")

	gohelper.setActive(var_16_1, false)

	if arg_16_2 == -1 then
		var_16_0:disappearCard()
	else
		var_16_0:dissolveCard()
	end
end

function var_0_0._onInvalidPreUsedCard(arg_17_0, arg_17_1)
	for iter_17_0 = FightPlayCardModel.instance:getCurIndex() + 1, arg_17_1 - 1 do
		arg_17_0:_onInvalidUsedCard(iter_17_0)
	end
end

function var_0_0._onParallelPlayNextSkillDoneThis(arg_18_0, arg_18_1)
	arg_18_0:_onForceEndSkillStep(arg_18_1)
end

function var_0_0._onForceEndSkillStep(arg_19_0, arg_19_1)
	if not FightHelper.isPlayerCardSkill(arg_19_1) then
		return
	end

	local var_19_0 = arg_19_1.cardIndex
	local var_19_1 = arg_19_0._cardItemList[var_19_0]

	if not var_19_1 then
		return
	end

	var_19_1:releaseEffectFlow()
	gohelper.setActive(var_19_1.go, false)
	arg_19_0:_makeTipsOutofSight()
end

function var_0_0._beforePlaySkill(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if not FightHelper.isPlayerCardSkill(arg_20_3) then
		return
	end

	if arg_20_3.cardIndex <= FightPlayCardModel.instance:getCurIndex() then
		return
	end

	FightPlayCardModel.instance:playCard(arg_20_3.cardIndex)

	if FightModel.instance:getCurStage() == FightEnum.Stage.Play then
		local var_20_0 = lua_skill.configDict[arg_20_2]
		local var_20_1 = FightConfig.instance:getEntitySkillDesc(arg_20_1.id, var_20_0)
		local var_20_2 = GameUtil.getTextHeightByLine(arg_20_0._txtCardDesc, var_20_1, 38) + 83

		recthelper.setHeight(arg_20_0._skillTipsGO.transform, var_20_2)

		arg_20_0._txtCardTitle.text = var_20_0 and var_20_0.name or ""
		arg_20_0._txtCardDesc.text = var_20_0 and HeroSkillModel.instance:skillDesToSpot(var_20_1) or ""

		arg_20_0:_displayFlow(arg_20_1.id, arg_20_2, FightPlayCardModel.instance:getCurIndex())
	end
end

function var_0_0._displayFlow(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	if not arg_21_0._cardItemList[arg_21_3] then
		return
	end

	for iter_21_0 = 1, arg_21_3 - 1 do
		arg_21_0._cardItemList[iter_21_0]:releaseEffectFlow()
		gohelper.setActive(arg_21_0._cardItemList[iter_21_0].go, false)

		local var_21_0 = gohelper.findChild(arg_21_0._cardItemList[iter_21_0].tr.parent.gameObject, "lock")

		gohelper.setActive(var_21_0, false)
	end

	arg_21_0._cardItemList[arg_21_3]:playUsedCardDisplay(arg_21_0._skillTipsGO)
end

function var_0_0._onSkillPlayFinish(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	if not FightHelper.isPlayerCardSkill(arg_22_3) then
		return
	end

	if not arg_22_0._cardItemList[arg_22_3.cardIndex] then
		return
	end

	arg_22_0._cardItemList[arg_22_3.cardIndex]:playUsedCardFinish(arg_22_0._skillTipsGO, arg_22_0._waitingAreaGO)
end

function var_0_0.onASFDStart(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	if arg_23_3.cardIndex <= FightPlayCardModel.instance:getCurIndex() then
		return
	end

	FightPlayCardModel.instance:playCard(arg_23_3.cardIndex)

	if FightModel.instance:getCurStage() == FightEnum.Stage.Play then
		local var_23_0 = lua_skill.configDict[arg_23_2]
		local var_23_1 = FightConfig.instance:getEntitySkillDesc(arg_23_1.id, var_23_0)
		local var_23_2 = GameUtil.getTextHeightByLine(arg_23_0._txtCardDesc, var_23_1, 38) + 83

		recthelper.setHeight(arg_23_0._skillTipsGO.transform, var_23_2)

		arg_23_0._txtCardTitle.text = var_23_0 and var_23_0.name or ""
		arg_23_0._txtCardDesc.text = var_23_0 and HeroSkillModel.instance:skillDesToSpot(var_23_1) or ""

		arg_23_0:_displayFlow(arg_23_1.id, arg_23_2, FightPlayCardModel.instance:getCurIndex())
	end
end

function var_0_0.onASFDDone(arg_24_0, arg_24_1)
	if not arg_24_0._cardItemList[arg_24_1] then
		return
	end

	arg_24_0._cardItemList[arg_24_1]:playUsedCardFinish(arg_24_0._skillTipsGO, arg_24_0._waitingAreaGO)
end

function var_0_0._onBuffUpdate(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = FightDataHelper.entityMgr:getById(arg_25_1)

	if not var_25_0 or var_25_0.side ~= FightEnum.EntitySide.MySide then
		return
	end

	local var_25_1 = FightPlayCardModel.instance:getUsedCards()
	local var_25_2 = FightPlayCardModel.instance:getCurIndex()
	local var_25_3 = false

	if FightConfig.instance:hasBuffFeature(arg_25_3, FightEnum.BuffFeature.SkillLevelJudgeAdd) then
		var_25_3 = true
	end

	for iter_25_0 = var_25_2 + 1, #var_25_1 do
		local var_25_4 = arg_25_0._cardItemList[iter_25_0]

		if var_25_4 then
			local var_25_5 = var_25_1[iter_25_0]
			local var_25_6 = var_25_5.clientData.custom_lock
			local var_25_7 = not FightViewHandCardItemLock.canUseCardSkill(var_25_5.uid, var_25_5.skillId)

			if var_25_6 ~= var_25_7 then
				local var_25_8 = gohelper.findChild(var_25_4.tr.parent.gameObject, "lock")

				var_25_5.clientData.custom_lock = var_25_7

				if var_25_7 then
					FightViewHandCardItemLock.setCardLock(var_25_5.uid, var_25_5.skillId, var_25_8, false)
				else
					gohelper.setActive(var_25_8, false)
				end
			end

			if var_25_3 then
				var_25_4:detectShowBlueStar()
			end
		end
	end
end

function var_0_0._makeTipsOutofSight(arg_26_0)
	local var_26_0 = arg_26_0._skillTipsGO.transform

	recthelper.setAnchorX(var_26_0, 9999999)
end

function var_0_0._updateView(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_1 or FightPlayCardModel.instance:getUsedCards()
	local var_27_1 = arg_27_2 or FightPlayCardModel.instance:getCurIndex()
	local var_27_2 = #var_27_0

	gohelper.setActive(arg_27_0._waitingAreaGO, var_27_2 > 0)

	for iter_27_0 = 1, var_27_2 do
		local var_27_3 = var_27_0[iter_27_0]
		local var_27_4 = var_27_3.uid
		local var_27_5 = var_27_3.skillId
		local var_27_6 = arg_27_0._cardItemList[iter_27_0]

		if not var_27_6 then
			local var_27_7 = gohelper.findChild(arg_27_0._waitingAreaGO, "cardItem" .. iter_27_0) or gohelper.cloneInPlace(arg_27_0._cardObjModel, "cardItem" .. iter_27_0)
			local var_27_8 = arg_27_0.viewContainer:getSetting().otherRes[1]
			local var_27_9 = arg_27_0:getResInst(var_27_8, var_27_7, "card")

			gohelper.setAsFirstSibling(var_27_9)

			var_27_6 = MonoHelper.addNoUpdateLuaComOnceToGo(var_27_9, FightViewCardItem, FightEnum.CardShowType.PlayCard)

			if FightCardDataHelper.getCardSkin() == 672801 then
				FightViewHandCardItem.replaceLockBg(gohelper.findChild(var_27_6.tr.parent.gameObject, "lock"))
			end

			table.insert(arg_27_0._cardItemList, var_27_6)
		end

		transformhelper.setLocalScale(var_27_6.tr, 1, 1, 1)
		recthelper.setAnchor(var_27_6.tr, 0, 0)

		gohelper.onceAddComponent(var_27_6.go, typeof(UnityEngine.CanvasGroup)).alpha = 1

		gohelper.setActive(var_27_6.go, true)

		var_27_3.clientData.custom_playedCard = true

		var_27_6:updateItem(var_27_4, var_27_5, var_27_3)
		var_27_6:detectShowBlueStar()
		arg_27_0:refreshCardRedAndBlue(var_27_6, var_27_3)
		gohelper.setActive(var_27_6.go, var_27_1 < iter_27_0)
	end

	for iter_27_1 = var_27_2 + 1, #arg_27_0._cardItemList do
		local var_27_10 = arg_27_0._cardItemList[iter_27_1]
		local var_27_11 = gohelper.findChild(var_27_10.tr.parent.gameObject, "lock")

		gohelper.setActive(var_27_11, false)
		gohelper.setActive(var_27_10.go, false)
	end

	arg_27_0:playScaleTween(var_27_2)
	arg_27_0:refreshLYCard(var_27_0)
end

function var_0_0.refreshCardRedAndBlue(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_2 and arg_28_2.areaRedOrBlue

	arg_28_1:setActiveRed(var_28_0 == FightEnum.CardColor.Red)
	arg_28_1:setActiveBlue(var_28_0 == FightEnum.CardColor.Blue)
	arg_28_1:setActiveBoth(var_28_0 == FightEnum.CardColor.Both)
end

function var_0_0.refreshLYCard(arg_29_0, arg_29_1)
	if FightDataHelper.LYDataMgr:hasCountBuff() then
		arg_29_0.LYCard = arg_29_0.LYCard or FightLYWaitAreaCard.Create(arg_29_0._waitingAreaGO)

		arg_29_0.LYCard:setScale(FightEnum.LYCardWaitAreaScale)
	end

	if arg_29_0.LYCard then
		arg_29_0.LYCard:refreshLYCard()

		local var_29_0 = arg_29_1 and #arg_29_1 or 0
		local var_29_1 = var_0_0.getCardPos(var_29_0 + 1, var_29_0)

		arg_29_0.LYCard:setAnchorX(var_29_1)
	end
end

function var_0_0.playScaleTween(arg_30_0, arg_30_1)
	arg_30_0:_releaseScalseTween()

	local var_30_0 = arg_30_1 > 7 and 1 - (arg_30_1 - 7) * 0.12 or 1

	if var_30_0 < 0 then
		var_30_0 = 0.5
	end

	local var_30_1 = 1 / var_30_0

	transformhelper.setLocalScale(arg_30_0._skillTipsGO.transform, var_30_1, var_30_1, var_30_1)

	arg_30_0._tweenScale = ZProj.TweenHelper.DOScale(arg_30_0._waitingAreaTran, var_30_0, var_30_0, var_30_0, 0.1)
end

function var_0_0._releaseScalseTween(arg_31_0)
	if arg_31_0._tweenScale then
		ZProj.TweenHelper.KillById(arg_31_0._tweenScale)

		arg_31_0._tweenScale = nil
	end
end

function var_0_0._onPlayCardAroundUpRank(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_0._cardItemList[arg_32_1]

	if var_32_0 then
		local var_32_1 = gohelper.findChild(var_32_0.tr.parent.gameObject, "lock")

		gohelper.setActive(var_32_1, false)
		var_32_0:playCardLevelChange(nil, arg_32_2)
	end
end

function var_0_0._onPlayCardAroundDownRank(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = arg_33_0._cardItemList[arg_33_1]

	if var_33_0 then
		local var_33_1 = gohelper.findChild(var_33_0.tr.parent.gameObject, "lock")

		gohelper.setActive(var_33_1, false)
		var_33_0:playCardLevelChange(nil, arg_33_2)
	end
end

function var_0_0._onCardLevelChangeDone(arg_34_0, arg_34_1)
	if arg_34_0._cardItemList then
		for iter_34_0, iter_34_1 in ipairs(arg_34_0._cardItemList) do
			if iter_34_1._cardInfoMO == arg_34_1 and iter_34_0 > FightPlayCardModel.instance:getCurIndex() then
				local var_34_0 = gohelper.findChild(iter_34_1.tr.parent.gameObject, "lock")

				FightViewHandCardItemLock.setCardLock(arg_34_1.uid, arg_34_1.skillId, var_34_0, false)

				break
			end
		end
	end
end

function var_0_0._onPlayCardAroundSetGray(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0._cardItemList[arg_35_1]

	if var_35_0 then
		var_35_0:playCardAroundSetGray()
	end
end

return var_0_0
