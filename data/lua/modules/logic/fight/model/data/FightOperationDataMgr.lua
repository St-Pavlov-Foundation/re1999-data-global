module("modules.logic.fight.model.data.FightOperationDataMgr", package.seeall)

local var_0_0 = FightDataClass("FightOperationDataMgr", FightDataMgrBase)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.actPoint = 0
	arg_1_0.moveNum = 0
	arg_1_0.extraMoveAct = 0
	arg_1_0.operationList = {}
	arg_1_0.extraMoveUsedCount = 0
	arg_1_0.playerFinisherSkillUsedCount = nil
	arg_1_0.curSelectEntityId = 0
	arg_1_0.survivalTalentSkillUsedCount = 0
end

function var_0_0.getOpList(arg_2_0)
	return arg_2_0.operationList
end

function var_0_0.dealCardInfoPush(arg_3_0, arg_3_1)
	arg_3_0.actPoint = arg_3_1.actPoint
	arg_3_0.moveNum = arg_3_1.moveNum
	arg_3_0.extraMoveAct = arg_3_1.extraMoveAct
end

function var_0_0.isUnlimitMoveCard(arg_4_0)
	return arg_4_0.extraMoveAct == -1
end

function var_0_0.clearClientSimulationData(arg_5_0)
	tabletool.clear(arg_5_0.operationList)

	arg_5_0.extraMoveUsedCount = 0
	arg_5_0.playerFinisherSkillUsedCount = nil
	arg_5_0.survivalTalentSkillUsedCount = 0
end

function var_0_0.onCancelOperation(arg_6_0)
	arg_6_0:clearClientSimulationData()

	local var_6_0 = FightDataHelper.entityMgr:getAllEntityData()

	for iter_6_0, iter_6_1 in pairs(var_6_0) do
		iter_6_1:resetSimulateExPoint()
	end
end

function var_0_0.onStageChanged(arg_7_0, arg_7_1)
	arg_7_0:clearClientSimulationData()

	if arg_7_1 == FightStageMgr.StageType.Play and arg_7_0.dataMgr.stageMgr:getCurStageParam() == FightStageMgr.PlayType.Normal then
		arg_7_0.extraMoveAct = 0
	end
end

function var_0_0.addOperation(arg_8_0, arg_8_1)
	table.insert(arg_8_0.operationList, arg_8_1)
end

function var_0_0.newOperation(arg_9_0)
	local var_9_0 = FightOperationItemData.New()

	table.insert(arg_9_0.operationList, var_9_0)

	return var_9_0
end

function var_0_0.getEntityOps(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.operationList) do
		if iter_10_1.belongToEntityId == arg_10_1 and (not arg_10_2 or iter_10_1.operType == arg_10_2) then
			table.insert(var_10_0, iter_10_1)
		end
	end

	return var_10_0
end

function var_0_0.getShowOpActList(arg_11_0)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.operationList) do
		if arg_11_0:canShowOpAct(iter_11_1) then
			table.insert(var_11_0, iter_11_1)
		end
	end

	return var_11_0
end

function var_0_0.canShowOpAct(arg_12_0, arg_12_1)
	if not arg_12_1:isMoveUniversal() and (not (arg_12_1:isMoveCard() and arg_12_0:isUnlimitMoveCard()) or arg_12_1:isPlayCard()) then
		return true
	end
end

function var_0_0.getPlayCardOpList(arg_13_0)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.operationList) do
		if FightCardDataHelper.checkOpAsPlayCardHandle(iter_13_1) then
			table.insert(var_13_0, iter_13_1)
		end
	end

	return var_13_0
end

function var_0_0.getMoveCardOpList(arg_14_0)
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.operationList) do
		if iter_14_1:isMoveCard() then
			table.insert(var_14_0, iter_14_1)
		end
	end

	return var_14_0
end

function var_0_0.getMoveCardOpCostActList(arg_15_0)
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.operationList) do
		if iter_15_1:isMoveCard() then
			table.insert(var_15_0, iter_15_1)
		end
	end

	return var_15_0
end

