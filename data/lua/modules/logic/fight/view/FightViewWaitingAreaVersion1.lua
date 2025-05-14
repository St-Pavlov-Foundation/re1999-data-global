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
end

function var_0_0.onClose(arg_4_0)
	return
end

function var_0_0.onDestroyView(arg_5_0)
	if arg_5_0._addUseCardFlow then
		arg_5_0._addUseCardFlow:stop()

		arg_5_0._addUseCardFlow = nil
	end

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._cardItemList) do
		iter_5_1:releaseEffectFlow()
	end

	arg_5_0:_releaseScalseTween()

	if arg_5_0.LYCard then
		arg_5_0.LYCard:dispose()

		arg_5_0.LYCard = nil
	end
end

function var_0_0._onAddUseCard(arg_6_0, arg_6_1)
	local var_6_0 = FightPlayCardModel.instance:getUsedCards()[arg_6_1]

	if var_6_0 then
		var_6_0.CUSTOMADDUSECARD = true

		if not arg_6_0._addUseCardFlow then
			arg_6_0._addUseCardFlow = FlowSequence.New()

			arg_6_0._addUseCardFlow:addWork(FightViewWorkAddUseCard)
		end

		arg_6_0._addUseCardFlow:stop()
		arg_6_0._addUseCardFlow:start(arg_6_0)
	end
end

