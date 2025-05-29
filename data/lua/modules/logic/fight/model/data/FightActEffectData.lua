module("modules.logic.fight.model.data.FightActEffectData", package.seeall)

local var_0_0 = FightDataClass("FightActEffectData")

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0.targetId = arg_1_1.targetId
	arg_1_0.effectType = arg_1_1.effectType
	arg_1_0.effectNum = arg_1_1.effectNum
	arg_1_0.buff = FightBuffInfoData.New(arg_1_1.buff)
	arg_1_0.entity = FightEntityInfoData.New(arg_1_1.entity)
	arg_1_0.configEffect = arg_1_1.configEffect
	arg_1_0.buffActId = arg_1_1.buffActId
	arg_1_0.reserveId = arg_1_1.reserveId
	arg_1_0.reserveStr = arg_1_1.reserveStr
	arg_1_0.summoned = FightSummonedInfoData.New(arg_1_1.summoned)
	arg_1_0.magicCircle = FightMagicCircleInfoData.New(arg_1_1.magicCircle)
	arg_1_0.cardInfo = FightCardInfoData.New(arg_1_1.cardInfo)
	arg_1_0.cardInfoList = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.cardInfoList) do
		table.insert(arg_1_0.cardInfoList, FightCardInfoData.New(iter_1_1))
	end

	arg_1_0.teamType = arg_1_1.teamType
	arg_1_0.fightStep = FightStepData.New(arg_1_1.fightStep)
	arg_1_0.assistBossInfo = FightAssistBossInfoData.New(arg_1_1.assistBossInfo)
	arg_1_0.effectNum1 = arg_1_1.effectNum1
	arg_1_0.emitterInfo = FightEmitterInfoData.New(arg_1_1.emitterInfo)
	arg_1_0.playerFinisherInfo = FightPlayerFinisherInfoData.New(arg_1_1.playerFinisherInfo)
	arg_1_0.powerInfo = FightPowerInfoData.New(arg_1_1.powerInfo)
	arg_1_0.cardHeatValue = FightCardHeatValueData.New(arg_1_1.cardHeatValue)
	arg_1_0.fightTasks = {}

	for iter_1_2, iter_1_3 in ipairs(arg_1_1.fightTasks) do
		table.insert(arg_1_0.fightTasks, FightTaskData.New(iter_1_3))
	end
end

return var_0_0
