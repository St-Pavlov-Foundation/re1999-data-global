-- chunkname: @modules/logic/fight/view/FightViewWaitingAreaVersion1.lua

module("modules.logic.fight.view.FightViewWaitingAreaVersion1", package.seeall)

local FightViewWaitingAreaVersion1 = class("FightViewWaitingAreaVersion1", BaseViewExtended)
local ItemWidth = 0

FightViewWaitingAreaVersion1.StartPosX = 0

function FightViewWaitingAreaVersion1:onInitView()
	self._waitingAreaTran = gohelper.findChild(self.viewGO, "root/waitingArea").transform
	self._waitingAreaGO = gohelper.findChild(self.viewGO, "root/waitingArea/inner")
	self._skillTipsGO = gohelper.findChild(self.viewGO, "root/waitingArea/inner/skill")
	self._txtCardTitle = gohelper.findChildText(self._skillTipsGO, "txtTips/txtTitle")
	self._txtCardDesc = gohelper.findChildText(self._skillTipsGO, "txtTips")
	self._rectTrCardDesc = self._txtCardDesc:GetComponent(gohelper.Type_RectTransform)
	self._cardItemList = {}
	self._cardItemGOList = self:getUserDataTb_()
	self._cardObjModel = gohelper.findChild(self._waitingAreaGO, "cardItemModel")
	FightViewWaitingAreaVersion1.StartPosX = recthelper.getAnchorX(self._cardObjModel.transform)

	self:_refreshTipsVisibleState()
end

function FightViewWaitingAreaVersion1:_refreshTipsVisibleState()
	gohelper.onceAddComponent(self._skillTipsGO, gohelper.Type_CanvasGroup).alpha = GMFightShowState.playSkillDes and 1 or 0
end

function FightViewWaitingAreaVersion1:onOpen()
	self:_makeTipsOutofSight()
	self:addEventCb(FightController.instance, FightEvent.ShowSimulateClientUsedCard, self._onShowSimulateClientUsedCard, self)
	self:addEventCb(FightController.instance, FightEvent.SetUseCards, self._onSetUseCards, self)
	self:addEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, self._onEndRound, self)
	self:addEventCb(FightController.instance, FightEvent.BeforePlaySkill, self._beforePlaySkill, self)
	self:addEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)
	self:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, self._onBuffUpdate, self)
	self:addEventCb(FightController.instance, FightEvent.ASFD_OnStart, self.onASFDStart, self)
	self:addEventCb(FightController.instance, FightEvent.ASFD_OnDone, self.onASFDDone, self)
	self:addEventCb(FightController.instance, FightEvent.InvalidUsedCard, self._onInvalidUsedCard, self)
	self:addEventCb(FightController.instance, FightEvent.InvalidPreUsedCard, self._onInvalidPreUsedCard, self)
	self:addEventCb(FightController.instance, FightEvent.FixWaitingAreaItemCount, self._fixWaitingAreaItemCount, self)
	self:addEventCb(FightController.instance, FightEvent.GMHideFightView, self._refreshTipsVisibleState, self)
	self:addEventCb(FightController.instance, FightEvent.ParallelPlayNextSkillDoneThis, self._onParallelPlayNextSkillDoneThis, self)
	self:addEventCb(FightController.instance, FightEvent.ForceEndSkillStep, self._onForceEndSkillStep, self)
	self:addEventCb(FightController.instance, FightEvent.PlayCardAroundUpRank, self._onPlayCardAroundUpRank, self)
	self:addEventCb(FightController.instance, FightEvent.PlayCardAroundDownRank, self._onPlayCardAroundDownRank, self)
	self:addEventCb(FightController.instance, FightEvent.PlayCardAroundSetGray, self._onPlayCardAroundSetGray, self)
	self:addEventCb(FightController.instance, FightEvent.AddUseCard, self._onAddUseCard, self)
	self:addEventCb(FightController.instance, FightEvent.PlayChangeRankFail, self._onPlayChangeRankFail, self)
	self:addEventCb(FightController.instance, FightEvent.CardLevelChangeDone, self._onCardLevelChangeDone, self)
	self:addEventCb(FightController.instance, FightEvent.ALF_AddCardEffectAppear, self._onAlfAddCardEffectAppear, self)
	self:addEventCb(FightController.instance, FightEvent.ALF_AddCardEffectEnd, self._onAlfAddCardEffectEnd, self)
