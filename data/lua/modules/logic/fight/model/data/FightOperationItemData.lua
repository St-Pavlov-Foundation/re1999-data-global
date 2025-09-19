module("modules.logic.fight.model.data.FightOperationItemData", package.seeall)

local var_0_0 = FightDataClass("FightOperationItemData")

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.costActPoint = 0
	arg_1_0.cardColor = FightEnum.CardColor.None
end

function var_0_0.setByProto(arg_2_0, arg_2_1)
	arg_2_0.operType = arg_2_1.operType
	arg_2_0.toId = arg_2_1.toId
	arg_2_0.param1 = arg_2_1.param1
	arg_2_0.param2 = arg_2_1.param2
	arg_2_0.param3 = arg_2_1.param3
end

function var_0_0.moveCard(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0.operType = FightEnum.CardOpType.MoveCard
	arg_3_0.param1 = arg_3_1
	arg_3_0.param2 = arg_3_2
	arg_3_0.cardData = FightDataUtil.copyData(arg_3_3)
	arg_3_0.costActPoint = FightCardDataHelper.moveActCost(arg_3_3)
	arg_3_0.skillId = arg_3_3.skillId
	arg_3_0.belongToEntityId = arg_3_3.uid
	arg_3_0.moveToIndex = arg_3_2
end

function var_0_0.moveUniversalCard(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.operType = FightEnum.CardOpType.MoveUniversal
	arg_4_0.param1 = arg_4_1
	arg_4_0.param2 = arg_4_2
	arg_4_0.cardData = FightDataUtil.copyData(arg_4_3)
	arg_4_0.costActPoint = FightCardDataHelper.moveActCost(arg_4_3)
	arg_4_0.skillId = arg_4_3.skillId
	arg_4_0.belongToEntityId = arg_4_3.uid
	arg_4_0.moveToIndex = arg_4_2
end

function var_0_0.playCard(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	arg_5_0.operType = FightEnum.CardOpType.PlayCard
	arg_5_0.toId = arg_5_0:getTarget(arg_5_2, arg_5_3.skillId)
	arg_5_0.param1 = arg_5_1
	arg_5_0.param2 = arg_5_4
	arg_5_0.param3 = arg_5_5

	local var_5_0 = arg_5_3.uid
	local var_5_1 = arg_5_3.skillId

	arg_5_0.cardData = FightDataUtil.copyData(arg_5_3)
	arg_5_0.costActPoint = FightCardDataHelper.playActCost(arg_5_3)

	local var_5_2 = FightDataHelper.entityMgr:getById(var_5_0)
	local var_5_3 = FightBuffHelper.simulateBuffList(var_5_2)

	arg_5_0.clientSimulateCanPlayCard = FightViewHandCardItemLock.canUseCardSkill(var_5_0, var_5_1, var_5_3)
	arg_5_0.skillId = var_5_1
	arg_5_0.belongToEntityId = var_5_0
	arg_5_0.cardInfoMO = arg_5_0.cardData
end

function var_0_0.playAssistBossHandCard(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.operType = FightEnum.CardOpType.AssistBoss
	arg_6_0.param1 = arg_6_1
	arg_6_0.toId = arg_6_0:getTarget(arg_6_2, arg_6_1)
	arg_6_0.skillId = arg_6_1
	arg_6_0.belongToEntityId = FightDataHelper.entityMgr:getAssistBoss().id
	arg_6_0.costActPoint = 0
	arg_6_0.cardInfoMO = FightCardInfoData.New({
		skillId = arg_6_1,
		uid = arg_6_0.belongToEntityId
	})
end

function var_0_0.playPlayerFinisherSkill(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.operType = FightEnum.CardOpType.PlayerFinisherSkill
	arg_7_0.param1 = arg_7_1
	arg_7_0.toId = arg_7_2
	arg_7_0.skillId = arg_7_1
	arg_7_0.costActPoint = 0
	arg_7_0.belongToEntityId = FightEntityScene.MySideId
	arg_7_0.cardInfoMO = FightCardInfoData.New({
		skillId = arg_7_1,
		uid = arg_7_0.belongToEntityId
	})
end

function var_0_0.playBloodPoolCard(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.operType = FightEnum.CardOpType.BloodPool
	arg_8_0.param1 = arg_8_1
	arg_8_0.toId = arg_8_0:getTarget(arg_8_2, arg_8_1)
	arg_8_0.skillId = arg_8_1
	arg_8_0.belongToEntityId = FightEntityScene.MySideId
	arg_8_0.costActPoint = 0
	arg_8_0.cardInfoMO = FightCardInfoData.New({
		skillId = arg_8_1,
		uid = arg_8_0.belongToEntityId
	})
end

function var_0_0.simulateDissolveCard(arg_9_0, arg_9_1)
	arg_9_0.operType = FightEnum.CardOpType.SimulateDissolveCard
	arg_9_0.dissolveIndex = arg_9_1
	arg_9_0.costActPoint = 0
end

function var_0_0.selectSkillTarget(arg_10_0, arg_10_1)
	arg_10_0.toId = arg_10_1
end

function var_0_0.isMoveCard(arg_11_0)
	return arg_11_0.operType == FightEnum.CardOpType.MoveCard
end

function var_0_0.isMoveUniversal(arg_12_0)
	return arg_12_0.operType == FightEnum.CardOpType.MoveUniversal
end

function var_0_0.isPlayCard(arg_13_0)
	return arg_13_0.operType == FightEnum.CardOpType.PlayCard
end

function var_0_0.isAssistBossPlayCard(arg_14_0)
	return arg_14_0.operType == FightEnum.CardOpType.AssistBoss
end

function var_0_0.isPlayerFinisherSkill(arg_15_0)
	return arg_15_0.operType == FightEnum.CardOpType.PlayerFinisherSkill
end

function var_0_0.isBloodPoolSkill(arg_16_0)
	return arg_16_0.operType == FightEnum.CardOpType.BloodPool
end

function var_0_0.isSeason2ChangeHero(arg_17_0)
	return arg_17_0.operType == FightEnum.CardOpType.Season2ChangeHero
end

function var_0_0.isSimulateDissolveCard(arg_18_0)
	return arg_18_0.operType == FightEnum.CardOpType.SimulateDissolveCard
end

function var_0_0.copyCard(arg_19_0)
	arg_19_0._needCopyCard = 1
end

function var_0_0.needCopyCard(arg_20_0)
	return arg_20_0._needCopyCard == 1
end

function var_0_0.getTarget(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_1 or FightDataHelper.operationDataMgr.curSelectEntityId

	if var_21_0 == 0 then
		local var_21_1 = FightHelper.getTargetLimits(FightEnum.EntitySide.MySide, arg_21_2)

		if #var_21_1 > 0 then
			var_21_0 = var_21_1[1]
		end
	end

	return var_21_0
end

return var_0_0
