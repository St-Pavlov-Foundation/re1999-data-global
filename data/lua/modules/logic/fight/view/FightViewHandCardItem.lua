module("modules.logic.fight.view.FightViewHandCardItem", package.seeall)

slot0 = class("FightViewHandCardItem", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0._subViewInst = slot1
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.tr = slot1.transform
	slot0._cardItemAni = gohelper.onceAddComponent(slot0.go, typeof(UnityEngine.Animator))
	slot0._forAnimGO = gohelper.findChild(slot1, "foranim")
	slot0._innerGO = slot0._subViewInst:getResInst(slot0._subViewInst.viewContainer:getSetting().otherRes[1], slot0._forAnimGO, "card")

	gohelper.setAsFirstSibling(slot0._innerGO)

	slot0._cardItem = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._innerGO, FightViewCardItem, FightEnum.CardShowType.HandCard)
	slot0._cardAni = slot0._innerGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._cardAni.enabled = false
	slot0._innerTr = slot0._innerGO.transform
	slot0._universalGO = gohelper.findChild(slot0._forAnimGO, "universal")
	slot0._spEffectGO = gohelper.findChild(slot0._forAnimGO, "spEffect")
	slot0._foranim = slot0._forAnimGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._itemWidth = recthelper.getWidth(slot0.tr)
	slot0._oldParentX = -999999
	slot0._click = SLFramework.UGUI.UIClickListener.Get(slot0.go)
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0.go)
	slot0._long = SLFramework.UGUI.UILongPressListener.Get(slot0.go)
	slot0._rightClick = SLFramework.UGUI.UIRightClickListener.Get(slot0.go)
	slot0._longPressArr = {
		0.5,
		99999
	}
	slot0._isDraging = false
	slot0._isLongPress = false

	slot0:setUniversal(false)

	slot0._keyOffset = 8
	slot0._keyMaxTipsNum = 9
	slot0._restrainComp = MonoHelper.addLuaComOnceToGo(slot0.go, FightViewHandCardItemRestrain, slot0)
	slot0._lockComp = MonoHelper.addLuaComOnceToGo(slot0.go, FightViewHandCardItemLock, slot0)
	slot0._loader = slot0._loader or LoaderComponent.New()
	slot0._lockGO = gohelper.findChild(slot0.go, "foranim/lock")
	slot0._cardConvertEffect = gohelper.findChild(slot0.go, "foranim/cardConvertEffect")

	slot0:setASFDActive(true)
end