function var_0_0.isCardOpEnd(arg_16_0)
	local var_16_0 = arg_16_0.dataMgr.handCardMgr.handCard

	if #var_16_0 == 0 then
		return true
	end

	local var_16_1 = arg_16_0.dataMgr.fieldMgr
	local var_16_2 = arg_16_0.operationList
	local var_16_3 = 0
	local var_16_4 = 0

	for iter_16_0, iter_16_1 in ipairs(var_16_2) do
		if iter_16_1:isPlayCard() then
			var_16_3 = var_16_3 + iter_16_1.costActPoint
		elseif iter_16_1:isMoveCard() then
			var_16_4 = var_16_4 + 1

			if not arg_16_0:isUnlimitMoveCard() and var_16_4 > arg_16_0.extraMoveAct then
				var_16_3 = var_16_3 + iter_16_1.costActPoint
			end
		end
	end

	local var_16_5 = arg_16_0.actPoint

	if var_16_1:isSeason2() then
		var_16_5 = 1

		if #var_16_2 >= 1 then
			return true
		end
	end

	if var_16_5 <= var_16_3 then
		return true
	end

	if FightCardDataHelper.allFrozenCard(var_16_0) then
		return true
	end

	return false
end

function var_0_0.getLeftExtraMoveCount(arg_17_0)
	if arg_17_0.extraMoveAct < 0 then
		return arg_17_0.extraMoveAct
	end

	return arg_17_0.extraMoveAct - arg_17_0.extraMoveUsedCount
end

function var_0_0.setCurSelectEntityId(arg_18_0, arg_18_1)
	arg_18_0.curSelectEntityId = arg_18_1
end

function var_0_0.resetCurSelectEntityIdDefault(arg_19_0)
	if FightModel.instance:isAuto() then
		if FightHelper.canSelectEnemyEntity(arg_19_0.curSelectEntityId) then
			arg_19_0:setCurSelectEntityId(arg_19_0.curSelectEntityId)
		else
			arg_19_0:setCurSelectEntityId(0)
		end
	else
		local var_19_0 = FightDataHelper.entityMgr:getById(arg_19_0.curSelectEntityId)

		if var_19_0 and var_19_0:isStatusDead() then
			var_19_0 = nil
		end

		if var_19_0 and var_19_0.side == FightEnum.EntitySide.MySide then
			arg_19_0.curSelectEntityId = 0
			var_19_0 = nil
		end

		local var_19_1 = var_19_0 ~= nil
		local var_19_2 = var_19_0 and var_19_0:hasBuffFeature(FightEnum.BuffType_CantSelect)
		local var_19_3 = var_19_0 and var_19_0:hasBuffFeature(FightEnum.BuffType_CantSelectEx)

		if arg_19_0.curSelectEntityId ~= 0 and var_19_1 and not var_19_2 and not var_19_3 then
			return
		end

		local var_19_4 = FightDataHelper.entityMgr:getEnemyNormalList()

		for iter_19_0 = #var_19_4, 1, -1 do
			local var_19_5 = var_19_4[iter_19_0]

			if var_19_5:hasBuffFeature(FightEnum.BuffType_CantSelect) or var_19_5:hasBuffFeature(FightEnum.BuffType_CantSelectEx) then
				table.remove(var_19_4, iter_19_0)
			end
		end

		if #var_19_4 > 0 then
			table.sort(var_19_4, function(arg_20_0, arg_20_1)
				return arg_20_0.position < arg_20_1.position
			end)
			arg_19_0:setCurSelectEntityId(var_19_4[1].id)
		end
	end
end

function var_0_0.getSelectEnemyPosLOrR(arg_21_0, arg_21_1)
	local var_21_0 = FightDataHelper.entityMgr:getEnemyNormalList()

	for iter_21_0 = #var_21_0, 1, -1 do
		local var_21_1 = var_21_0[iter_21_0]

		if var_21_1:hasBuffFeature(FightEnum.BuffType_CantSelect) or var_21_1:hasBuffFeature(FightEnum.BuffType_CantSelectEx) then
			table.remove(var_21_0, iter_21_0)
		end
	end

	if #var_21_0 > 0 then
		table.sort(var_21_0, function(arg_22_0, arg_22_1)
			return arg_22_0.position < arg_22_1.position
		end)

		for iter_21_1 = 1, #var_21_0 do
			if var_21_0[iter_21_1].id == arg_21_0.curSelectEntityId then
				if arg_21_1 == 1 and iter_21_1 < #var_21_0 then
					return var_21_0[iter_21_1 + 1].id
				elseif arg_21_1 == 2 and iter_21_1 > 1 then
					return var_21_0[iter_21_1 - 1].id
				end
			end
		end
	end
end

function var_0_0.addSurvivalTalentSkillUsedCount(arg_23_0, arg_23_1)
	arg_23_0.survivalTalentSkillUsedCount = arg_23_0.survivalTalentSkillUsedCount + arg_23_1
end

function var_0_0.applyNextRoundActPoint(arg_24_0)
	arg_24_0.actPoint = arg_24_0.dataMgr.roundMgr.curRoundData.actPoint or arg_24_0.actPoint
end

return var_0_0
