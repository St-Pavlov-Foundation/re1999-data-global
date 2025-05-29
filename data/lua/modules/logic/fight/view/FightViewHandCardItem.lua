module("modules.logic.fight.view.FightViewHandCardItem", package.seeall)

local var_0_0 = class("FightViewHandCardItem", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._subViewInst = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0.tr = arg_2_1.transform
	arg_2_0._cardItemAni = gohelper.onceAddComponent(arg_2_0.go, typeof(UnityEngine.Animator))
	arg_2_0._forAnimGO = gohelper.findChild(arg_2_1, "foranim")

	local var_2_0 = arg_2_0._subViewInst.viewContainer:getSetting().otherRes[1]

	arg_2_0._innerGO = arg_2_0._subViewInst:getResInst(var_2_0, arg_2_0._forAnimGO, "card")

	gohelper.setAsFirstSibling(arg_2_0._innerGO)

	arg_2_0._cardItem = MonoHelper.addNoUpdateLuaComOnceToGo(arg_2_0._innerGO, FightViewCardItem, FightEnum.CardShowType.HandCard)
	arg_2_0._cardAni = arg_2_0._innerGO:GetComponent(typeof(UnityEngine.Animator))
	arg_2_0._cardAni.enabled = false
	arg_2_0._innerTr = arg_2_0._innerGO.transform
	arg_2_0._universalGO = gohelper.findChild(arg_2_0._forAnimGO, "universal")
	arg_2_0._spEffectGO = gohelper.findChild(arg_2_0._forAnimGO, "spEffect")
	arg_2_0._foranim = arg_2_0._forAnimGO:GetComponent(typeof(UnityEngine.Animator))
	arg_2_0._itemWidth = recthelper.getWidth(arg_2_0.tr)
	arg_2_0._oldParentX = -999999
	arg_2_0._click = SLFramework.UGUI.UIClickListener.Get(arg_2_0.go)
	arg_2_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_2_0.go)
	arg_2_0._long = SLFramework.UGUI.UILongPressListener.Get(arg_2_0.go)
	arg_2_0._rightClick = SLFramework.UGUI.UIRightClickListener.Get(arg_2_0.go)
	arg_2_0._longPressArr = {
		0.5,
		99999
	}
	arg_2_0._isDraging = false
	arg_2_0._isLongPress = false

	arg_2_0:setUniversal(false)

	arg_2_0._keyOffset = 8
	arg_2_0._keyMaxTipsNum = 9
	arg_2_0._restrainComp = MonoHelper.addLuaComOnceToGo(arg_2_0.go, FightViewHandCardItemRestrain, arg_2_0)
	arg_2_0._lockComp = MonoHelper.addLuaComOnceToGo(arg_2_0.go, FightViewHandCardItemLock, arg_2_0)
	arg_2_0._loader = arg_2_0._loader or LoaderComponent.New()
	arg_2_0._lockGO = gohelper.findChild(arg_2_0.go, "foranim/lock")
	arg_2_0._cardConvertEffect = gohelper.findChild(arg_2_0.go, "foranim/cardConvertEffect")

	arg_2_0:setASFDActive(true)
end