function slot0.addEventListeners(slot0)
	if not FightReplayModel.instance:isReplay() then
		slot0._click:AddClickListener(slot0._onClickThis, slot0)
		slot0._drag:AddDragBeginListener(slot0._onDragBegin, slot0)
		slot0._drag:AddDragListener(slot0._onDragThis, slot0)
		slot0._drag:AddDragEndListener(slot0._onDragEnd, slot0)
	end

	slot0:addEventCb(FightController.instance, FightEvent.SelectSkillTarget, slot0._onSelectSkillTarget, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnStageChange, slot0._onStageChange, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, slot0._onBuffUpdate, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.DragHandCardBegin, slot0._onDragHandCardBegin, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.DragHandCardEnd, slot0._onDragHandCardEnd, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.SimulateDragHandCardBegin, slot0._simulateDragHandCardBegin, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.SimulateDragHandCard, slot0._simulateDragHandCard, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.SimulateDragHandCardEnd, slot0._simulateDragHandCardEnd, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.SimulatePlayHandCard, slot0._simulatePlayHandCard, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.StartReplay, slot0._checkStartReplay, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.RefreshOneHandCard, slot0._onRefreshOneHandCard, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.RefreshHandCardMO, slot0._onRefreshHandCardMO, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.CardLevelChangeDone, slot0._onCardLevelChangeDone, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.GMForceRefreshNameUIBuff, slot0._onGMForceRefreshNameUIBuff, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.SeasonSelectChangeHeroTarget, slot0._onSeasonSelectChangeHeroTarget, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.ExitOperateState, slot0._onExitOperateState, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.CancelOperation, slot0._onCancelOperation, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.ASFD_AllocateCardEnergyDone, slot0._allocateEnergyDone, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.PlayCardOver, slot0._showASFD, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._click:RemoveClickListener()
	slot0._drag:RemoveDragBeginListener()
	slot0._drag:RemoveDragListener()
	slot0._drag:RemoveDragEndListener()
	slot0._long:RemoveLongPressListener()

	if PCInputController.instance:getIsUse() then
		slot0._long:RemoveHoverListener()
	end

	slot0._rightClick:RemoveClickListener()
	slot0:removeEventCb(FightController.instance, FightEvent.SelectSkillTarget, slot0._onSelectSkillTarget, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnStageChange, slot0._onStageChange, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnBuffUpdate, slot0._onBuffUpdate, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.DragHandCardBegin, slot0._onDragHandCardBegin, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.DragHandCardEnd, slot0._onDragHandCardEnd, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.SimulateDragHandCardBegin, slot0._simulateDragHandCardBegin, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.SimulateDragHandCard, slot0._simulateDragHandCard, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.SimulateDragHandCardEnd, slot0._simulateDragHandCardEnd, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.SimulatePlayHandCard, slot0._simulatePlayHandCard, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.StartReplay, slot0._checkStartReplay, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.RefreshOneHandCard, slot0._onRefreshOneHandCard, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.RefreshHandCardMO, slot0._onRefreshHandCardMO, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.CardLevelChangeDone, slot0._onCardLevelChangeDone, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.GMForceRefreshNameUIBuff, slot0._onGMForceRefreshNameUIBuff, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.SeasonSelectChangeHeroTarget, slot0._onSeasonSelectChangeHeroTarget, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.ExitOperateState, slot0._onExitOperateState, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.CancelOperation, slot0._onCancelOperation, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.ASFD_AllocateCardEnergyDone, slot0._allocateEnergyDone, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.PlayCardOver, slot0._showASFD, slot0)
	TaskDispatcher.cancelTask(slot0._delayDisableAnim, slot0)
end

function slot0._allocateEnergyDone(slot0)
	if slot0._cardItem then
		slot0._cardItem:_allocateEnergyDone()
	end
end

function slot0._showASFD(slot0)
	slot0:setASFDActive(true)
end

function slot0._onCancelOperation(slot0)
	slot0:setASFDActive(true)
end

function slot0._onSeasonSelectChangeHeroTarget(slot0, slot1)
	if slot0.cardInfoMO and slot0.cardInfoMO.uid == slot1 then
		slot0._seasonChangeHeroSelecting = true

		slot0._cardItemAni:Play("preview")
	elseif slot0._seasonChangeHeroSelecting then
		slot0._cardItemAni:Play("idle")

		slot0._seasonChangeHeroSelecting = false
	end
end

function slot0._onExitOperateState(slot0)
	if slot0._seasonChangeHeroSelecting then
		slot0._cardItemAni:Play("idle")

		slot0._seasonChangeHeroSelecting = false
	end
end

function slot0.setASFDActive(slot0, slot1)
	if slot0._cardItem then
		slot0._cardItem:setASFDActive(slot1)
	end
end

function slot0.playASFDAnim(slot0, slot1)
	if slot0._cardItem then
		slot0._cardItem:playASFDAnim(slot1)
	end
end

function slot0.onStart(slot0)
	if FightModel.instance:getCurStage() then
		slot0:_onStageChange(slot1)
	end

	slot0:_checkStartReplay()
end

function slot0._checkStartReplay(slot0)
	if FightReplayModel.instance:isReplay() then
		slot0._click:RemoveClickListener()
		slot0._drag:RemoveDragBeginListener()
		slot0._drag:RemoveDragListener()
		slot0._drag:RemoveDragEndListener()
		slot0._long:RemoveLongPressListener()
		slot0._long:RemoveHoverListener()
		slot0._rightClick:RemoveClickListener()
	end
end

function slot0.setUniversal(slot0, slot1)
	gohelper.setActive(slot0._universalGO, slot1)
end

function slot0.refreshPreDelete(slot0, slot1)
	if slot1 then
		-- Nothing
	end
end

function slot0.updateItem(slot0, slot1, slot2)
	slot0.index = slot1 or slot0.index

	if slot2 then
		slot0.cardInfoMO = slot2
		slot2.custom_handCardIndex = slot0.index

		if not lua_skill.configDict[slot2.skillId] then
			logError("skill not exist: " .. slot2.skillId)

			return
		end

		slot0._cardItem:updateItem(slot2.uid, slot2.skillId, slot2)

		slot0._isDraging = false
		slot0._isLongPress = false
		slot0._skillId = slot2.skillId

		slot0:setUniversal(false)
		slot0:_updateSpEffect()
		slot0._restrainComp:updateItem(slot2)
		slot0._lockComp:updateItem(slot2)
		slot0._cardItem:updateResistanceByCardInfo(slot2)
	end

	slot0:_hideEffect()
	slot0:_refreshBlueStar()
	slot0:showKeytips()
	slot0:showCardHeat()
end

function slot0.showCardHeat(slot0)
	slot0._cardItem:showCardHeat()
end

function slot0.showKeytips(slot0)
	slot1 = gohelper.findChild(slot0.go, "foranim/card/#go_pcbtn")

	if #FightCardModel.instance:getHandCards() == 0 then
		return
	end

	if slot2 - slot0.index + 1 >= 1 and slot3 <= slot2 and slot3 <= slot0._keyMaxTipsNum then
		if not slot0._pcTips then
			slot0._pcTips = PCInputController.instance:showkeyTips(slot1, PCInputModel.Activity.battle, slot3 + slot0._keyOffset)
		else
			slot0._pcTips:Refresh(PCInputModel.Activity.battle, slot3 + slot0._keyOffset)
		end

		if slot0._pcTips == nil then
			return
		end

		if slot0._cardItem and slot0._cardItem:IsUniqueSkill() then
			recthelper.setAnchorY(slot0._pcTips._go.transform, 200)
		else
			recthelper.setAnchorY(slot0._pcTips._go.transform, 150)
		end

		slot0._pcTips:Show(true)
	elseif slot0._pcTips then
		slot0._pcTips:Show(false)
	end
end

function slot0.refreshCardMO(slot0, slot1, slot2)
	slot0.index = slot1
	slot0.cardInfoMO = slot2
end

function slot0._onRefreshHandCardMO(slot0, slot1, slot2)
	slot0:refreshCardMO(slot1, slot2)
end

function slot0.onLongPressEnd(slot0)
	slot0._isLongPress = false
end

function slot0.getCardItem(slot0)
	return slot0._cardItem
end

function slot0._onBuffUpdate(slot0, slot1, slot2, slot3)
	if not slot0.cardInfoMO then
		return
	end

	if slot1 ~= slot0.cardInfoMO.uid then
		return
	end

	slot0:_updateSpEffect()

	if slot2 ~= FightEnum.EffectType.BUFFUPDATE and FightConfig.instance:hasBuffFeature(slot3, FightEnum.BuffFeature.SkillLevelJudgeAdd) then
		slot0:_refreshBlueStar()
	end
end

function slot0._refreshBlueStar(slot0)
	slot1 = slot0.cardInfoMO and slot0.cardInfoMO.uid
	slot2 = slot0.cardInfoMO and slot0.cardInfoMO.skillId

	slot0._cardItem:showBlueStar(slot1 and slot2 and FightCardModel.instance:getSkillLv(slot1, slot2))
end

function slot0._onDragHandCardBegin(slot0, slot1, slot2, slot3)
	if not slot0.cardInfoMO then
		return
	end

	if not FightEnum.UniversalCard[slot3.skillId] or slot3 == slot0.cardInfoMO then
		return
	end

	if FightCardModel.instance:getSkillLv(slot0.cardInfoMO.uid, slot0.cardInfoMO.skillId) <= FightCardModel.instance:getSkillLv(slot3.uid, slot3.skillId) then
		return
	end

	gohelper.setActive(gohelper.findChild(slot0._forAnimGO, "universalMask"), true)

	for slot10 = 1, 4 do
		gohelper.setActive(gohelper.findChild(slot6, "jinengpai_" .. slot10), slot10 == slot5)
	end
end

function slot0._onDragHandCardEnd(slot0)
	gohelper.setActive(gohelper.findChild(slot0._forAnimGO, "universalMask"), false)
end

function slot0._onSelectSkillTarget(slot0)
	slot0:_updateSpEffect()
end

function slot0._updateSpEffect(slot0)
	if gohelper.isNil(slot0._spEffectGO) then
		return
	end

	if not slot0.cardInfoMO then
		return
	end

	slot1 = lua_skill.configDict[slot0._skillId]

	if FightModel.instance:getCurStage() ~= FightEnum.Stage.Card and slot2 ~= FightEnum.Stage.AutoCard then
		gohelper.setActive(slot0._spEffectGO, false)

		return
	end

	slot3 = false
	slot4 = {
		[slot9] = true
	}
	slot8 = slot1.clientIgnoreCondition
	slot9 = "#"

	for slot8, slot9 in ipairs(FightStrUtil.instance:getSplitToNumberCache(slot8, slot9)) do
		-- Nothing
	end

	for slot8 = 1, FightEnum.MaxBehavior do
		if not slot4[slot8] and (slot0:_checkConditionSpEffect(slot1["condition" .. slot8], slot1["conditionTarget" .. slot8]) or slot0:_checkSkillRateUpBehavior(slot1["behavior" .. slot8], slot10)) then
			slot3 = true

			break
		end
	end

	if slot3 ~= slot0._spEffectGO.activeSelf then
		gohelper.setActive(slot0._spEffectGO, slot3)
	end
end

function slot0._getConditionTargetUid(slot0, slot1)
	if slot1 == 103 then
		return slot0.cardInfoMO.uid
	elseif slot1 == 0 then
		return FightCardModel.instance.curSelectEntityId
	elseif slot1 == 202 then
		for slot5, slot6 in ipairs(FightDataHelper.entityMgr:getEnemyNormalList()) do
			return slot6.id
		end
	end
end

function slot0._getConditionTargetUids(slot0, slot1)
	if slot1 == 103 then
		return {
			slot0.cardInfoMO.uid
		}
	elseif slot1 == 0 then
		return {
			FightCardModel.instance.curSelectEntityId
		}
	elseif slot1 == 202 then
		slot2 = {}

		for slot6, slot7 in ipairs(FightDataHelper.entityMgr:getEnemyNormalList()) do
			table.insert(slot2, slot7.id)
		end

		return slot2
	end

	return {}
end

function slot0._checkConditionSpEffect(slot0, slot1, slot2)
	if string.nilorempty(slot1) then
		return
	end

	if #FightStrUtil.instance:getSplitCache(slot1, "&") > 1 then
		for slot8, slot9 in ipairs(slot3) do
			if slot0:_checkSingleCondition(slot9, slot2) then
				slot4 = 0 + 1
			end
		end

		if slot4 == #slot3 then
			return true
		end
	elseif #FightStrUtil.instance:getSplitCache(slot1, "|") > 1 then
		for slot7, slot8 in ipairs(slot3) do
			if slot0:_checkSingleCondition(slot8, slot2) then
				return true
			end
		end
	elseif slot0:_checkSingleCondition(slot1, slot2) then
		return true
	end
end

function slot0._checkSingleCondition(slot0, slot1, slot2)
	if not lua_skill_behavior_condition.configDict[tonumber(FightStrUtil.instance:getSplitCache(slot1, "#")[1])] or string.nilorempty(slot5.type) then
		return false
	end

	if not slot0:_getConditionTargetUid(slot2) or tostring(slot6) == "0" then
		return false
	end

	if not FightDataHelper.entityMgr:getById(slot6) then
		return false
	end

	if slot5.type == "LifeLess" then
		return tonumber(slot3[2]) * 0.001 > slot7.currentHp / slot7.attrMO.hp
	elseif slot5.type == "LifeMore" then
		return tonumber(slot3[2]) * 0.001 < slot7.currentHp / slot7.attrMO.hp
	elseif slot5.type == "HasBuffId" then
		for slot12 = 2, #slot3 do
			if tonumber(slot3[slot12]) and slot0:_getSimulateBuffTypeDic(slot7)[slot13] then
				return true
			end
		end
	elseif slot5.type == "HasBuff" then
		slot9 = {
			[slot15.type] = true
		}

		for slot13, slot14 in pairs(slot0:_getSimulateBuffTypeDic(slot7)) do
			if lua_skill_bufftype.configDict[slot13] then
				-- Nothing
			end
		end

		for slot13 = 2, #slot3 do
			if tonumber(slot3[slot13]) and slot9[slot14] then
				return true
			end
		end
	elseif slot5.type == "HasBuffGroup" then
		slot9 = {
			[slot15.group] = true
		}

		for slot13, slot14 in pairs(slot0:_getSimulateBuffTypeDic(slot7)) do
			if lua_skill_bufftype.configDict[slot13] then
				-- Nothing
			end
		end

		for slot13 = 2, #slot3 do
			if tonumber(slot3[slot13]) and slot9[slot14] then
				return true
			end
		end
	elseif slot5.type == "NoBuffId" then
		slot8 = slot0:_getBuffTypeDic(slot7)

		if #FightStrUtil.instance:getSplitCache(slot3[2], ",") > 1 then
			for slot13 = 1, #slot9 do
				if tonumber(slot9[slot13]) and slot8[slot14] then
					return false
				end
			end
		else
			for slot13 = 2, #slot3 do
				if tonumber(slot3[slot13]) and slot8[slot14] then
					return false
				end
			end
		end

		return true
	elseif slot5.type == "NoBuff" then
		slot9 = {
			[slot15.type] = true
		}

		for slot13, slot14 in pairs(slot0:_getBuffTypeDic(slot7)) do
			if lua_skill_bufftype.configDict[slot13] then
				-- Nothing
			end
		end

		if #FightStrUtil.instance:getSplitCache(slot3[2], ",") > 1 then
			for slot14 = 1, #slot10 do
				if tonumber(slot10[slot14]) and slot9[slot15] then
					return false
				end
			end
		else
			for slot14 = 2, #slot3 do
				if tonumber(slot3[slot14]) and slot9[slot15] then
					return false
				end
			end
		end

		return true
	elseif slot5.type == "NoBuffGroup" then
		slot9 = {
			[slot15.group] = true
		}

		for slot13, slot14 in pairs(slot0:_getBuffTypeDic(slot7)) do
			if lua_skill_bufftype.configDict[slot13] then
				-- Nothing
			end
		end

		if #FightStrUtil.instance:getSplitCache(slot3[2], ",") > 1 then
			for slot14 = 1, #slot10 do
				if tonumber(slot10[slot14]) and slot9[slot15] then
					return false
				end
			end
		else
			for slot14 = 2, #slot3 do
				if tonumber(slot3[slot14]) and slot9[slot15] then
					return false
				end
			end
		end

		return true
	elseif slot5.type == "PowerCompare" then
		if slot7:getPowerInfo(tonumber(slot3[3])) then
			if slot3[2] == "1" then
				return tonumber(slot3[4]) <= slot8.num
			end
		else
			return false
		end
	elseif slot5.type == "TypeIdBuffCountMoreThan" then
		for slot14, slot15 in ipairs(slot7:getBuffList()) do
			if lua_skill_buff.configDict[slot15.buffId] and slot16.typeId == tonumber(slot3[2]) and tonumber(slot3[3]) <= (slot15.layer and slot15.layer > 0 and slot15.layer or 1) then
				return true
			end
		end
	elseif slot5.type == "SelfTeamHasBuffTypeLayerMoreThan" then
		slot9 = tonumber(slot3[3])
		slot10 = tonumber(slot3[2])
		slot11 = 0

		for slot15, slot16 in ipairs(slot0:_getConditionTargetUids(slot2)) do
			for slot22, slot23 in ipairs(FightDataHelper.entityMgr:getById(slot16):getBuffList()) do
				if lua_skill_buff.configDict[slot23.buffId] and slot24.typeId == slot9 then
					slot11 = slot11 + (slot23.layer and slot23.layer > 0 and slot23.layer or 1)
				end
			end
		end

		return slot10 <= slot11
	elseif slot5.type == "HasTypeIdBuffMoreThan" then
		slot9 = tonumber(slot3[3])
		slot11 = 0

		for slot15, slot16 in ipairs(slot7:getBuffList()) do
			if lua_skill_buff.configDict[slot16.buffId] and slot17.typeId == tonumber(slot3[2]) then
				slot11 = FightBuffHelper.isIncludeType(slot16.buffId, FightEnum.BuffIncludeTypes.Stacked) and slot11 + (slot16.layer and slot16.layer > 0 and slot16.layer or 1) or slot11 + 1
			end
		end

		return slot9 <= slot11
	elseif slot5.type == "EnemyNumIncludeSpMoreThan" then
		return tonumber(slot3[2]) <= #FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide)
	elseif slot5.type == "EnemyNumIncludeSpLessThan" then
		return tonumber(slot3[2]) >= #FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide)
	end
end

function slot0._getBuffTypeDic(slot0, slot1)
	for slot7, slot8 in ipairs(slot1:getBuffList()) do
		if lua_skill_buff.configDict[slot8.buffId] then
			-- Nothing
		end
	end

	return {
		[slot9.typeId] = true
	}
end

function slot0._getSimulateBuffTypeDic(slot0, slot1)
	for slot7, slot8 in ipairs(slot0:_simulateBuffList(slot1)) do
		if lua_skill_buff.configDict[slot8.buffId] then
			-- Nothing
		end
	end

	return {
		[slot9.typeId] = true
	}
end

function slot0._checkSkillRateUpBehavior(slot0, slot1, slot2)
	if string.nilorempty(slot1) then
		return
	end

	slot5 = lua_skill_behavior.configDict[tonumber(FightStrUtil.instance:getSplitCache(slot1, "#")[1])]

	if slot0:_getConditionTargetUid(slot2) == 0 then
		return false
	end

	if not FightDataHelper.entityMgr:getById(slot6) then
		return false
	end

	slot10 = slot0:_simulateBuffList(slot7)

	if slot5.type == "SkillRateUp1" and slot2 == 103 or slot5.type == "SkillRateUp2" and slot2 ~= 103 then
		for slot15, slot16 in ipairs(slot10) do
			if lua_skill_buff.configDict[slot16.buffId] and lua_skill_bufftype.configDict[slot17.typeId] and tabletool.indexOf(slot3[4] and FightStrUtil.instance:getSplitToNumberCache(slot3[4], ",") or {}, slot18.type) then
				return true
			end
		end
	end
end

function slot0._simulateBuffList(slot0, slot1)
	slot2 = slot1:getBuffList()

	for slot7, slot8 in ipairs(FightCardModel.instance:getCardOps()) do
		if slot8:isPlayCard() then
			slot9 = lua_skill.configDict[slot8.skillId]

			for slot13 = 1, FightEnum.MaxBehavior do
				slot15 = slot9["behavior" .. slot13]
				slot16 = slot9["behaviorTarget" .. slot13]
				slot17 = slot9["conditionTarget" .. slot13]

				if slot0:_checkCanAddBuff(slot9["condition" .. slot13]) and not string.nilorempty(slot15) then
					slot18 = slot16

					if slot16 == 0 then
						slot18 = slot9.logicTarget
					elseif slot16 == 999 then
						slot18 = slot17 ~= 0 and slot17 or slot9.logicTarget
					end

					slot0:_simulateSkillehavior(slot1, slot8, slot15, slot18, slot2)
				end
			end
		end
	end

	return slot2
end

function slot0._checkCanAddBuff(slot0, slot1)
	if string.nilorempty(slot1) then
		return
	end

	if #FightStrUtil.instance:getSplitCache(slot1, "&") > 1 then
		for slot7, slot8 in ipairs(slot2) do
			if slot0:_checkSingleConditionCanAddBuff(slot8) then
				slot3 = 0 + 1
			end
		end

		if slot3 == #slot2 then
			return true
		end
	elseif #FightStrUtil.instance:getSplitCache(slot1, "|") > 1 then
		for slot6, slot7 in ipairs(slot2) do
			if slot0:_checkSingleConditionCanAddBuff(slot7) then
				return true
			end
		end
	elseif slot0:_checkSingleConditionCanAddBuff(slot1) then
		return true
	end
end

function slot0._checkSingleConditionCanAddBuff(slot0, slot1)
	if not lua_skill_behavior_condition.configDict[tonumber(FightStrUtil.instance:getSplitCache(slot1, "#")[1])] or string.nilorempty(slot4.type) then
		return false
	end

	if slot4.type == "None" then
		return true
	end
end

function slot0._simulateSkillehavior(slot0, slot1, slot2, slot3, slot4, slot5)
	slot8 = lua_skill_behavior.configDict[FightStrUtil.instance:getSplitToNumberCache(slot3, "#")[1]]
	slot9 = false

	if FightEnum.LogicTargetClassify.Special[slot4] then
		-- Nothing
	elseif FightEnum.LogicTargetClassify.Single[slot4] then
		if slot2.toId == slot1.id then
			slot9 = true
		end
	elseif FightEnum.LogicTargetClassify.SingleAndRandom[slot4] then
		if slot2.toId == slot1.id then
			slot9 = true
		end
	elseif FightEnum.LogicTargetClassify.EnemySideAll[slot4] then
		if slot1.side == FightEnum.EntitySide.EnemySide then
			slot9 = true
		end
	elseif FightEnum.LogicTargetClassify.MySideAll[slot4] then
		if slot1.side == FightEnum.EntitySide.MySide then
			slot9 = true
		end
	elseif FightEnum.LogicTargetClassify.Me[slot4] and slot2.belongToEntityId == slot1.id then
		slot9 = true
	end

	if slot9 and slot8 then
		slot10 = nil

		if slot8.type == "AddBuff" then
			slot10 = slot6[2]
		elseif slot8.type == "CatapultBuff" then
			slot10 = slot6[5]
		end

		if slot10 then
			slot11 = FightBuffMO.New()
			slot11.uid = "9999"
			slot11.id = "9999"
			slot11.entityId = slot1.id
			slot11.buffId = slot10

			table.insert(slot5, slot11)
		end
	end
end

function slot0._onStageChange(slot0, slot1)
	if slot1 == FightEnum.Stage.Card then
		if not FightReplayModel.instance:isReplay() then
			slot0._long:SetLongPressTime(slot0._longPressArr)
			slot0._long:AddLongPressListener(slot0._onLongPress, slot0)

			if PCInputController.instance:getIsUse() then
				slot0._long:AddHoverListener(slot0._onHover, slot0)
			end

			slot0._rightClick:AddClickListener(slot0._onClickRight, slot0)
		end
	else
		slot0._long:RemoveLongPressListener()

		if PCInputController.instance:getIsUse() then
			slot0._long:RemoveHoverListener()
		end

		slot0._rightClick:RemoveClickListener()
	end

	slot0:_updateSpEffect()
end

function slot0.playLongPressEffect(slot0)
	TaskDispatcher.cancelTask(slot0._delayDisableAnim, slot0)
	TaskDispatcher.runDelay(slot0._delayDisableAnim, slot0, 1)
end

function slot0._delayDisableAnim(slot0)
	slot0:stopLongPressEffect()
end

function slot0.stopLongPressEffect(slot0)
	TaskDispatcher.cancelTask(slot0._delayDisableAnim, slot0)
	recthelper.setAnchor(slot0._forAnimGO.transform, 0, 0)
	transformhelper.setLocalRotation(slot0._forAnimGO.transform, 0, 0, 0)
end

function slot0._onClickThis(slot0)
	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DouQuQu) then
		return
	end

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.Enter) then
		return
	end

	if slot0._isLongPress and not PCInputController.instance:getIsUse() then
		slot0._isLongPress = false

		logNormal("has LongPress, can't click card")

		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightMoveCard) then
		logNormal("is Guiding, can't click card")

		return
	end

	if not FightDataHelper.stageMgr:isEmptyOperateState() and FightDataHelper.stageMgr:getCurOperateState() ~= FightStageMgr.OperateStateType.Discard then
		return
	end

	if FightDataHelper.stageMgr:getCurOperateState() == FightStageMgr.OperateStateType.Discard then
		if FightDataHelper.entityMgr:getById(slot0.cardInfoMO.uid) and slot1:isUniqueSkill(slot0.cardInfoMO.skillId) then
			return
		end

		FightDataHelper.stageMgr:exitOperateState(FightStageMgr.OperateStateType.Discard)
		FightController.instance:dispatchEvent(FightEvent.PlayDiscardEffect, slot0.index)

		return
	end

	if FightViewHandCard.blockOperate then
		logNormal("blockOperate, can't click card")

		return
	end

	if FightModel.instance:isAuto() then
		logNormal("Auto Fight, can't click card")

		return
	end

	if FightModel.instance:getCurStage() ~= FightEnum.Stage.Card then
		logNormal("stage = " .. FightModel.instance:getCurStageDesc() .. ", can't click card")

		return
	end

	if slot0._isDraging then
		return
	end

	if not FightCardDataHelper.canPlayCard(slot0.cardInfoMO) then
		return
	end

	if FightEnum.UniversalCard[slot0.cardInfoMO.skillId] then
		return
	end

	for slot6, slot7 in ipairs(FightCardModel.instance:getPlayCardOpList()) do
		slot2 = 0 + slot7.costActPoint
	end

	if FightCardModel.instance:getCardMO().actPoint <= slot2 then
		return
	end

	slot6 = #FightDataHelper.entityMgr:getMyNormalList() + #FightDataHelper.entityMgr:getSpList(FightEnum.EntitySide.MySide)

	if lua_skill.configDict[slot1] and FightEnum.ShowLogicTargetView[slot3.logicTarget] and slot3.targetLimit == FightEnum.TargetLimit.MySide then
		if slot6 > 1 then
			ViewMgr.instance:openView(ViewName.FightSkillTargetView, {
				fromId = slot0.cardInfoMO.uid,
				skillId = slot1,
				callback = slot0._toPlayCard,
				callbackObj = slot0
			})

			return
		end

		if slot6 == 1 then
			slot0:_toPlayCard(slot4[1].id)

			return
		end
	end

	slot0:_toPlayCard()
