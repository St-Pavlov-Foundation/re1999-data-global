module("modules.logic.fight.model.data.FightActEffectData", package.seeall)

local var_0_0 = FightDataClass("FightActEffectData")
local var_0_1 = 1

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0.clientId = var_0_1
	var_0_1 = var_0_1 + 1

	if not arg_1_1 then
		return
	end

	arg_1_0.targetId = arg_1_1.targetId
	arg_1_0.effectType = arg_1_1.effectType
	arg_1_0.effectNum = arg_1_1.effectNum

	if arg_1_1:HasField("buff") then
		arg_1_0.buff = FightBuffInfoData.New(arg_1_1.buff, arg_1_0.targetId)
	end

	if arg_1_1:HasField("entity") then
		arg_1_0.entity = FightEntityInfoData.New(arg_1_1.entity)
	end

	arg_1_0.configEffect = arg_1_1.configEffect
	arg_1_0.buffActId = arg_1_1.buffActId
	arg_1_0.reserveId = arg_1_1.reserveId
	arg_1_0.reserveStr = arg_1_1.reserveStr

	if arg_1_1:HasField("summoned") then
		arg_1_0.summoned = FightSummonedInfoData.New(arg_1_1.summoned)
	end

	if arg_1_1:HasField("magicCircle") then
		arg_1_0.magicCircle = FightMagicCircleInfoData.New(arg_1_1.magicCircle)
	end

	if arg_1_1:HasField("cardInfo") then
		arg_1_0.cardInfo = FightCardInfoData.New(arg_1_1.cardInfo)
	end

	arg_1_0.cardInfoList = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.cardInfoList) do
		table.insert(arg_1_0.cardInfoList, FightCardInfoData.New(iter_1_1))
	end

	arg_1_0.teamType = arg_1_1.teamType

	if arg_1_1:HasField("fightStep") then
		arg_1_0.fightStep = FightStepData.New(arg_1_1.fightStep)
	end

	if arg_1_1:HasField("assistBossInfo") then
		arg_1_0.assistBossInfo = FightAssistBossInfoData.New(arg_1_1.assistBossInfo)
	end

	arg_1_0.effectNum1 = arg_1_1.effectNum1

	if arg_1_1:HasField("emitterInfo") then
		arg_1_0.emitterInfo = FightEmitterInfoData.New(arg_1_1.emitterInfo)
	end

	if arg_1_1:HasField("playerFinisherInfo") then
		arg_1_0.playerFinisherInfo = FightPlayerFinisherInfoData.New(arg_1_1.playerFinisherInfo)
	end

	if arg_1_1:HasField("powerInfo") then
		arg_1_0.powerInfo = FightPowerInfoData.New(arg_1_1.powerInfo)
	end

	if arg_1_1:HasField("cardHeatValue") then
		arg_1_0.cardHeatValue = FightCardHeatValueData.New(arg_1_1.cardHeatValue)
	end

	arg_1_0.fightTasks = {}

	for iter_1_2, iter_1_3 in ipairs(arg_1_1.fightTasks) do
		table.insert(arg_1_0.fightTasks, FightTaskData.New(iter_1_3))
	end

	if arg_1_1:HasField("fight") then
		arg_1_0.fight = FightData.New(arg_1_1.fight)
	end
end

function var_0_0.isDone(arg_2_0)
	return arg_2_0.CUSTOM_ISDONE
end

function var_0_0.setDone(arg_3_0)
	arg_3_0.CUSTOM_ISDONE = true
end

function var_0_0.revertDone(arg_4_0)
	arg_4_0.CUSTOM_ISDONE = false
end

return var_0_0
