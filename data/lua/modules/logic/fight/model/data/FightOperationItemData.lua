module("modules.logic.fight.model.data.FightOperationItemData", package.seeall)

local var_0_0 = FightDataClass("FightOperationItemData")

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.costActPoint = 0
end

function var_0_0.setByProto(arg_2_0, arg_2_1)
	arg_2_0.operType = arg_2_1.operType
	arg_2_0.param1 = arg_2_1.param1
	arg_2_0.param2 = arg_2_1.param2
	arg_2_0.toId = arg_2_1.toId
end

function var_0_0.moveCard(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.operType = FightEnum.CardOpType.MoveCard
	arg_3_0.param1 = arg_3_1
	arg_3_0.param2 = arg_3_2
	arg_3_0.costActPoint = 1
end

function var_0_0.moveUniversalCard(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.operType = FightEnum.CardOpType.MoveUniversal
	arg_4_0.param1 = arg_4_1
	arg_4_0.param2 = arg_4_2
	arg_4_0.costActPoint = 0
end

function var_0_0.playCard(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	arg_5_0.operType = FightEnum.CardOpType.PlayCard
	arg_5_0.param1 = arg_5_1
	arg_5_0.param2 = arg_5_4
	arg_5_0.toId = arg_5_2
	arg_5_0.costActPoint = 1
	arg_5_0.skillId = arg_5_3.skillId
	arg_5_0.belongToEntityId = arg_5_3.uid

	if FightCardDataHelper.isSpecialCardById(arg_5_0.belongToEntityId, arg_5_0.skillId) then
		if arg_5_3.cardType == FightEnum.CardType.ROUGE_SP or arg_5_3.cardType == FightEnum.CardType.USE_ACT_POINT then
			arg_5_0.costActPoint = 1
		else
			arg_5_0.costActPoint = 0
		end
	end

	local var_5_0 = FightDataHelper.entityMgr:getById(arg_5_0.belongToEntityId)
	local var_5_1 = FightBuffHelper.simulateBuffList(var_5_0)

	arg_5_0.clientSimulateCanPlayCard = FightViewHandCardItemLock.canUseCardSkill(arg_5_0.belongToEntityId, arg_5_0.skillId, var_5_1)
	arg_5_0.cardInfoMO = FightDataHelper.coverData(arg_5_3, nil)
end

function var_0_0.playAssistBossHandCard(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.operType = FightEnum.CardOpType.AssistBoss
	arg_6_0.param1 = arg_6_1
	arg_6_0.toId = arg_6_2
	arg_6_0.skillId = arg_6_1
	arg_6_0.belongToEntityId = FightDataHelper.entityMgr:getAssistBoss().id
	arg_6_0.costActPoint = 0
end

function var_0_0.simulateDissolveCard(arg_7_0, arg_7_1)
	arg_7_0.operType = FightEnum.CardOpType.SimulateDissolveCard
	arg_7_0.dissolveIndex = arg_7_1
	arg_7_0.costActPoint = 0
end

function var_0_0.selectSkillTarget(arg_8_0, arg_8_1)
	arg_8_0.toId = arg_8_1
end

function var_0_0.isMoveCard(arg_9_0)
	return arg_9_0.operType == FightEnum.CardOpType.MoveCard
end

function var_0_0.isMoveUniversal(arg_10_0)
	return arg_10_0.operType == FightEnum.CardOpType.MoveUniversal
end

function var_0_0.isPlayCard(arg_11_0)
	return arg_11_0.operType == FightEnum.CardOpType.PlayCard
end

function var_0_0.isAssistBossPlayCard(arg_12_0)
	return arg_12_0.operType == FightEnum.CardOpType.AssistBoss
end

function var_0_0.isPlayerFinisherSkill(arg_13_0)
	return arg_13_0.operType == FightEnum.CardOpType.PlayerFinisherSkill
end

function var_0_0.isSimulateDissolveCard(arg_14_0)
	return arg_14_0.operType == FightEnum.CardOpType.SimulateDissolveCard
end

function var_0_0.copyCard(arg_15_0)
	arg_15_0._needCopyCard = 1
end

function var_0_0.needCopyCard(arg_16_0)
	return arg_16_0._needCopyCard == 1
end

return var_0_0