end

function slot0._toPlayCard(slot0, slot1, slot2)
	GuideController.instance:dispatchEvent(GuideEvent.SpecialEventDone, GuideEnum.SpecialEventEnum.FightCardOp)
	FightController.instance:dispatchEvent(FightEvent.BeforePlayHandCard, slot0.index, slot1)
	FightController.instance:dispatchEvent(FightEvent.PlayHandCard, slot0.index, slot1, slot2)
end

function slot0._onDragBegin(slot0, slot1, slot2)
	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DouQuQu) then
		return
	end

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.Enter) then
		return
	end

	if FightViewHandCard.blockOperate or FightModel.instance:isAuto() then
		return
	end

	if FightModel.instance:getCurStage() ~= FightEnum.Stage.Card then
		return
	end

	if not FightDataHelper.stageMgr:isEmptyOperateState() then
		return
	end

	if GuideModel.instance:getFlagValue(GuideModel.GuideFlag.FightMoveCard) and slot3.from and slot3.from ~= slot0.index then
		return
	end

	if not FightCardDataHelper.canMoveCard(slot0.cardInfoMO) then
		return
	end

	slot0._isDraging = true

	FightController.instance:dispatchEvent(FightEvent.DragHandCardBegin, slot0.index, slot2.position, slot0.cardInfoMO)