function var_0_0.addEventListeners(arg_3_0)
	if not FightReplayModel.instance:isReplay() then
		arg_3_0._click:AddClickListener(arg_3_0._onClickThis, arg_3_0)
		arg_3_0._drag:AddDragBeginListener(arg_3_0._onDragBegin, arg_3_0)
		arg_3_0._drag:AddDragListener(arg_3_0._onDragThis, arg_3_0)
		arg_3_0._drag:AddDragEndListener(arg_3_0._onDragEnd, arg_3_0)
	end

	arg_3_0:addEventCb(FightController.instance, FightEvent.SelectSkillTarget, arg_3_0._onSelectSkillTarget, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.OnStageChange, arg_3_0._onStageChange, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, arg_3_0._onBuffUpdate, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.DragHandCardBegin, arg_3_0._onDragHandCardBegin, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.DragHandCardEnd, arg_3_0._onDragHandCardEnd, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.SimulateDragHandCardBegin, arg_3_0._simulateDragHandCardBegin, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.SimulateDragHandCard, arg_3_0._simulateDragHandCard, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.SimulateDragHandCardEnd, arg_3_0._simulateDragHandCardEnd, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.SimulatePlayHandCard, arg_3_0._simulatePlayHandCard, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.StartReplay, arg_3_0._checkStartReplay, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.RefreshOneHandCard, arg_3_0._onRefreshOneHandCard, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.RefreshHandCardMO, arg_3_0._onRefreshHandCardMO, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.CardLevelChangeDone, arg_3_0._onCardLevelChangeDone, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.GMForceRefreshNameUIBuff, arg_3_0._onGMForceRefreshNameUIBuff, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.SeasonSelectChangeHeroTarget, arg_3_0._onSeasonSelectChangeHeroTarget, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.ExitOperateState, arg_3_0._onExitOperateState, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.CancelOperation, arg_3_0._onCancelOperation, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.ASFD_AllocateCardEnergyDone, arg_3_0._allocateEnergyDone, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.PlayCardOver, arg_3_0._showASFD, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0._click:RemoveClickListener()
	arg_4_0._drag:RemoveDragBeginListener()
	arg_4_0._drag:RemoveDragListener()
	arg_4_0._drag:RemoveDragEndListener()
	arg_4_0._long:RemoveLongPressListener()

	if PCInputController.instance:getIsUse() then
		arg_4_0._long:RemoveHoverListener()
	end

	arg_4_0._rightClick:RemoveClickListener()
	arg_4_0:removeEventCb(FightController.instance, FightEvent.SelectSkillTarget, arg_4_0._onSelectSkillTarget, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.OnStageChange, arg_4_0._onStageChange, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.OnBuffUpdate, arg_4_0._onBuffUpdate, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.DragHandCardBegin, arg_4_0._onDragHandCardBegin, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.DragHandCardEnd, arg_4_0._onDragHandCardEnd, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.SimulateDragHandCardBegin, arg_4_0._simulateDragHandCardBegin, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.SimulateDragHandCard, arg_4_0._simulateDragHandCard, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.SimulateDragHandCardEnd, arg_4_0._simulateDragHandCardEnd, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.SimulatePlayHandCard, arg_4_0._simulatePlayHandCard, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.StartReplay, arg_4_0._checkStartReplay, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.RefreshOneHandCard, arg_4_0._onRefreshOneHandCard, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.RefreshHandCardMO, arg_4_0._onRefreshHandCardMO, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.CardLevelChangeDone, arg_4_0._onCardLevelChangeDone, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.GMForceRefreshNameUIBuff, arg_4_0._onGMForceRefreshNameUIBuff, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.SeasonSelectChangeHeroTarget, arg_4_0._onSeasonSelectChangeHeroTarget, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.ExitOperateState, arg_4_0._onExitOperateState, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.CancelOperation, arg_4_0._onCancelOperation, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.ASFD_AllocateCardEnergyDone, arg_4_0._allocateEnergyDone, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.PlayCardOver, arg_4_0._showASFD, arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._delayDisableAnim, arg_4_0)
end

function var_0_0._allocateEnergyDone(arg_5_0)
	if arg_5_0._cardItem then
		arg_5_0._cardItem:_allocateEnergyDone()
	end
end

function var_0_0._showASFD(arg_6_0)
	arg_6_0:setASFDActive(true)
end

function var_0_0._onCancelOperation(arg_7_0)
	arg_7_0:setASFDActive(true)
end

function var_0_0._onSeasonSelectChangeHeroTarget(arg_8_0, arg_8_1)
	if arg_8_0.cardInfoMO and arg_8_0.cardInfoMO.uid == arg_8_1 then
		arg_8_0._seasonChangeHeroSelecting = true

		arg_8_0._cardItemAni:Play("preview")
	elseif arg_8_0._seasonChangeHeroSelecting then
		arg_8_0._cardItemAni:Play("idle")

		arg_8_0._seasonChangeHeroSelecting = false
	end
end

function var_0_0._onExitOperateState(arg_9_0)
	if arg_9_0._seasonChangeHeroSelecting then
		arg_9_0._cardItemAni:Play("idle")

		arg_9_0._seasonChangeHeroSelecting = false
	end
end

function var_0_0.setASFDActive(arg_10_0, arg_10_1)
	if arg_10_0._cardItem then
		arg_10_0._cardItem:setASFDActive(arg_10_1)
	end
end

function var_0_0.playASFDAnim(arg_11_0, arg_11_1)
	if arg_11_0._cardItem then
		arg_11_0._cardItem:playASFDAnim(arg_11_1)
	end
end

function var_0_0.onStart(arg_12_0)
	local var_12_0 = FightModel.instance:getCurStage()

	if var_12_0 then
		arg_12_0:_onStageChange(var_12_0)
	end

	arg_12_0:_checkStartReplay()
end

function var_0_0._checkStartReplay(arg_13_0)
	if FightReplayModel.instance:isReplay() then
		arg_13_0._click:RemoveClickListener()
		arg_13_0._drag:RemoveDragBeginListener()
		arg_13_0._drag:RemoveDragListener()
		arg_13_0._drag:RemoveDragEndListener()
		arg_13_0._long:RemoveLongPressListener()
		arg_13_0._long:RemoveHoverListener()
		arg_13_0._rightClick:RemoveClickListener()
	end
end

function var_0_0.setUniversal(arg_14_0, arg_14_1)
	gohelper.setActive(arg_14_0._universalGO, arg_14_1)
end

function var_0_0.refreshPreDelete(arg_15_0, arg_15_1)
	if arg_15_1 then
		-- block empty
	end
end

function var_0_0.updateItem(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0.index = arg_16_1 or arg_16_0.index

	if arg_16_2 then
		arg_16_0.cardInfoMO = arg_16_2
		arg_16_2.custom_handCardIndex = arg_16_0.index

		if not lua_skill.configDict[arg_16_2.skillId] then
			logError("skill not exist: " .. arg_16_2.skillId)

			return
		end

		arg_16_0._cardItem:updateItem(arg_16_2.uid, arg_16_2.skillId, arg_16_2)

		arg_16_0._isDraging = false
		arg_16_0._isLongPress = false
		arg_16_0._skillId = arg_16_2.skillId

		arg_16_0:setUniversal(false)
		arg_16_0:_updateSpEffect()
		arg_16_0._restrainComp:updateItem(arg_16_2)
		arg_16_0._lockComp:updateItem(arg_16_2)
		arg_16_0._cardItem:updateResistanceByCardInfo(arg_16_2)
	end

	arg_16_0:_hideEffect()
	arg_16_0:_refreshBlueStar()
	arg_16_0:showKeytips()
	arg_16_0:showCardHeat()
end

function var_0_0.showCardHeat(arg_17_0)
	arg_17_0._cardItem:showCardHeat()
end

function var_0_0.showKeytips(arg_18_0)
	local var_18_0 = gohelper.findChild(arg_18_0.go, "foranim/card/#go_pcbtn")
	local var_18_1 = #FightCardModel.instance:getHandCards()

	if var_18_1 == 0 then
		return
	end

	local var_18_2 = var_18_1 - arg_18_0.index + 1

	if var_18_2 >= 1 and var_18_2 <= var_18_1 and var_18_2 <= arg_18_0._keyMaxTipsNum then
		if not arg_18_0._pcTips then
			arg_18_0._pcTips = PCInputController.instance:showkeyTips(var_18_0, PCInputModel.Activity.battle, var_18_2 + arg_18_0._keyOffset)
		else
			arg_18_0._pcTips:Refresh(PCInputModel.Activity.battle, var_18_2 + arg_18_0._keyOffset)
		end

		if arg_18_0._pcTips == nil then
			return
		end

		if arg_18_0._cardItem and arg_18_0._cardItem:IsUniqueSkill() then
			recthelper.setAnchorY(arg_18_0._pcTips._go.transform, 200)
		else
			recthelper.setAnchorY(arg_18_0._pcTips._go.transform, 150)
		end

		arg_18_0._pcTips:Show(true)
	elseif arg_18_0._pcTips then
		arg_18_0._pcTips:Show(false)
	end
end

function var_0_0.refreshCardMO(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0.index = arg_19_1
	arg_19_0.cardInfoMO = arg_19_2
end

function var_0_0._onRefreshHandCardMO(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0:refreshCardMO(arg_20_1, arg_20_2)
end

function var_0_0.onLongPressEnd(arg_21_0)
	arg_21_0._isLongPress = false
end

function var_0_0.getCardItem(arg_22_0)
	return arg_22_0._cardItem
end

function var_0_0._onBuffUpdate(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	if not arg_23_0.cardInfoMO then
		return
	end

	if arg_23_1 ~= arg_23_0.cardInfoMO.uid then
		return
	end

	arg_23_0:_updateSpEffect()

	if arg_23_2 ~= FightEnum.EffectType.BUFFUPDATE and FightConfig.instance:hasBuffFeature(arg_23_3, FightEnum.BuffFeature.SkillLevelJudgeAdd) then
		arg_23_0:_refreshBlueStar()
	end
end

function var_0_0._refreshBlueStar(arg_24_0)
	local var_24_0 = arg_24_0.cardInfoMO and arg_24_0.cardInfoMO.uid
	local var_24_1 = arg_24_0.cardInfoMO and arg_24_0.cardInfoMO.skillId
	local var_24_2 = var_24_0 and var_24_1 and FightCardModel.instance:getSkillLv(var_24_0, var_24_1)

	arg_24_0._cardItem:showBlueStar(var_24_2)
end

function var_0_0._onDragHandCardBegin(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	if not arg_25_0.cardInfoMO then
		return
	end

	if not FightEnum.UniversalCard[arg_25_3.skillId] or arg_25_3 == arg_25_0.cardInfoMO then
		return
	end

	local var_25_0 = FightCardModel.instance:getSkillLv(arg_25_3.uid, arg_25_3.skillId)
	local var_25_1 = FightCardModel.instance:getSkillLv(arg_25_0.cardInfoMO.uid, arg_25_0.cardInfoMO.skillId)

	if var_25_1 <= var_25_0 then
		return
	end

	local var_25_2 = gohelper.findChild(arg_25_0._forAnimGO, "universalMask")

	gohelper.setActive(var_25_2, true)

	for iter_25_0 = 1, 4 do
		local var_25_3 = gohelper.findChild(var_25_2, "jinengpai_" .. iter_25_0)

		gohelper.setActive(var_25_3, iter_25_0 == var_25_1)
	end
end

function var_0_0._onDragHandCardEnd(arg_26_0)
	local var_26_0 = gohelper.findChild(arg_26_0._forAnimGO, "universalMask")

	gohelper.setActive(var_26_0, false)
end

function var_0_0._onSelectSkillTarget(arg_27_0)
	arg_27_0:_updateSpEffect()
end

function var_0_0._updateSpEffect(arg_28_0)
	if gohelper.isNil(arg_28_0._spEffectGO) then
		return
	end

	if not arg_28_0.cardInfoMO then
		return
	end

	local var_28_0 = lua_skill.configDict[arg_28_0._skillId]
	local var_28_1 = FightModel.instance:getCurStage()

	if var_28_1 ~= FightEnum.Stage.Card and var_28_1 ~= FightEnum.Stage.AutoCard then
		gohelper.setActive(arg_28_0._spEffectGO, false)

		return
	end

	local var_28_2 = false
	local var_28_3 = {}

	for iter_28_0, iter_28_1 in ipairs(FightStrUtil.instance:getSplitToNumberCache(var_28_0.clientIgnoreCondition, "#")) do
		var_28_3[iter_28_1] = true
	end

	for iter_28_2 = 1, FightEnum.MaxBehavior do
		if not var_28_3[iter_28_2] then
			local var_28_4 = var_28_0["condition" .. iter_28_2]
			local var_28_5 = var_28_0["conditionTarget" .. iter_28_2]
			local var_28_6 = var_28_0["behavior" .. iter_28_2]

			if arg_28_0:_checkConditionSpEffect(var_28_4, var_28_5) or arg_28_0:_checkSkillRateUpBehavior(var_28_6, var_28_5) then
				var_28_2 = true

				break
			end
		end
	end

	if var_28_2 ~= arg_28_0._spEffectGO.activeSelf then
		gohelper.setActive(arg_28_0._spEffectGO, var_28_2)
	end
end

function var_0_0._getConditionTargetUid(arg_29_0, arg_29_1)
	if arg_29_1 == 103 then
		return arg_29_0.cardInfoMO.uid
	elseif arg_29_1 == 0 then
		return FightCardModel.instance.curSelectEntityId
	elseif arg_29_1 == 202 then
		for iter_29_0, iter_29_1 in ipairs(FightDataHelper.entityMgr:getEnemyNormalList()) do
			return iter_29_1.id
		end
	end
end

function var_0_0._getConditionTargetUids(arg_30_0, arg_30_1)
	if arg_30_1 == 103 then
		return {
			arg_30_0.cardInfoMO.uid
		}
	elseif arg_30_1 == 0 then
		return {
			FightCardModel.instance.curSelectEntityId
		}
	elseif arg_30_1 == 202 then
		local var_30_0 = {}

		for iter_30_0, iter_30_1 in ipairs(FightDataHelper.entityMgr:getEnemyNormalList()) do
			table.insert(var_30_0, iter_30_1.id)
		end

		return var_30_0
	end

	return {}
end

function var_0_0._checkConditionSpEffect(arg_31_0, arg_31_1, arg_31_2)
	if string.nilorempty(arg_31_1) then
		return
	end

	local var_31_0 = FightStrUtil.instance:getSplitCache(arg_31_1, "&")

	if #var_31_0 > 1 then
		local var_31_1 = 0

		for iter_31_0, iter_31_1 in ipairs(var_31_0) do
			if arg_31_0:_checkSingleCondition(iter_31_1, arg_31_2) then
				var_31_1 = var_31_1 + 1
			end
		end

		if var_31_1 == #var_31_0 then
			return true
		end
	else
		local var_31_2 = FightStrUtil.instance:getSplitCache(arg_31_1, "|")

		if #var_31_2 > 1 then
			for iter_31_2, iter_31_3 in ipairs(var_31_2) do
				if arg_31_0:_checkSingleCondition(iter_31_3, arg_31_2) then
					return true
				end
			end
		elseif arg_31_0:_checkSingleCondition(arg_31_1, arg_31_2) then
			return true
		end
	end
end

function var_0_0._checkSingleCondition(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = FightStrUtil.instance:getSplitCache(arg_32_1, "#")
	local var_32_1 = tonumber(var_32_0[1])
	local var_32_2 = lua_skill_behavior_condition.configDict[var_32_1]

	if not var_32_2 or string.nilorempty(var_32_2.type) then
		return false
	end

	local var_32_3 = arg_32_0:_getConditionTargetUid(arg_32_2)

	if not var_32_3 or tostring(var_32_3) == "0" then
		return false
	end

	local var_32_4 = FightDataHelper.entityMgr:getById(var_32_3)

	if not var_32_4 then
		return false
	end

	if var_32_2.type == "LifeLess" then
		return tonumber(var_32_0[2]) * 0.001 > var_32_4.currentHp / var_32_4.attrMO.hp
	elseif var_32_2.type == "LifeMore" then
		return tonumber(var_32_0[2]) * 0.001 < var_32_4.currentHp / var_32_4.attrMO.hp
	elseif var_32_2.type == "HasBuffId" then
		local var_32_5 = arg_32_0:_getSimulateBuffTypeDic(var_32_4)

		for iter_32_0 = 2, #var_32_0 do
			local var_32_6 = tonumber(var_32_0[iter_32_0])

			if var_32_6 and var_32_5[var_32_6] then
				return true
			end
		end
	elseif var_32_2.type == "HasBuff" then
		local var_32_7 = arg_32_0:_getSimulateBuffTypeDic(var_32_4)
		local var_32_8 = {}

		for iter_32_1, iter_32_2 in pairs(var_32_7) do
			local var_32_9 = lua_skill_bufftype.configDict[iter_32_1]

			if var_32_9 then
				var_32_8[var_32_9.type] = true
			end
		end

		for iter_32_3 = 2, #var_32_0 do
			local var_32_10 = tonumber(var_32_0[iter_32_3])

			if var_32_10 and var_32_8[var_32_10] then
				return true
			end
		end
	elseif var_32_2.type == "HasBuffGroup" then
		local var_32_11 = arg_32_0:_getSimulateBuffTypeDic(var_32_4)
		local var_32_12 = {}

		for iter_32_4, iter_32_5 in pairs(var_32_11) do
			local var_32_13 = lua_skill_bufftype.configDict[iter_32_4]

			if var_32_13 then
				var_32_12[var_32_13.group] = true
			end
		end

		for iter_32_6 = 2, #var_32_0 do
			local var_32_14 = tonumber(var_32_0[iter_32_6])

			if var_32_14 and var_32_12[var_32_14] then
				return true
			end
		end
	elseif var_32_2.type == "NoBuffId" then
		local var_32_15 = arg_32_0:_getBuffTypeDic(var_32_4)
		local var_32_16 = FightStrUtil.instance:getSplitCache(var_32_0[2], ",")

		if #var_32_16 > 1 then
			for iter_32_7 = 1, #var_32_16 do
				local var_32_17 = tonumber(var_32_16[iter_32_7])

				if var_32_17 and var_32_15[var_32_17] then
					return false
				end
			end
		else
			for iter_32_8 = 2, #var_32_0 do
				local var_32_18 = tonumber(var_32_0[iter_32_8])

				if var_32_18 and var_32_15[var_32_18] then
					return false
				end
			end
		end

		return true
	elseif var_32_2.type == "NoBuff" then
		local var_32_19 = arg_32_0:_getBuffTypeDic(var_32_4)
		local var_32_20 = {}

		for iter_32_9, iter_32_10 in pairs(var_32_19) do
			local var_32_21 = lua_skill_bufftype.configDict[iter_32_9]

			if var_32_21 then
				var_32_20[var_32_21.type] = true
			end
		end

		local var_32_22 = FightStrUtil.instance:getSplitCache(var_32_0[2], ",")

		if #var_32_22 > 1 then
			for iter_32_11 = 1, #var_32_22 do
				local var_32_23 = tonumber(var_32_22[iter_32_11])

				if var_32_23 and var_32_20[var_32_23] then
					return false
				end
			end
		else
			for iter_32_12 = 2, #var_32_0 do
				local var_32_24 = tonumber(var_32_0[iter_32_12])

				if var_32_24 and var_32_20[var_32_24] then
					return false
				end
			end
		end

		return true
	elseif var_32_2.type == "NoBuffGroup" then
		local var_32_25 = arg_32_0:_getBuffTypeDic(var_32_4)
		local var_32_26 = {}

		for iter_32_13, iter_32_14 in pairs(var_32_25) do
			local var_32_27 = lua_skill_bufftype.configDict[iter_32_13]

			if var_32_27 then
				var_32_26[var_32_27.group] = true
			end
		end

		local var_32_28 = FightStrUtil.instance:getSplitCache(var_32_0[2], ",")

		if #var_32_28 > 1 then
			for iter_32_15 = 1, #var_32_28 do
				local var_32_29 = tonumber(var_32_28[iter_32_15])

				if var_32_29 and var_32_26[var_32_29] then
					return false
				end
			end
		else
			for iter_32_16 = 2, #var_32_0 do
				local var_32_30 = tonumber(var_32_0[iter_32_16])

				if var_32_30 and var_32_26[var_32_30] then
					return false
				end
			end
		end

		return true
	elseif var_32_2.type == "PowerCompare" then
		local var_32_31 = var_32_4:getPowerInfo(tonumber(var_32_0[3]))

		if var_32_31 then
			if var_32_0[2] == "1" then
				return var_32_31.num >= tonumber(var_32_0[4])
			end
		else
			return false
		end
	elseif var_32_2.type == "TypeIdBuffCountMoreThan" then
		local var_32_32 = tonumber(var_32_0[2])
		local var_32_33 = tonumber(var_32_0[3])
		local var_32_34 = var_32_4:getBuffList()

		for iter_32_17, iter_32_18 in ipairs(var_32_34) do
			local var_32_35 = lua_skill_buff.configDict[iter_32_18.buffId]

			if var_32_35 and var_32_35.typeId == var_32_32 and var_32_33 <= (iter_32_18.layer and iter_32_18.layer > 0 and iter_32_18.layer or 1) then
				return true
			end
		end
	elseif var_32_2.type == "SelfTeamHasBuffTypeLayerMoreThan" then
		local var_32_36 = arg_32_0:_getConditionTargetUids(arg_32_2)
		local var_32_37 = tonumber(var_32_0[3])
		local var_32_38 = tonumber(var_32_0[2])
		local var_32_39 = 0

		for iter_32_19, iter_32_20 in ipairs(var_32_36) do
			local var_32_40 = FightDataHelper.entityMgr:getById(iter_32_20):getBuffList()

			for iter_32_21, iter_32_22 in ipairs(var_32_40) do
				local var_32_41 = lua_skill_buff.configDict[iter_32_22.buffId]

				if var_32_41 and var_32_41.typeId == var_32_37 then
					var_32_39 = var_32_39 + (iter_32_22.layer and iter_32_22.layer > 0 and iter_32_22.layer or 1)
				end
			end
		end

		return var_32_38 <= var_32_39
	elseif var_32_2.type == "HasTypeIdBuffMoreThan" then
		local var_32_42 = tonumber(var_32_0[2])
		local var_32_43 = tonumber(var_32_0[3])
		local var_32_44 = var_32_4:getBuffList()
		local var_32_45 = 0

		for iter_32_23, iter_32_24 in ipairs(var_32_44) do
			local var_32_46 = lua_skill_buff.configDict[iter_32_24.buffId]

			if var_32_46 and var_32_46.typeId == var_32_42 then
				if FightBuffHelper.isIncludeType(iter_32_24.buffId, FightEnum.BuffIncludeTypes.Stacked) then
					var_32_45 = var_32_45 + (iter_32_24.layer and iter_32_24.layer > 0 and iter_32_24.layer or 1)
				else
					var_32_45 = var_32_45 + 1
				end
			end
		end

		return var_32_43 <= var_32_45
	elseif var_32_2.type == "EnemyNumIncludeSpMoreThan" then
		return tonumber(var_32_0[2]) <= #FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide)
	elseif var_32_2.type == "EnemyNumIncludeSpLessThan" then
		return tonumber(var_32_0[2]) >= #FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide)
	end
end

function var_0_0._getBuffTypeDic(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_1:getBuffList()
	local var_33_1 = {}

	for iter_33_0, iter_33_1 in ipairs(var_33_0) do
		local var_33_2 = lua_skill_buff.configDict[iter_33_1.buffId]

		if var_33_2 then
			var_33_1[var_33_2.typeId] = true
		end
	end

	return var_33_1
end

function var_0_0._getSimulateBuffTypeDic(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0:_simulateBuffList(arg_34_1)
	local var_34_1 = {}

	for iter_34_0, iter_34_1 in ipairs(var_34_0) do
		local var_34_2 = lua_skill_buff.configDict[iter_34_1.buffId]

		if var_34_2 then
			var_34_1[var_34_2.typeId] = true
		end
	end

	return var_34_1
end

function var_0_0._checkSkillRateUpBehavior(arg_35_0, arg_35_1, arg_35_2)
	if string.nilorempty(arg_35_1) then
		return
	end

	local var_35_0 = FightStrUtil.instance:getSplitCache(arg_35_1, "#")
	local var_35_1 = tonumber(var_35_0[1])
	local var_35_2 = lua_skill_behavior.configDict[var_35_1]
	local var_35_3 = arg_35_0:_getConditionTargetUid(arg_35_2)

	if var_35_3 == 0 then
		return false
	end

	local var_35_4 = FightDataHelper.entityMgr:getById(var_35_3)

	if not var_35_4 then
		return false
	end

	local var_35_5 = var_35_2.type == "SkillRateUp1" and arg_35_2 == 103
	local var_35_6 = var_35_2.type == "SkillRateUp2" and arg_35_2 ~= 103
	local var_35_7 = arg_35_0:_simulateBuffList(var_35_4)

	if var_35_5 or var_35_6 then
		local var_35_8 = var_35_0[4] and FightStrUtil.instance:getSplitToNumberCache(var_35_0[4], ",") or {}

		for iter_35_0, iter_35_1 in ipairs(var_35_7) do
			local var_35_9 = lua_skill_buff.configDict[iter_35_1.buffId]
			local var_35_10 = var_35_9 and lua_skill_bufftype.configDict[var_35_9.typeId]

			if var_35_10 and tabletool.indexOf(var_35_8, var_35_10.type) then
				return true
			end
		end
	end
end

function var_0_0._simulateBuffList(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_1:getBuffList()
	local var_36_1 = FightCardModel.instance:getCardOps()

	for iter_36_0, iter_36_1 in ipairs(var_36_1) do
		if iter_36_1:isPlayCard() then
			local var_36_2 = lua_skill.configDict[iter_36_1.skillId]

			for iter_36_2 = 1, FightEnum.MaxBehavior do
				local var_36_3 = var_36_2["condition" .. iter_36_2]
				local var_36_4 = var_36_2["behavior" .. iter_36_2]
				local var_36_5 = var_36_2["behaviorTarget" .. iter_36_2]
				local var_36_6 = var_36_2["conditionTarget" .. iter_36_2]

				if arg_36_0:_checkCanAddBuff(var_36_3) and not string.nilorempty(var_36_4) then
					local var_36_7 = var_36_5

					if var_36_5 == 0 then
						var_36_7 = var_36_2.logicTarget
					elseif var_36_5 == 999 then
						var_36_7 = var_36_6 ~= 0 and var_36_6 or var_36_2.logicTarget
					end

					arg_36_0:_simulateSkillehavior(arg_36_1, iter_36_1, var_36_4, var_36_7, var_36_0)
				end
			end
		end
	end

	return var_36_0
end

function var_0_0._checkCanAddBuff(arg_37_0, arg_37_1)
	if string.nilorempty(arg_37_1) then
		return
	end

	local var_37_0 = FightStrUtil.instance:getSplitCache(arg_37_1, "&")

	if #var_37_0 > 1 then
		local var_37_1 = 0

		for iter_37_0, iter_37_1 in ipairs(var_37_0) do
			if arg_37_0:_checkSingleConditionCanAddBuff(iter_37_1) then
				var_37_1 = var_37_1 + 1
			end
		end

		if var_37_1 == #var_37_0 then
			return true
		end
	else
		local var_37_2 = FightStrUtil.instance:getSplitCache(arg_37_1, "|")

		if #var_37_2 > 1 then
			for iter_37_2, iter_37_3 in ipairs(var_37_2) do
				if arg_37_0:_checkSingleConditionCanAddBuff(iter_37_3) then
					return true
				end
			end
		elseif arg_37_0:_checkSingleConditionCanAddBuff(arg_37_1) then
			return true
		end
	end
end

function var_0_0._checkSingleConditionCanAddBuff(arg_38_0, arg_38_1)
	local var_38_0 = FightStrUtil.instance:getSplitCache(arg_38_1, "#")
	local var_38_1 = tonumber(var_38_0[1])
	local var_38_2 = lua_skill_behavior_condition.configDict[var_38_1]

	if not var_38_2 or string.nilorempty(var_38_2.type) then
		return false
	end

	if var_38_2.type == "None" then
		return true
	end
end

function var_0_0._simulateSkillehavior(arg_39_0, arg_39_1, arg_39_2, arg_39_3, arg_39_4, arg_39_5)
	local var_39_0 = FightStrUtil.instance:getSplitToNumberCache(arg_39_3, "#")
	local var_39_1 = var_39_0[1]
	local var_39_2 = lua_skill_behavior.configDict[var_39_1]
	local var_39_3 = false

	if FightEnum.LogicTargetClassify.Special[arg_39_4] then
		-- block empty
	elseif FightEnum.LogicTargetClassify.Single[arg_39_4] then
		if arg_39_2.toId == arg_39_1.id then
			var_39_3 = true
		end
	elseif FightEnum.LogicTargetClassify.SingleAndRandom[arg_39_4] then
		if arg_39_2.toId == arg_39_1.id then
			var_39_3 = true
		end
	elseif FightEnum.LogicTargetClassify.EnemySideAll[arg_39_4] then
		if arg_39_1.side == FightEnum.EntitySide.EnemySide then
			var_39_3 = true
		end
	elseif FightEnum.LogicTargetClassify.MySideAll[arg_39_4] then
		if arg_39_1.side == FightEnum.EntitySide.MySide then
			var_39_3 = true
		end
	elseif FightEnum.LogicTargetClassify.Me[arg_39_4] and arg_39_2.belongToEntityId == arg_39_1.id then
		var_39_3 = true
	end

	if var_39_3 and var_39_2 then
		local var_39_4

		if var_39_2.type == "AddBuff" then
			var_39_4 = var_39_0[2]
		elseif var_39_2.type == "CatapultBuff" then
			var_39_4 = var_39_0[5]
		end

		if var_39_4 then
			local var_39_5 = FightBuffMO.New()

			var_39_5.uid = "9999"
			var_39_5.id = "9999"
			var_39_5.entityId = arg_39_1.id
			var_39_5.buffId = var_39_4

			table.insert(arg_39_5, var_39_5)
		end
	end
end

function var_0_0._onStageChange(arg_40_0, arg_40_1)
	if arg_40_1 == FightEnum.Stage.Card then
		if not FightReplayModel.instance:isReplay() then
			arg_40_0._long:SetLongPressTime(arg_40_0._longPressArr)
			arg_40_0._long:AddLongPressListener(arg_40_0._onLongPress, arg_40_0)

			if PCInputController.instance:getIsUse() then
				-- block empty
			end

			arg_40_0._rightClick:AddClickListener(arg_40_0._onClickRight, arg_40_0)
		end
	else
		arg_40_0._long:RemoveLongPressListener()

		if PCInputController.instance:getIsUse() then
			arg_40_0._long:RemoveHoverListener()
		end

		arg_40_0._rightClick:RemoveClickListener()
	end

	arg_40_0:_updateSpEffect()
end

function var_0_0.playLongPressEffect(arg_41_0)
	TaskDispatcher.cancelTask(arg_41_0._delayDisableAnim, arg_41_0)
	TaskDispatcher.runDelay(arg_41_0._delayDisableAnim, arg_41_0, 1)
end

function var_0_0._delayDisableAnim(arg_42_0)
	arg_42_0:stopLongPressEffect()
end

function var_0_0.stopLongPressEffect(arg_43_0)
	TaskDispatcher.cancelTask(arg_43_0._delayDisableAnim, arg_43_0)
	recthelper.setAnchor(arg_43_0._forAnimGO.transform, 0, 0)
	transformhelper.setLocalRotation(arg_43_0._forAnimGO.transform, 0, 0, 0)
end

function var_0_0._onClickThis(arg_44_0)
	if arg_44_0._isLongPress then
		arg_44_0._isLongPress = false

		logNormal("has LongPress, can't click card")

		return
	end

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DouQuQu) then
		return
	end

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.Enter) then
		return
	end

	if arg_44_0._isLongPress and not PCInputController.instance:getIsUse() then
		arg_44_0._isLongPress = false

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
		local var_44_0 = FightDataHelper.entityMgr:getById(arg_44_0.cardInfoMO.uid)

		if var_44_0 and var_44_0:isUniqueSkill(arg_44_0.cardInfoMO.skillId) then
			return
		end

		FightDataHelper.stageMgr:exitOperateState(FightStageMgr.OperateStateType.Discard)
		FightController.instance:dispatchEvent(FightEvent.PlayDiscardEffect, arg_44_0.index)

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

	if arg_44_0._isDraging then
		return
	end

	if not FightCardDataHelper.canPlayCard(arg_44_0.cardInfoMO) then
		return
	end

	local var_44_1 = arg_44_0.cardInfoMO.skillId

	if FightEnum.UniversalCard[var_44_1] then
		return
	end

	local var_44_2 = 0

	for iter_44_0, iter_44_1 in ipairs(FightCardModel.instance:getPlayCardOpList()) do
		var_44_2 = var_44_2 + iter_44_1.costActPoint
	end

	if var_44_2 >= FightCardModel.instance:getCardMO().actPoint then
		return
	end

	local var_44_3 = lua_skill.configDict[var_44_1]
	local var_44_4 = FightDataHelper.entityMgr:getMyNormalList()
	local var_44_5 = FightDataHelper.entityMgr:getSpList(FightEnum.EntitySide.MySide)
	local var_44_6 = #var_44_4 + #var_44_5

	if var_44_3 and FightEnum.ShowLogicTargetView[var_44_3.logicTarget] and var_44_3.targetLimit == FightEnum.TargetLimit.MySide then
		if var_44_6 > 1 then
			ViewMgr.instance:openView(ViewName.FightSkillTargetView, {
				fromId = arg_44_0.cardInfoMO.uid,
				skillId = var_44_1,
				callback = arg_44_0._toPlayCard,
				callbackObj = arg_44_0
			})

			return
		end

		if var_44_6 == 1 then
			arg_44_0:_toPlayCard(var_44_4[1].id)

			return
		end
	end

	arg_44_0:_toPlayCard()
end

function var_0_0._toPlayCard(arg_45_0, arg_45_1, arg_45_2)
	GuideController.instance:dispatchEvent(GuideEvent.SpecialEventDone, GuideEnum.SpecialEventEnum.FightCardOp)
	FightController.instance:dispatchEvent(FightEvent.BeforePlayHandCard, arg_45_0.index, arg_45_1)
	FightController.instance:dispatchEvent(FightEvent.PlayHandCard, arg_45_0.index, arg_45_1, arg_45_2)
end

function var_0_0._onDragBegin(arg_46_0, arg_46_1, arg_46_2)
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

	local var_46_0 = GuideModel.instance:getFlagValue(GuideModel.GuideFlag.FightMoveCard)

	if var_46_0 and var_46_0.from and var_46_0.from ~= arg_46_0.index then
		return
	end

	if not FightCardDataHelper.canMoveCard(arg_46_0.cardInfoMO) then
		return
	end

	arg_46_0._isDraging = true

	FightController.instance:dispatchEvent(FightEvent.DragHandCardBegin, arg_46_0.index, arg_46_2.position, arg_46_0.cardInfoMO)
end

function var_0_0._onDragThis(arg_47_0, arg_47_1, arg_47_2)
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

	if arg_47_0._isDraging then
		FightController.instance:dispatchEvent(FightEvent.DragHandCard, arg_47_0.index, arg_47_2.position)
	end
end

function var_0_0._onDragEnd(arg_48_0, arg_48_1, arg_48_2)
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

	if arg_48_0._isDraging then
		arg_48_0._isDraging = false

		FightController.instance:dispatchEvent(FightEvent.DragHandCardEnd, arg_48_0.index, arg_48_2.position)
		GuideController.instance:dispatchEvent(GuideEvent.SpecialEventDone, GuideEnum.SpecialEventEnum.FightCardOp)
	end
end

function var_0_0._onClickRight(arg_49_0)
	GameGlobalMgr.instance:playTouchEffect()

	if FightCardModel.instance:getLongPressIndex() ~= arg_49_0.index then
		FightController.instance:dispatchEvent(FightEvent.LongPressHandCardEnd)
		arg_49_0:_onLongPress()

		arg_49_0._isLongPress = false
	end
end

function var_0_0._onLongPress(arg_50_0)
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

	if not arg_50_0._isDraging then
		arg_50_0._isLongPress = true

		FightController.instance:dispatchEvent(FightEvent.LongPressHandCard, arg_50_0.index)
	end
end

function var_0_0._onHover(arg_51_0)
	if GuideController.instance:isGuiding() then
		return
	end

	if not arg_51_0._isLongPress then
		arg_51_0:_onLongPress()
	end
end

function var_0_0._simulateDragHandCardBegin(arg_52_0, arg_52_1)
	if not arg_52_0.cardInfoMO then
		return
	end

	if arg_52_0.index ~= arg_52_1 then
		return
	end

	local var_52_0 = recthelper.uiPosToScreenPos(arg_52_0.tr)

	arg_52_0:_onDragBegin(nil, {
		position = var_52_0
	})
end

function var_0_0._simulateDragHandCard(arg_53_0, arg_53_1, arg_53_2)
	if not arg_53_0.cardInfoMO then
		return
	end

	if arg_53_0.index ~= arg_53_1 then
		return
	end

	local var_53_0 = arg_53_0._subViewInst:getHandCardItem(arg_53_2)

	if var_53_0 then
		local var_53_1 = recthelper.uiPosToScreenPos(var_53_0.tr)

		arg_53_0:_onDragThis(nil, {
			position = var_53_1
		})
	end
end

function var_0_0._simulateDragHandCardEnd(arg_54_0, arg_54_1, arg_54_2)
	if not arg_54_0.cardInfoMO then
		return
	end

	if arg_54_0.index ~= arg_54_1 then
		return
	end

	local var_54_0 = recthelper.uiPosToScreenPos(arg_54_0.tr)

	arg_54_0._isDraging = true

	arg_54_0:_onDragEnd(nil, {
		position = var_54_0
	})
end

function var_0_0._simulatePlayHandCard(arg_55_0, arg_55_1, arg_55_2, arg_55_3)
	if not arg_55_0.cardInfoMO then
		return
	end

	if arg_55_0.index ~= arg_55_1 then
		return
	end

	arg_55_0:_toPlayCard(arg_55_2, arg_55_3)
end

function var_0_0.playCardAni(arg_56_0, arg_56_1, arg_56_2)
	arg_56_0._cardAniName = arg_56_2 or UIAnimationName.Open

	arg_56_0._loader:loadAsset(arg_56_1, arg_56_0._onCardAniLoaded, arg_56_0)
end

function var_0_0._onCardAniLoaded(arg_57_0, arg_57_1)
	arg_57_0._cardAni.runtimeAnimatorController = arg_57_1:GetResource()
	arg_57_0._cardAni.enabled = true
	arg_57_0._cardAni.speed = FightModel.instance:getUISpeed()

	gohelper.setActive(arg_57_0.go, true)
	SLFramework.AnimatorPlayer.Get(arg_57_0._innerGO):Play(arg_57_0._cardAniName, arg_57_0._onCardAniFinish, arg_57_0)
end

function var_0_0._onCardAniFinish(arg_58_0)
	arg_58_0._cardAni.enabled = false

	arg_58_0:_hideEffect()
end

function var_0_0.playAni(arg_59_0, arg_59_1, arg_59_2)
	arg_59_0._aniName = arg_59_2 or UIAnimationName.Open

	arg_59_0._loader:loadAsset(arg_59_1, arg_59_0._onAniLoaded, arg_59_0)
end

function var_0_0._onAniLoaded(arg_60_0, arg_60_1)
	arg_60_0._foranim.runtimeAnimatorController = arg_60_1:GetResource()
	arg_60_0._foranim.enabled = true
	arg_60_0._foranim.speed = FightModel.instance:getUISpeed()

	gohelper.setActive(arg_60_0.go, true)
	SLFramework.AnimatorPlayer.Get(arg_60_0._forAnimGO):Play(arg_60_0._aniName, arg_60_0._onAniFinish, arg_60_0)
end

function var_0_0._onAniFinish(arg_61_0)
	arg_61_0._foranim.enabled = false
end

function var_0_0._hideEffect(arg_62_0)
	gohelper.setActive(gohelper.findChild(arg_62_0._innerGO, "vx_balance"), false)
end

function var_0_0._onRefreshOneHandCard(arg_63_0, arg_63_1)
	if not arg_63_0.cardInfoMO then
		return
	end

	if arg_63_1 == arg_63_0.index then
		arg_63_0:updateItem(arg_63_0.index, arg_63_0.cardInfoMO)
	end
end

function var_0_0._onGMForceRefreshNameUIBuff(arg_64_0)
	arg_64_0:_onRefreshOneHandCard(arg_64_0.index)
end

function var_0_0.playDistribute(arg_65_0)
	if not arg_65_0._distributeFlow then
		arg_65_0._distributeFlow = FlowSequence.New()

		arg_65_0._distributeFlow:addWork(FigthCardDistributeEffect.New())
	else
		arg_65_0._distributeFlow:stop()
	end

	local var_65_0 = arg_65_0:getUserDataTb_()

	var_65_0.cards = tabletool.copy(FightCardModel.instance:getHandCards())
	var_65_0.handCardItemList = arg_65_0._subViewInst._handCardItemList
	var_65_0.preCardCount = #var_65_0.cards - 1
	var_65_0.newCardCount = 1

	arg_65_0._distributeFlow:start(var_65_0)
end

function var_0_0.playMasterAddHandCard(arg_66_0)
	if not arg_66_0._masterAddHandCardFlow then
		arg_66_0._masterAddHandCardFlow = FlowSequence.New()

		arg_66_0._masterAddHandCardFlow:addWork(FigthMasterAddHandCardEffect.New())
	else
		arg_66_0._masterAddHandCardFlow:stop()
	end

	local var_66_0 = arg_66_0:getUserDataTb_()

	var_66_0.card = arg_66_0

	arg_66_0._masterAddHandCardFlow:start(var_66_0)
end

function var_0_0.playMasterCardRemove(arg_67_0)
	if not arg_67_0._masterCardRemoveFlow then
		arg_67_0._masterCardRemoveFlow = FlowSequence.New()

		arg_67_0._masterCardRemoveFlow:addWork(FigthMasterCardRemoveEffect.New())
	else
		arg_67_0._masterCardRemoveFlow:stop()
	end

	local var_67_0 = arg_67_0:getUserDataTb_()

	var_67_0.card = arg_67_0

	arg_67_0._masterCardRemoveFlow:start(var_67_0)
end

function var_0_0.dissolveEntityCard(arg_68_0, arg_68_1)
	if not arg_68_0.cardInfoMO then
		return
	end

	if arg_68_0.cardInfoMO.uid ~= arg_68_1 then
		return
	end

	arg_68_0:dissolveCard()

	return true
end

function var_0_0.dissolveCard(arg_69_0)
	if not arg_69_0.go.activeInHierarchy then
		return
	end

	arg_69_0:setASFDActive(false)
	arg_69_0._cardItem:dissolveCard(transformhelper.getLocalScale(arg_69_0._subViewInst._handCardContainer.transform), arg_69_0.go)
end

function var_0_0.moveSelfPos(arg_70_0, arg_70_1, arg_70_2)
	arg_70_0:_releaseMoveFlow()

	arg_70_0._moveCardFlow = FlowParallel.New()

	local var_70_0 = 0.033 / FightModel.instance:getUISpeed()
	local var_70_1 = arg_70_0.go.transform
	local var_70_2 = FlowSequence.New()

	var_70_2:addWork(WorkWaitSeconds.New(3 * arg_70_2 * var_70_0))

	local var_70_3 = FightViewHandCard.calcCardPosX(arg_70_1)
	local var_70_4 = var_70_3 + 10

	var_70_2:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = var_70_1,
		to = var_70_4,
		t = var_70_0 * 5
	}))
	var_70_2:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = var_70_1,
		to = var_70_3,
		t = var_70_0 * 2
	}))
	arg_70_0._moveCardFlow:addWork(var_70_2)
	arg_70_0._moveCardFlow:start()
end

function var_0_0.playCardLevelChange(arg_71_0, arg_71_1, arg_71_2)
	if not arg_71_0.cardInfoMO then
		return
	end

	if not arg_71_0.go.activeInHierarchy then
		return
	end

	gohelper.setActive(arg_71_0._lockGO, false)

	arg_71_0.cardInfoMO = arg_71_1

	arg_71_0._cardItem:playCardLevelChange(arg_71_1, arg_71_2)
end

function var_0_0._onCardLevelChangeDone(arg_72_0, arg_72_1)
	if arg_72_1 == arg_72_0.cardInfoMO then
		gohelper.setActive(arg_72_0._lockGO, true)
		arg_72_0:updateItem(arg_72_0.index, arg_72_0.cardInfoMO)
	end
end

function var_0_0.playCardAConvertCardB(arg_73_0)
	if not arg_73_0.cardInfoMO then
		return
	end

	gohelper.setActive(arg_73_0._cardConvertEffect, true)
	TaskDispatcher.cancelTask(arg_73_0._afterConvertCardEffect, arg_73_0)

	if arg_73_0._convertEffect then
		local var_73_0 = arg_73_0._convertEffect.transform
		local var_73_1 = var_73_0.childCount
		local var_73_2 = FightCardModel.instance:isUniqueSkill(arg_73_0.cardInfoMO.uid, arg_73_0.cardInfoMO.skillId)
		local var_73_3

		if var_73_2 then
			for iter_73_0 = 0, var_73_1 - 1 do
				local var_73_4 = var_73_0:GetChild(iter_73_0).gameObject

				if iter_73_0 == 3 then
					gohelper.setActive(var_73_4, true)

					var_73_3 = gohelper.onceAddComponent(var_73_4, typeof(UnityEngine.Animation))
				else
					gohelper.setActive(var_73_4, false)
				end
			end
		else
			local var_73_5 = FightCardModel.instance:getSkillLv(arg_73_0.cardInfoMO.uid, arg_73_0.cardInfoMO.skillId)

			for iter_73_1 = 0, var_73_1 - 1 do
				local var_73_6 = var_73_0:GetChild(iter_73_1).gameObject

				if iter_73_1 + 1 == var_73_5 then
					gohelper.setActive(var_73_6, true)

					var_73_3 = gohelper.onceAddComponent(var_73_6, typeof(UnityEngine.Animation))
				else
					gohelper.setActive(var_73_6, false)
				end
			end
		end

		if var_73_3 then
			var_73_3.this:get(var_73_3.clip.name).speed = FightModel.instance:getUISpeed()
		end

		TaskDispatcher.runDelay(arg_73_0._afterConvertCardEffect, arg_73_0, FightEnum.PerformanceTime.CardAConvertCardB / FightModel.instance:getUISpeed())
	else
		arg_73_0._loader:loadAsset("ui/viewres/fight/card_intensive.prefab", arg_73_0._onCardAConvertCardBLoaded, arg_73_0)
	end
end

function var_0_0._onCardAConvertCardBLoaded(arg_74_0, arg_74_1)
	local var_74_0 = arg_74_1:GetResource()

	arg_74_0._convertEffect = gohelper.clone(var_74_0, arg_74_0._cardConvertEffect)

	arg_74_0:playCardAConvertCardB()
	TaskDispatcher.runDelay(arg_74_0._afterConvertCardEffect, arg_74_0, FightEnum.PerformanceTime.CardAConvertCardB / FightModel.instance:getUISpeed())
end

function var_0_0._afterConvertCardEffect(arg_75_0)
	gohelper.setActive(arg_75_0._cardConvertEffect, false)
end

function var_0_0.changeToTempCard(arg_76_0)
	arg_76_0._cardItem:changeToTempCard()
end

function var_0_0.getASFDScreenPos(arg_77_0)
	return arg_77_0._cardItem:getASFDScreenPos()
end

function var_0_0.refreshPreDeleteImage(arg_78_0, arg_78_1)
	if arg_78_0._cardItem then
		arg_78_0._cardItem:_refreshPreDeleteImage(arg_78_1)
	end
end

function var_0_0.setActiveRed(arg_79_0, arg_79_1)
	if arg_79_0._cardItem then
		arg_79_0._cardItem:setActiveRed(arg_79_1)
	end
end

function var_0_0.setActiveBlue(arg_80_0, arg_80_1)
	if arg_80_0._cardItem then
		arg_80_0._cardItem:setActiveBlue(arg_80_1)
	end
end

function var_0_0.setActiveBoth(arg_81_0, arg_81_1)
	if arg_81_0._cardItem then
		arg_81_0._cardItem:setActiveBoth(arg_81_1)
	end
end

function var_0_0.resetRedAndBlue(arg_82_0)
	if arg_82_0._cardItem then
		arg_82_0._cardItem:resetRedAndBlue()
	end
end

function var_0_0._releaseMoveFlow(arg_83_0)
	if arg_83_0._moveCardFlow then
		arg_83_0._moveCardFlow:stop()

		arg_83_0._moveCardFlow = nil
	end
end

function var_0_0.releaseSelf(arg_84_0)
	TaskDispatcher.cancelTask(arg_84_0._afterConvertCardEffect, arg_84_0)

	if arg_84_0._distributeFlow then
		arg_84_0._distributeFlow:stop()

		arg_84_0._distributeFlow = nil
	end

	if arg_84_0._dissolveFlow then
		arg_84_0._dissolveFlow:stop()

		arg_84_0._dissolveFlow = nil
	end

	if arg_84_0._masterAddHandCardFlow then
		arg_84_0._masterAddHandCardFlow:stop()

		arg_84_0._masterAddHandCardFlow = nil
	end

	if arg_84_0._masterCardRemoveFlow then
		arg_84_0._masterCardRemoveFlow:stop()

		arg_84_0._masterCardRemoveFlow = nil
	end

	arg_84_0:_releaseMoveFlow()

	if arg_84_0._loader then
		arg_84_0._loader:releaseSelf()

		arg_84_0._loader = nil
	end
end

return var_0_0
