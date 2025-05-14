module("modules.logic.fight.model.data.FightOperationDataMgr", package.seeall)

local var_0_0 = FightDataClass("FightOperationDataMgr")

var_0_0.StateType = {
	PlayHandCard = GameUtil.getEnumId(),
	PlayAssistBossCard = GameUtil.getEnumId(),
	PlayPlayerFinisherSkill = GameUtil.getEnumId(),
	MoveHandCard = GameUtil.getEnumId()
}

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.operationStates = {}
	arg_1_0.operationList = {}
	arg_1_0.extraMoveUsedCount = 0
	arg_1_0.playerFinisherSkillUsedCount = nil
end

function var_0_0.clearClientSimulationData(arg_2_0)
	tabletool.clear(arg_2_0.operationList)
	tabletool.clear(arg_2_0.operationStates)

	arg_2_0.extraMoveUsedCount = 0
	arg_2_0.playerFinisherSkillUsedCount = nil
end

function var_0_0.onCancelOperation(arg_3_0)
	arg_3_0:clearClientSimulationData()
end

function var_0_0.onStageChanged(arg_4_0)
	if #arg_4_0.operationStates > 0 then
		logError("战斗阶段改变了，但是操作状态列表中还有值，")
	end

	arg_4_0:clearClientSimulationData()
end

function var_0_0.enterOperationState(arg_5_0, arg_5_1)
	table.insert(arg_5_0.operationStates, arg_5_1)
end

function var_0_0.exitOperationState(arg_6_0, arg_6_1)
	for iter_6_0 = #arg_6_0.operationStates, 1, -1 do
		if arg_6_0.operationStates[iter_6_0] == arg_6_1 then
			table.remove(arg_6_0.operationStates, iter_6_0)
		end
	end
end

function var_0_0.addOperation(arg_7_0, arg_7_1)
	table.insert(arg_7_0.operationList, arg_7_1)
end

function var_0_0.newOperation(arg_8_0)
	local var_8_0 = FightOperationItemData.New()

	table.insert(arg_8_0.operationList, var_8_0)

	return var_8_0
end

function var_0_0.getEntityOps(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.operationList) do
		if iter_9_1.belongToEntityId == arg_9_1 and (not arg_9_2 or iter_9_1.operType == arg_9_2) then
			table.insert(var_9_0, iter_9_1)
		end
	end

	return var_9_0
end

function var_0_0.getShowOpActList(arg_10_0)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.operationList) do
		if arg_10_0:canShowOpAct(iter_10_1) then
			table.insert(var_10_0, iter_10_1)
		end
	end

	return var_10_0
end

function var_0_0.canShowOpAct(arg_11_0, arg_11_1)
	if not arg_11_1:isMoveUniversal() and (not (arg_11_1:isMoveCard() and FightCardModel.instance._cardMO:isUnlimitMoveCard()) or arg_11_1:isPlayCard()) then
		return true
	end
end

function var_0_0.getPlayCardOpList(arg_12_0)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.operationList) do
		if iter_12_1:isPlayCard() then
			table.insert(var_12_0, iter_12_1)
		end
	end

	return var_12_0
end

function var_0_0.getMoveCardOpList(arg_13_0)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.operationList) do
		if iter_13_1:isMoveCard() then
			table.insert(var_13_0, iter_13_1)
		end
	end

	return var_13_0
end

function var_0_0.getMoveCardOpCostActList(arg_14_0)
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.operationList) do
		if iter_14_1:isMoveCard() then
			table.insert(var_14_0, iter_14_1)
		end
	end

	return var_14_0
end

function var_0_0.isCardOpEnd(arg_15_0)
	local var_15_0 = arg_15_0.dataMgr.handCardMgr.handCard

	if #var_15_0 == 0 then
		return true
	end

	local var_15_1 = arg_15_0.dataMgr.fieldMgr
	local var_15_2 = arg_15_0.operationList
	local var_15_3 = 0
	local var_15_4 = 0

	for iter_15_0, iter_15_1 in ipairs(var_15_2) do
		if iter_15_1:isPlayCard() then
			var_15_3 = var_15_3 + iter_15_1.costActPoint
		elseif iter_15_1:isMoveCard() then
			var_15_4 = var_15_4 + 1

			if not var_15_1:isUnlimitMoveCard() and var_15_4 > var_15_1.extraMoveAct then
				var_15_3 = var_15_3 + iter_15_1.costActPoint
			end
		end
	end

	local var_15_5 = var_15_1.actPoint

	if var_15_1:isSeason2() then
		var_15_5 = 1

		if #var_15_2 >= 1 then
			return true
		end
	end

	if var_15_5 <= var_15_3 then
		return true
	end

	if FightCardDataHelper.allFrozenCard(var_15_0) then
		return true
	end

	return false
end

function var_0_0.getLeftExtraMoveCount(arg_16_0)
	if arg_16_0.dataMgr.fieldMgr.extraMoveAct < 0 then
		return arg_16_0.dataMgr.fieldMgr.extraMoveAct
	end

	return arg_16_0.dataMgr.fieldMgr.extraMoveAct - arg_16_0.extraMoveUsedCount
end

return var_0_0