end

function slot0._onDragThis(slot0, slot1, slot2)
	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DouQuQu) then
		return
	end

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.Enter) then
		return
	end

	if FightViewHandCard.blockOperate or FightModel.instance:isAuto() then
		return
	end

	if FightModel.instance:getCurStage() ~= FightEnum.Stage.Card then
		return
	end

	if slot0._isDraging then
		FightController.instance:dispatchEvent(FightEvent.DragHandCard, slot0.index, slot2.position)
	end
end

function slot0._onDragEnd(slot0, slot1, slot2)
	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DouQuQu) then
		return
	end

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.Enter) then
		return
	end

	if FightViewHandCard.blockOperate or FightModel.instance:isAuto() then
		return
	end

	if FightModel.instance:getCurStage() ~= FightEnum.Stage.Card then
		return
	end

	if slot0._isDraging then
		slot0._isDraging = false

		FightController.instance:dispatchEvent(FightEvent.DragHandCardEnd, slot0.index, slot2.position)
		GuideController.instance:dispatchEvent(GuideEvent.SpecialEventDone, GuideEnum.SpecialEventEnum.FightCardOp)
	end
end

function slot0._onClickRight(slot0)
	GameGlobalMgr.instance:playTouchEffect()

	if FightCardModel.instance:getLongPressIndex() ~= slot0.index then
		FightController.instance:dispatchEvent(FightEvent.LongPressHandCardEnd)
		slot0:_onLongPress()

		slot0._isLongPress = false
	end