function var_0_0._onPlayChangeRankFail(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0._cardItemList[arg_7_1]

	if var_7_0 then
		var_7_0:playChangeRankFail(arg_7_2)
	end
end

function var_0_0._fixWaitingAreaItemCount(arg_8_0, arg_8_1)
	for iter_8_0 = 1, arg_8_1 do
		local var_8_0 = gohelper.findChild(arg_8_0._waitingAreaGO, "cardItem" .. iter_8_0) or gohelper.cloneInPlace(arg_8_0._cardObjModel, "cardItem" .. iter_8_0)

		recthelper.setAnchorX(var_8_0.transform, var_0_0.getCardPos(iter_8_0, arg_8_1))
	end
end

function var_0_0.getCardPos(arg_9_0, arg_9_1)
	local var_9_0 = 0

	if FightDataHelper.LYDataMgr:hasCountBuff() then
		var_9_0 = 1
	end

	arg_9_0 = arg_9_0 - var_9_0

	return var_0_0.StartPosX - 192 * (arg_9_1 - arg_9_0)
end

function var_0_0._onSetUseCards(arg_10_0)
	local var_10_0 = FightPlayCardModel.instance:getUsedCards()

	arg_10_0:_fixWaitingAreaItemCount(#var_10_0)
	arg_10_0:_updateView()

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		local var_10_1 = gohelper.findChild(arg_10_0._cardItemList[iter_10_0].tr.parent.gameObject, "lock")

		iter_10_1.custom_lock = FightViewHandCardItemLock.setCardLock(iter_10_1.uid, iter_10_1.skillId, var_10_1, false)
	end
end

function var_0_0._onShowSimulateClientUsedCard(arg_11_0)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(FightCardModel.instance:getPlayCardOpList()) do
		table.insert(var_11_0, iter_11_1.cardInfoMO)
	end

	arg_11_0:_fixWaitingAreaItemCount(#var_11_0)
	arg_11_0:_updateView(var_11_0, 0)

	for iter_11_2, iter_11_3 in ipairs(var_11_0) do
		local var_11_1 = gohelper.findChild(arg_11_0._cardItemList[iter_11_2].tr.parent.gameObject, "lock")

		iter_11_3.custom_lock = FightViewHandCardItemLock.setCardLock(iter_11_3.uid, iter_11_3.skillId, var_11_1, false)
	end

	if arg_11_0.LYCard then
		arg_11_0.LYCard:resetState()
		arg_11_0.LYCard:playAnim("in")
	end
end

function var_0_0._onEndRound(arg_12_0)
	arg_12_0:_makeTipsOutofSight()
end

function var_0_0._onInvalidUsedCard(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0._cardItemList[arg_13_1]

	if not var_13_0 then
		return
	end

	local var_13_1 = gohelper.findChild(var_13_0.tr.parent.gameObject, "lock")

	gohelper.setActive(var_13_1, false)

	if arg_13_2 == -1 then
		var_13_0:disappearCard()
	else
		var_13_0:dissolveCard()
	end
end

function var_0_0._onInvalidPreUsedCard(arg_14_0, arg_14_1)
	for iter_14_0 = FightPlayCardModel.instance:getCurIndex() + 1, arg_14_1 - 1 do
		arg_14_0:_onInvalidUsedCard(iter_14_0)
	end
end

function var_0_0._onParallelPlayNextSkillDoneThis(arg_15_0, arg_15_1)
	arg_15_0:_onForceEndSkillStep(arg_15_1)
end

function var_0_0._onForceEndSkillStep(arg_16_0, arg_16_1)
	if not FightHelper.isPlayerCardSkill(arg_16_1) then
		return
	end

	local var_16_0 = arg_16_1.cardIndex
	local var_16_1 = arg_16_0._cardItemList[var_16_0]

	if not var_16_1 then
		return
	end

	var_16_1:releaseEffectFlow()
	gohelper.setActive(var_16_1.go, false)
	arg_16_0:_makeTipsOutofSight()
end

function var_0_0._beforePlaySkill(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	if not FightHelper.isPlayerCardSkill(arg_17_3) then
		return
	end

	if arg_17_3.cardIndex <= FightPlayCardModel.instance:getCurIndex() then
		return
	end

	FightPlayCardModel.instance:playCard(arg_17_3.cardIndex)

	if FightModel.instance:getCurStage() == FightEnum.Stage.Play then
		local var_17_0 = lua_skill.configDict[arg_17_2]
		local var_17_1 = FightConfig.instance:getEntitySkillDesc(arg_17_1.id, var_17_0)
		local var_17_2 = GameUtil.getTextHeightByLine(arg_17_0._txtCardDesc, var_17_1, 38) + 83

		recthelper.setHeight(arg_17_0._skillTipsGO.transform, var_17_2)

		arg_17_0._txtCardTitle.text = var_17_0 and var_17_0.name or ""
		arg_17_0._txtCardDesc.text = var_17_0 and HeroSkillModel.instance:skillDesToSpot(var_17_1) or ""

		arg_17_0:_displayFlow(arg_17_1.id, arg_17_2, FightPlayCardModel.instance:getCurIndex())
	end
end

function var_0_0._displayFlow(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	if not arg_18_0._cardItemList[arg_18_3] then
		return
	end

	for iter_18_0 = 1, arg_18_3 - 1 do
		arg_18_0._cardItemList[iter_18_0]:releaseEffectFlow()
		gohelper.setActive(arg_18_0._cardItemList[iter_18_0].go, false)

		local var_18_0 = gohelper.findChild(arg_18_0._cardItemList[iter_18_0].tr.parent.gameObject, "lock")

		gohelper.setActive(var_18_0, false)
	end

	arg_18_0._cardItemList[arg_18_3]:playUsedCardDisplay(arg_18_0._skillTipsGO)
end

function var_0_0._onSkillPlayFinish(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	if not FightHelper.isPlayerCardSkill(arg_19_3) then
		return
	end

	if not arg_19_0._cardItemList[arg_19_3.cardIndex] then
		return
	end

	arg_19_0._cardItemList[arg_19_3.cardIndex]:playUsedCardFinish(arg_19_0._skillTipsGO, arg_19_0._waitingAreaGO)
end

function var_0_0.onASFDStart(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
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

function var_0_0.onASFDDone(arg_21_0, arg_21_1)
	if not arg_21_0._cardItemList[arg_21_1] then
		return
	end

	arg_21_0._cardItemList[arg_21_1]:playUsedCardFinish(arg_21_0._skillTipsGO, arg_21_0._waitingAreaGO)
end

function var_0_0._onBuffUpdate(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = FightDataHelper.entityMgr:getById(arg_22_1)

	if not var_22_0 or var_22_0.side ~= FightEnum.EntitySide.MySide then
		return
	end

	local var_22_1 = FightPlayCardModel.instance:getUsedCards()
	local var_22_2 = FightPlayCardModel.instance:getCurIndex()
	local var_22_3 = false

	if FightConfig.instance:hasBuffFeature(arg_22_3, FightEnum.BuffFeature.SkillLevelJudgeAdd) then
		var_22_3 = true
	end

	for iter_22_0 = var_22_2 + 1, #var_22_1 do
		local var_22_4 = arg_22_0._cardItemList[iter_22_0]

		if var_22_4 then
			local var_22_5 = var_22_1[iter_22_0]
			local var_22_6 = var_22_5.custom_lock
			local var_22_7 = not FightViewHandCardItemLock.canUseCardSkill(var_22_5.uid, var_22_5.skillId)

			if var_22_6 ~= var_22_7 then
				local var_22_8 = gohelper.findChild(var_22_4.tr.parent.gameObject, "lock")

				var_22_5.custom_lock = var_22_7

				if var_22_7 then
					FightViewHandCardItemLock.setCardLock(var_22_5.uid, var_22_5.skillId, var_22_8, false)
				else
					gohelper.setActive(var_22_8, false)
				end
			end

			if var_22_3 then
				var_22_4:detectShowBlueStar()
			end
		end
	end
end

function var_0_0._makeTipsOutofSight(arg_23_0)
	local var_23_0 = arg_23_0._skillTipsGO.transform

	recthelper.setAnchorX(var_23_0, 9999999)
end

function var_0_0._updateView(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_1 or FightPlayCardModel.instance:getUsedCards()
	local var_24_1 = arg_24_2 or FightPlayCardModel.instance:getCurIndex()
	local var_24_2 = #var_24_0

	gohelper.setActive(arg_24_0._waitingAreaGO, var_24_2 > 0)

	for iter_24_0 = 1, var_24_2 do
		local var_24_3 = var_24_0[iter_24_0]
		local var_24_4 = var_24_3.uid
		local var_24_5 = var_24_3.skillId
		local var_24_6 = arg_24_0._cardItemList[iter_24_0]

		if not var_24_6 then
			local var_24_7 = gohelper.findChild(arg_24_0._waitingAreaGO, "cardItem" .. iter_24_0) or gohelper.cloneInPlace(arg_24_0._cardObjModel, "cardItem" .. iter_24_0)
			local var_24_8 = arg_24_0.viewContainer:getSetting().otherRes[1]
			local var_24_9 = arg_24_0:getResInst(var_24_8, var_24_7, "card")

			gohelper.setAsFirstSibling(var_24_9)

			var_24_6 = MonoHelper.addNoUpdateLuaComOnceToGo(var_24_9, FightViewCardItem, FightEnum.CardShowType.PlayCard)

			table.insert(arg_24_0._cardItemList, var_24_6)
		end

		transformhelper.setLocalScale(var_24_6.tr, 1, 1, 1)
		recthelper.setAnchor(var_24_6.tr, 0, 0)

		gohelper.onceAddComponent(var_24_6.go, typeof(UnityEngine.CanvasGroup)).alpha = 1

		gohelper.setActive(var_24_6.go, true)

		var_24_3.custom_playedCard = true

		var_24_6:updateItem(var_24_4, var_24_5, var_24_3)
		var_24_6:detectShowBlueStar()
		arg_24_0:refreshCardRedAndBlue(var_24_6, var_24_3)
		gohelper.setActive(var_24_6.go, var_24_1 < iter_24_0)
	end

	for iter_24_1 = var_24_2 + 1, #arg_24_0._cardItemList do
		local var_24_10 = arg_24_0._cardItemList[iter_24_1]
		local var_24_11 = gohelper.findChild(var_24_10.tr.parent.gameObject, "lock")

		gohelper.setActive(var_24_11, false)
		gohelper.setActive(var_24_10.go, false)
	end

	arg_24_0:playScaleTween(var_24_2)
	arg_24_0:refreshLYCard(var_24_0)
end

function var_0_0.refreshCardRedAndBlue(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_2 and arg_25_2.areaRedOrBlue

	arg_25_1:setActiveRed(var_25_0 == FightEnum.CardColor.Red)
	arg_25_1:setActiveBlue(var_25_0 == FightEnum.CardColor.Blue)
	arg_25_1:setActiveBoth(var_25_0 == FightEnum.CardColor.Both)
end

function var_0_0.refreshLYCard(arg_26_0, arg_26_1)
	if FightDataHelper.LYDataMgr:hasCountBuff() then
		arg_26_0.LYCard = arg_26_0.LYCard or FightLYWaitAreaCard.Create(arg_26_0._waitingAreaGO)

		arg_26_0.LYCard:setScale(FightEnum.LYCardWaitAreaScale)
	end

	if arg_26_0.LYCard then
		arg_26_0.LYCard:refreshLYCard()

		local var_26_0 = arg_26_1 and #arg_26_1 or 0
		local var_26_1 = var_0_0.getCardPos(var_26_0 + 1, var_26_0)

		arg_26_0.LYCard:setAnchorX(var_26_1)
	end
end

function var_0_0.playScaleTween(arg_27_0, arg_27_1)
	arg_27_0:_releaseScalseTween()

	local var_27_0 = arg_27_1 > 7 and 1 - (arg_27_1 - 7) * 0.12 or 1

	if var_27_0 < 0 then
		var_27_0 = 0.5
	end

	local var_27_1 = 1 / var_27_0

	transformhelper.setLocalScale(arg_27_0._skillTipsGO.transform, var_27_1, var_27_1, var_27_1)

	arg_27_0._tweenScale = ZProj.TweenHelper.DOScale(arg_27_0._waitingAreaTran, var_27_0, var_27_0, var_27_0, 0.1)
end

function var_0_0._releaseScalseTween(arg_28_0)
	if arg_28_0._tweenScale then
		ZProj.TweenHelper.KillById(arg_28_0._tweenScale)

		arg_28_0._tweenScale = nil
	end
end

function var_0_0._onPlayCardAroundUpRank(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_0._cardItemList[arg_29_1]

	if var_29_0 then
		local var_29_1 = gohelper.findChild(var_29_0.tr.parent.gameObject, "lock")

		gohelper.setActive(var_29_1, false)
		var_29_0:playCardLevelChange(nil, arg_29_2)
	end
end

function var_0_0._onPlayCardAroundDownRank(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_0._cardItemList[arg_30_1]

	if var_30_0 then
		local var_30_1 = gohelper.findChild(var_30_0.tr.parent.gameObject, "lock")

		gohelper.setActive(var_30_1, false)
		var_30_0:playCardLevelChange(nil, arg_30_2)
	end
end

function var_0_0._onCardLevelChangeDone(arg_31_0, arg_31_1)
	if arg_31_0._cardItemList then
		for iter_31_0, iter_31_1 in ipairs(arg_31_0._cardItemList) do
			if iter_31_1._cardInfoMO == arg_31_1 and iter_31_0 > FightPlayCardModel.instance:getCurIndex() then
				local var_31_0 = gohelper.findChild(iter_31_1.tr.parent.gameObject, "lock")

				FightViewHandCardItemLock.setCardLock(arg_31_1.uid, arg_31_1.skillId, var_31_0, false)

				break
			end
		end
	end
end

function var_0_0._onPlayCardAroundSetGray(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_0._cardItemList[arg_32_1]

	if var_32_0 then
		var_32_0:playCardAroundSetGray()
	end
end

return var_0_0