end

function FightViewWaitingAreaVersion1:_onAlfAddCardEffectAppear()
	self:updateCardLockObj()
end

function FightViewWaitingAreaVersion1:_onAlfAddCardEffectEnd()
	self:updateCardLockObj()
end

function FightViewWaitingAreaVersion1:onClose()
	return
end

function FightViewWaitingAreaVersion1:onDestroyView()
	if self._addUseCardFlow then
		self._addUseCardFlow:stop()

		self._addUseCardFlow = nil
	end

	for i, v in ipairs(self._cardItemList) do
		v:releaseEffectFlow()
	end

	self:_releaseScalseTween()

	if self.LYCard then
		self.LYCard:dispose()

		self.LYCard = nil
	end
end

function FightViewWaitingAreaVersion1:_onAddUseCard(cardIndexList)
	local usedCards = FightPlayCardModel.instance:getUsedCards()
	local find = false

	for _, cardIndex in ipairs(cardIndexList) do
		local cardInfo = usedCards[cardIndex]

		if cardInfo then
			cardInfo.CUSTOMADDUSECARD = true
			find = true
		end
	end

	if find then
		if not self._addUseCardFlow then
			self._addUseCardFlow = FlowSequence.New()

			self._addUseCardFlow:addWork(FightViewWorkAddUseCard)
		end

		self._addUseCardFlow:stop()
		self._addUseCardFlow:start(self)
	end
end

function FightViewWaitingAreaVersion1:_onPlayChangeRankFail(index, failType)
	local cardItem = self._cardItemList[index]

	if cardItem then
		cardItem:playChangeRankFail(failType)
	end
end

function FightViewWaitingAreaVersion1:_fixWaitingAreaItemCount(count)
	for i = 1, count do
		local cardItemGO = gohelper.findChild(self._waitingAreaGO, "cardItem" .. i)

		cardItemGO = cardItemGO or gohelper.cloneInPlace(self._cardObjModel, "cardItem" .. i)

		recthelper.setAnchorX(cardItemGO.transform, FightViewWaitingAreaVersion1.getCardPos(i, count))
	end
end

function FightViewWaitingAreaVersion1.getCardPos(index, count)
	local preSpecialCount = 0

	if FightDataHelper.LYDataMgr:hasCountBuff() then
		preSpecialCount = 1
	end

	index = index - preSpecialCount

	return FightViewWaitingAreaVersion1.StartPosX - FightViewWaitingAreaVersion1.CardItemWidth * (count - index)
end