end

function slot0._onLongPress(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rolesgo)

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightForbidLongPressCard) then
		return
	end

	if FightViewHandCard.blockOperate or FightModel.instance:isAuto() then
		return
	end

	if FightModel.instance:getCurStage() ~= FightEnum.Stage.Card then
		return
	end

	if not FightDataHelper.stageMgr:isEmptyOperateState() then
		if FightDataHelper.stageMgr:getCurOperateState() == FightStageMgr.OperateStateType.Discard then
			return
		end

		if FightDataHelper.stageMgr:getCurOperateState() == FightStageMgr.OperateStateType.DiscardEffect then
			return
		end
	end

	if not slot0._isDraging then
		slot0._isLongPress = true

		FightController.instance:dispatchEvent(FightEvent.LongPressHandCard, slot0.index)
	end
end

function slot0._onHover(slot0)
	if GuideController.instance:isGuiding() then
		return
	end

	if not slot0._isLongPress then
		slot0:_onLongPress()
	end
end

function slot0._simulateDragHandCardBegin(slot0, slot1)
	if not slot0.cardInfoMO then
		return
	end

	if slot0.index ~= slot1 then
		return
	end

	slot0:_onDragBegin(nil, {
		position = recthelper.uiPosToScreenPos(slot0.tr)
	})
end

function slot0._simulateDragHandCard(slot0, slot1, slot2)
	if not slot0.cardInfoMO then
		return
	end

	if slot0.index ~= slot1 then
		return
	end

	if slot0._subViewInst:getHandCardItem(slot2) then
		slot0:_onDragThis(nil, {
			position = recthelper.uiPosToScreenPos(slot3.tr)
		})
	end
end

function slot0._simulateDragHandCardEnd(slot0, slot1, slot2)
	if not slot0.cardInfoMO then
		return
	end

	if slot0.index ~= slot1 then
		return
	end

	slot0._isDraging = true

	slot0:_onDragEnd(nil, {
		position = recthelper.uiPosToScreenPos(slot0.tr)
	})
end

function slot0._simulatePlayHandCard(slot0, slot1, slot2, slot3)
	if not slot0.cardInfoMO then
		return
	end

	if slot0.index ~= slot1 then
		return
	end

	slot0:_toPlayCard(slot2, slot3)
end

function slot0.playCardAni(slot0, slot1, slot2)
	slot0._cardAniName = slot2 or UIAnimationName.Open

	slot0._loader:loadAsset(slot1, slot0._onCardAniLoaded, slot0)
end

function slot0._onCardAniLoaded(slot0, slot1)
	slot0._cardAni.runtimeAnimatorController = slot1:GetResource()
	slot0._cardAni.enabled = true
	slot0._cardAni.speed = FightModel.instance:getUISpeed()

	gohelper.setActive(slot0.go, true)
	SLFramework.AnimatorPlayer.Get(slot0._innerGO):Play(slot0._cardAniName, slot0._onCardAniFinish, slot0)