function FightViewWaitingAreaVersion1:_onSetUseCards()
	local usedCards = FightPlayCardModel.instance:getUsedCards()

	self:_fixWaitingAreaItemCount(#usedCards)
	self:_updateView()
	self:updateCardLockObj()
end

function FightViewWaitingAreaVersion1:updateCardLockObj()
	local usedCards = FightPlayCardModel.instance:getUsedCards()

	for i, v in ipairs(usedCards) do
		local lockGO = gohelper.findChild(self._cardItemList[i].tr.parent.gameObject, "lock")

		v.clientData.custom_lock = FightViewHandCardItemLock.setCardLock(v.uid, v.skillId, lockGO, false)
	end
end

function FightViewWaitingAreaVersion1:_onShowSimulateClientUsedCard()
	local clientUsedCard = {}

	for i, v in ipairs(FightDataHelper.operationDataMgr:getPlayCardOpList()) do
		table.insert(clientUsedCard, v.cardInfoMO)
	end

	self:_fixWaitingAreaItemCount(#clientUsedCard)
	self:_updateView(clientUsedCard, 0)

	for i, v in ipairs(clientUsedCard) do
		local lockGO = gohelper.findChild(self._cardItemList[i].tr.parent.gameObject, "lock")

		v.clientData.custom_lock = FightViewHandCardItemLock.setCardLock(v.uid, v.skillId, lockGO, false)
	end

	if self.LYCard then
		self.LYCard:resetState()
		self.LYCard:playAnim("in")
	end
end

function FightViewWaitingAreaVersion1:_onEndRound()
	self:_makeTipsOutofSight()
end

function FightViewWaitingAreaVersion1:_onInvalidUsedCard(index, configEffect)
	local cardItem = self._cardItemList[index]

	if not cardItem then
		return
	end

	local lockGO = gohelper.findChild(cardItem.tr.parent.gameObject, "lock")

	gohelper.setActive(lockGO, false)

	if configEffect == -1 then
		cardItem:disappearCard()
	else
		cardItem:dissolveCard()
	end
end

function FightViewWaitingAreaVersion1:_onInvalidPreUsedCard(index)
	for i = FightPlayCardModel.instance:getCurIndex() + 1, index - 1 do
		self:_onInvalidUsedCard(i)
	end
end

function FightViewWaitingAreaVersion1:_onParallelPlayNextSkillDoneThis(fightStepData)
	self:_onForceEndSkillStep(fightStepData)
end

function FightViewWaitingAreaVersion1:_onForceEndSkillStep(fightStepData)
	if not FightHelper.isPlayerCardSkill(fightStepData) then
		return
	end

	local cardIndex = fightStepData.cardIndex
	local cardItem = self._cardItemList[cardIndex]

	if not cardItem then
		return
	end

	cardItem:releaseEffectFlow()
	gohelper.setActive(cardItem.go, false)
	self:_makeTipsOutofSight()
end

function FightViewWaitingAreaVersion1:_beforePlaySkill(entity, skillId, fightStepData)
	if not FightHelper.isPlayerCardSkill(fightStepData) then
		return
	end

	if fightStepData.cardIndex <= FightPlayCardModel.instance:getCurIndex() then
		return
	end

	FightPlayCardModel.instance:playCard(fightStepData.cardIndex)
	self:playScaleTween()

	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Play then
		self:refreshSkillText(skillId, entity.id)
		self:_displayFlow(entity.id, skillId, FightPlayCardModel.instance:getCurIndex())
	end
end

function FightViewWaitingAreaVersion1:refreshSkillText(skillId, entityId)
	local skillCO = lua_skill.configDict[skillId]
	local skillDesc = FightConfig.instance:getEntitySkillDesc(entityId, skillCO)

	self._txtCardDesc.text = skillCO and HeroSkillModel.instance:skillDesToSpot(skillDesc) or ""
	self._txtCardTitle.text = skillCO and skillCO.name or ""

	self._txtCardDesc:ForceMeshUpdate(true, true)

	local renderValue = self._txtCardDesc:GetRenderedValues()
	local descHeight = renderValue.y

	descHeight = math.max(0, descHeight)

	local height = descHeight + 83

	recthelper.setHeight(self._rectTrCardDesc, descHeight)
	recthelper.setHeight(self._skillTipsGO.transform, height)
end

function FightViewWaitingAreaVersion1:_displayFlow(entityId, skillId, index)
	if not self._cardItemList[index] then
		return
	end

	for i = 1, index - 1 do
		self._cardItemList[i]:releaseEffectFlow()
		gohelper.setActive(self._cardItemList[i].go, false)

		local lockGO = gohelper.findChild(self._cardItemList[i].tr.parent.gameObject, "lock")

		gohelper.setActive(lockGO, false)
	end

	self._cardItemList[index]:playUsedCardDisplay(self._skillTipsGO)
end

function FightViewWaitingAreaVersion1:_onSkillPlayFinish(entity, skillId, fightStepData)
	if not FightHelper.isPlayerCardSkill(fightStepData) then
		return
	end

	if not self._cardItemList[fightStepData.cardIndex] then
		return
	end

	self._cardItemList[fightStepData.cardIndex]:playUsedCardFinish(self._skillTipsGO, self._waitingAreaGO)
end

function FightViewWaitingAreaVersion1:onASFDStart(entity, skillId, fightStepData)
	if fightStepData.cardIndex <= FightPlayCardModel.instance:getCurIndex() then
		return
	end

	FightPlayCardModel.instance:playCard(fightStepData.cardIndex)
	self:playScaleTween()

	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Play then
		self:refreshSkillText(skillId, entity.id)
		self:_displayFlow(entity.id, skillId, FightPlayCardModel.instance:getCurIndex())
	end
end

function FightViewWaitingAreaVersion1:onASFDDone(cardIndex)
	if not self._cardItemList[cardIndex] then
		return
	end

	self._cardItemList[cardIndex]:playUsedCardFinish(self._skillTipsGO, self._waitingAreaGO)
end

function FightViewWaitingAreaVersion1:_onBuffUpdate(entityId, effectType, buffId)
	local entityMO = FightDataHelper.entityMgr:getById(entityId)

	if not entityMO or entityMO.side ~= FightEnum.EntitySide.MySide then
		return
	end

	local usedCards = FightPlayCardModel.instance:getUsedCards()
	local curIndex = FightPlayCardModel.instance:getCurIndex()
	local refreshBlueStar = false

	if FightConfig.instance:hasBuffFeature(buffId, FightEnum.BuffFeature.SkillLevelJudgeAdd) then
		refreshBlueStar = true
	end

	for i = curIndex + 1, #usedCards do
		local cardItem = self._cardItemList[i]

		if cardItem then
			local cardInfo = usedCards[i]
			local oldLock = cardInfo.clientData.custom_lock
			local newLock = not FightViewHandCardItemLock.canUseCardSkill(cardInfo.uid, cardInfo.skillId)

			if oldLock ~= newLock then
				local lockGO = gohelper.findChild(cardItem.tr.parent.gameObject, "lock")

				cardInfo.clientData.custom_lock = newLock

				if newLock then
					FightViewHandCardItemLock.setCardLock(cardInfo.uid, cardInfo.skillId, lockGO, false)
				else
					gohelper.setActive(lockGO, false)
				end
			end

			if refreshBlueStar then
				cardItem:detectShowBlueStar()
			end
		end
	end
end

function FightViewWaitingAreaVersion1:_makeTipsOutofSight()
	local skillTipsTr = self._skillTipsGO.transform

	recthelper.setAnchorX(skillTipsTr, 9999999)
end

function FightViewWaitingAreaVersion1:_updateView(cus_cards, cus_index)
	local usedCards = cus_cards or FightPlayCardModel.instance:getUsedCards()
	local curIndex = cus_index or FightPlayCardModel.instance:getCurIndex()
	local count = #usedCards

	gohelper.setActive(self._waitingAreaGO, count > 0)

	for i = 1, count do
		local usedCard = usedCards[i]
		local entityId = usedCard.uid
		local skillId = usedCard.skillId
		local cardItem = self._cardItemList[i]

		if not cardItem then
			local targetCardItemGO = gohelper.findChild(self._waitingAreaGO, "cardItem" .. i)

			targetCardItemGO = targetCardItemGO or gohelper.cloneInPlace(self._cardObjModel, "cardItem" .. i)

			local path = self.viewContainer:getSetting().otherRes[1]
			local cardItemGO = self:getResInst(path, targetCardItemGO, "card")

			gohelper.setAsFirstSibling(cardItemGO)

			cardItem = MonoHelper.addNoUpdateLuaComOnceToGo(cardItemGO, FightViewCardItem, FightEnum.CardShowType.PlayCard)

			if FightCardDataHelper.getCardSkin() == 672801 then
				FightViewHandCardItem.replaceLockBg(gohelper.findChild(cardItem.tr.parent.gameObject, "lock"))
			end

			table.insert(self._cardItemList, cardItem)
		end

		transformhelper.setLocalScale(cardItem.tr, 1, 1, 1)
		recthelper.setAnchor(cardItem.tr, 0, 0)

		gohelper.onceAddComponent(cardItem.go, typeof(UnityEngine.CanvasGroup)).alpha = 1

		gohelper.setActive(cardItem.go, true)

		usedCard.clientData.custom_playedCard = true

		cardItem:updateItem(entityId, skillId, usedCard)
		cardItem:detectShowBlueStar()
		self:refreshCardRedAndBlue(cardItem, usedCard)
		gohelper.setActive(cardItem.go, curIndex < i)
	end

	for i = count + 1, #self._cardItemList do
		local cardItem = self._cardItemList[i]
		local lockGO = gohelper.findChild(cardItem.tr.parent.gameObject, "lock")

		gohelper.setActive(lockGO, false)
		gohelper.setActive(cardItem.go, false)
	end

	self:playScaleTween(count)
	self:refreshLYCard(usedCards)
end

function FightViewWaitingAreaVersion1:refreshCardRedAndBlue(cardItem, cardInfoMo)
	local redOrBlue = cardInfoMo and cardInfoMo.areaRedOrBlue

	cardItem:setActiveRed(redOrBlue == FightEnum.CardColor.Red)
	cardItem:setActiveBlue(redOrBlue == FightEnum.CardColor.Blue)
	cardItem:setActiveBoth(redOrBlue == FightEnum.CardColor.Both)
end

function FightViewWaitingAreaVersion1:refreshLYCard(usedCards)
	if FightDataHelper.LYDataMgr:hasCountBuff() then
		self.LYCard = self.LYCard or FightLYWaitAreaCard.Create(self._waitingAreaGO)

		self.LYCard:setScale(FightEnum.LYCardWaitAreaScale)
	end

	if self.LYCard then
		self.LYCard:refreshLYCard()

		local len = usedCards and #usedCards or 0
		local anchorX = FightViewWaitingAreaVersion1.getCardPos(len + 1, len)

		self.LYCard:setAnchorX(anchorX)
	end
end

FightViewWaitingAreaVersion1.ScaleInterval = 0.05
FightViewWaitingAreaVersion1.PrefabWidth = 1270
FightViewWaitingAreaVersion1.CardItemWidth = 192

function FightViewWaitingAreaVersion1:playScaleTween(count)
	count = count or FightPlayCardModel.instance:getRemainCardCount()

	self:_releaseScalseTween()

	local lastPosX = FightViewWaitingAreaVersion1.getCardPos(1, count)
	local needWidth = FightViewWaitingAreaVersion1.StartPosX - lastPosX + FightViewWaitingAreaVersion1.CardItemWidth
	local toScale = 1

	if needWidth > FightViewWaitingAreaVersion1.PrefabWidth then
		toScale = FightViewWaitingAreaVersion1.PrefabWidth / needWidth
	end

	toScale = math.max(0.3, toScale)

	local skillScale = 1 / toScale

	transformhelper.setLocalScale(self._skillTipsGO.transform, skillScale, skillScale, skillScale)

	self._tweenScale = ZProj.TweenHelper.DOScale(self._waitingAreaTran, toScale, toScale, toScale, 0.1)
end

function FightViewWaitingAreaVersion1:_releaseScalseTween()
	if self._tweenScale then
		ZProj.TweenHelper.KillById(self._tweenScale)

		self._tweenScale = nil
	end
end

function FightViewWaitingAreaVersion1:_onPlayCardAroundUpRank(index, oldSkillId)
	local cardItem = self._cardItemList[index]

	if cardItem then
		local lockGO = gohelper.findChild(cardItem.tr.parent.gameObject, "lock")

		gohelper.setActive(lockGO, false)
		cardItem:playCardLevelChange(nil, oldSkillId)
	end
end

function FightViewWaitingAreaVersion1:_onPlayCardAroundDownRank(index, oldSkillId)
	local cardItem = self._cardItemList[index]

	if cardItem then
		local lockGO = gohelper.findChild(cardItem.tr.parent.gameObject, "lock")

		gohelper.setActive(lockGO, false)
		cardItem:playCardLevelChange(nil, oldSkillId)
	end
end

function FightViewWaitingAreaVersion1:_onCardLevelChangeDone(cardInfo)
	if self._cardItemList then
		for i, v in ipairs(self._cardItemList) do
			if v._cardInfoMO == cardInfo and i > FightPlayCardModel.instance:getCurIndex() then
				local lockGO = gohelper.findChild(v.tr.parent.gameObject, "lock")

				FightViewHandCardItemLock.setCardLock(cardInfo.uid, cardInfo.skillId, lockGO, false)

				break
			end
		end
	end
end

function FightViewWaitingAreaVersion1:_onPlayCardAroundSetGray(index)
	local cardItem = self._cardItemList[index]

	if cardItem then
		cardItem:playCardAroundSetGray()
	end
end

return FightViewWaitingAreaVersion1