end

function slot0._onCardAniFinish(slot0)
	slot0._cardAni.enabled = false

	slot0:_hideEffect()
end

function slot0.playAni(slot0, slot1, slot2)
	slot0._aniName = slot2 or UIAnimationName.Open

	slot0._loader:loadAsset(slot1, slot0._onAniLoaded, slot0)
end

function slot0._onAniLoaded(slot0, slot1)
	slot0._foranim.runtimeAnimatorController = slot1:GetResource()
	slot0._foranim.enabled = true
	slot0._foranim.speed = FightModel.instance:getUISpeed()

	gohelper.setActive(slot0.go, true)
	SLFramework.AnimatorPlayer.Get(slot0._forAnimGO):Play(slot0._aniName, slot0._onAniFinish, slot0)
end

function slot0._onAniFinish(slot0)
	slot0._foranim.enabled = false
end

function slot0._hideEffect(slot0)
	gohelper.setActive(gohelper.findChild(slot0._innerGO, "vx_balance"), false)
end

function slot0._onRefreshOneHandCard(slot0, slot1)
	if not slot0.cardInfoMO then
		return
	end

	if slot1 == slot0.index then
		slot0:updateItem(slot0.index, slot0.cardInfoMO)
	end
end

function slot0._onGMForceRefreshNameUIBuff(slot0)
	slot0:_onRefreshOneHandCard(slot0.index)
end

function slot0.playDistribute(slot0)
	if not slot0._distributeFlow then
		slot0._distributeFlow = FlowSequence.New()

		slot0._distributeFlow:addWork(FigthCardDistributeEffect.New())
	else
		slot0._distributeFlow:stop()
	end

	slot1 = slot0:getUserDataTb_()
	slot1.cards = tabletool.copy(FightCardModel.instance:getHandCards())
	slot1.handCardItemList = slot0._subViewInst._handCardItemList
	slot1.preCardCount = #slot1.cards - 1
	slot1.newCardCount = 1

	slot0._distributeFlow:start(slot1)
end

function slot0.playMasterAddHandCard(slot0)
	if not slot0._masterAddHandCardFlow then
		slot0._masterAddHandCardFlow = FlowSequence.New()

		slot0._masterAddHandCardFlow:addWork(FigthMasterAddHandCardEffect.New())
	else
		slot0._masterAddHandCardFlow:stop()
	end

	slot1 = slot0:getUserDataTb_()
	slot1.card = slot0

	slot0._masterAddHandCardFlow:start(slot1)
end

function slot0.playMasterCardRemove(slot0)
	if not slot0._masterCardRemoveFlow then
		slot0._masterCardRemoveFlow = FlowSequence.New()

		slot0._masterCardRemoveFlow:addWork(FigthMasterCardRemoveEffect.New())
	else
		slot0._masterCardRemoveFlow:stop()
	end

	slot1 = slot0:getUserDataTb_()
	slot1.card = slot0

	slot0._masterCardRemoveFlow:start(slot1)
end

function slot0.dissolveEntityCard(slot0, slot1)
	if not slot0.cardInfoMO then
		return
	end

	if slot0.cardInfoMO.uid ~= slot1 then
		return
	end

	slot0:dissolveCard()

	return true
end

function slot0.dissolveCard(slot0)
	if not slot0.go.activeInHierarchy then
		return
	end

	slot0:setASFDActive(false)
	slot0._cardItem:dissolveCard(transformhelper.getLocalScale(slot0._subViewInst._handCardContainer.transform))
end

function slot0.moveSelfPos(slot0, slot1, slot2)
	slot0:_releaseMoveFlow()

	slot0._moveCardFlow = FlowParallel.New()
	slot3 = 0.033 / FightModel.instance:getUISpeed()
	slot4 = slot0.go.transform
	slot5 = FlowSequence.New()

	slot5:addWork(WorkWaitSeconds.New(3 * slot2 * slot3))

	slot6 = FightViewHandCard.calcCardPosX(slot1)

	slot5:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = slot4,
		to = slot6 + 10,
		t = slot3 * 5
	}))
	slot5:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = slot4,
		to = slot6,
		t = slot3 * 2
	}))
	slot0._moveCardFlow:addWork(slot5)
	slot0._moveCardFlow:start()
end

function slot0.playCardLevelChange(slot0, slot1, slot2)
	if not slot0.cardInfoMO then
		return
	end

	if not slot0.go.activeInHierarchy then
		return
	end

	gohelper.setActive(slot0._lockGO, false)

	slot0.cardInfoMO = slot1

	slot0._cardItem:playCardLevelChange(slot1, slot2)
end

function slot0._onCardLevelChangeDone(slot0, slot1)
	if slot1 == slot0.cardInfoMO then
		gohelper.setActive(slot0._lockGO, true)
		slot0:updateItem(slot0.index, slot0.cardInfoMO)
	end
end

function slot0.playCardAConvertCardB(slot0)
	if not slot0.cardInfoMO then
		return
	end

	gohelper.setActive(slot0._cardConvertEffect, true)
	TaskDispatcher.cancelTask(slot0._afterConvertCardEffect, slot0)

	if slot0._convertEffect then
		slot2 = slot0._convertEffect.transform.childCount
		slot4 = nil

		if FightCardModel.instance:isUniqueSkill(slot0.cardInfoMO.uid, slot0.cardInfoMO.skillId) then
			for slot8 = 0, slot2 - 1 do
				slot9 = slot1:GetChild(slot8).gameObject

				if slot8 == 3 then
					gohelper.setActive(slot9, true)

					slot4 = gohelper.onceAddComponent(slot9, typeof(UnityEngine.Animation))
				else
					gohelper.setActive(slot9, false)
				end
			end
		else
			for slot9 = 0, slot2 - 1 do
				slot10 = slot1:GetChild(slot9).gameObject

				if slot9 + 1 == FightCardModel.instance:getSkillLv(slot0.cardInfoMO.uid, slot0.cardInfoMO.skillId) then
					gohelper.setActive(slot10, true)

					slot4 = gohelper.onceAddComponent(slot10, typeof(UnityEngine.Animation))
				else
					gohelper.setActive(slot10, false)
				end
			end
		end

		if slot4 then
			slot4.this:get(slot4.clip.name).speed = FightModel.instance:getUISpeed()
		end

		TaskDispatcher.runDelay(slot0._afterConvertCardEffect, slot0, FightEnum.PerformanceTime.CardAConvertCardB / FightModel.instance:getUISpeed())
	else
		slot0._loader:loadAsset("ui/viewres/fight/card_intensive.prefab", slot0._onCardAConvertCardBLoaded, slot0)
	end
end

function slot0._onCardAConvertCardBLoaded(slot0, slot1)
	slot0._convertEffect = gohelper.clone(slot1:GetResource(), slot0._cardConvertEffect)

	slot0:playCardAConvertCardB()
	TaskDispatcher.runDelay(slot0._afterConvertCardEffect, slot0, FightEnum.PerformanceTime.CardAConvertCardB / FightModel.instance:getUISpeed())
end

function slot0._afterConvertCardEffect(slot0)
	gohelper.setActive(slot0._cardConvertEffect, false)
end

function slot0.changeToTempCard(slot0)
	slot0._cardItem:changeToTempCard()
end

function slot0.getASFDScreenPos(slot0)
	return slot0._cardItem:getASFDScreenPos()
end

function slot0.refreshPreDeleteImage(slot0, slot1)
	if slot0._cardItem then
		slot0._cardItem:_refreshPreDeleteImage(slot1)
	end
end

function slot0.setActiveRed(slot0, slot1)
	if slot0._cardItem then
		slot0._cardItem:setActiveRed(slot1)
	end
end

function slot0.setActiveBlue(slot0, slot1)
	if slot0._cardItem then
		slot0._cardItem:setActiveBlue(slot1)
	end
end

function slot0.setActiveBoth(slot0, slot1)
	if slot0._cardItem then
		slot0._cardItem:setActiveBoth(slot1)
	end
end

function slot0.resetRedAndBlue(slot0)
	if slot0._cardItem then
		slot0._cardItem:resetRedAndBlue()
	end
end

function slot0._releaseMoveFlow(slot0)
	if slot0._moveCardFlow then
		slot0._moveCardFlow:stop()

		slot0._moveCardFlow = nil
	end
end

function slot0.releaseSelf(slot0)
	TaskDispatcher.cancelTask(slot0._afterConvertCardEffect, slot0)

	if slot0._distributeFlow then
		slot0._distributeFlow:stop()

		slot0._distributeFlow = nil
	end

	if slot0._dissolveFlow then
		slot0._dissolveFlow:stop()

		slot0._dissolveFlow = nil
	end

	if slot0._masterAddHandCardFlow then
		slot0._masterAddHandCardFlow:stop()

		slot0._masterAddHandCardFlow = nil
	end

	if slot0._masterCardRemoveFlow then
		slot0._masterCardRemoveFlow:stop()

		slot0._masterCardRemoveFlow = nil
	end

	slot0:_releaseMoveFlow()

	if slot0._loader then
		slot0._loader:releaseSelf()

		slot0._loader = nil
	end
end

return slot0
