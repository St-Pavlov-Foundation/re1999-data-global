module("modules.logic.fight.model.mo.FightActEffectMO", package.seeall)

local var_0_0 = pureTable("FightActEffectMO")
local var_0_1 = 1

function var_0_0.ctor(arg_1_0)
	arg_1_0.clientId = var_0_1
	var_0_1 = var_0_1 + 1
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

function var_0_0.init(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.targetId = arg_5_1.targetId
	arg_5_0.effectType = arg_5_1.effectType
	arg_5_0.effectNum = arg_5_1.effectNum
	arg_5_0.effectNum1 = arg_5_1.effectNum1
	arg_5_0.fromSide = arg_5_2
	arg_5_0.configEffect = arg_5_1.configEffect
	arg_5_0.buffActId = arg_5_1.buffActId
	arg_5_0.reserveId = arg_5_1.reserveId
	arg_5_0.reserveStr = arg_5_1.reserveStr
	arg_5_0.summoned = arg_5_1.summoned

	if arg_5_1:HasField("buff") then
		arg_5_0.buff = arg_5_0:_buildBuff(arg_5_1.buff)
	end

	if arg_5_1:HasField("entity") then
		arg_5_0.entityMO = arg_5_0:_buildEntity(arg_5_1.entity, arg_5_2)
	end

	arg_5_0.magicCircle = arg_5_1.magicCircle
	arg_5_0.cardInfo = arg_5_1.cardInfo
	arg_5_0.cardInfoList = arg_5_1.cardInfoList
	arg_5_0.teamType = arg_5_1.teamType
	arg_5_0.fightStep = arg_5_1.fightStep
	arg_5_0.assistBossInfo = arg_5_1.assistBossInfo

	if arg_5_0.effectType == FightEnum.EffectType.FIGHTSTEP then
		arg_5_0.cus_stepMO = FightStepMO.New()

		arg_5_0.cus_stepMO:init(arg_5_0.fightStep)
	end

	if arg_5_1:HasField("emitterInfo") then
		arg_5_0.emitterInfo = FightASFDEmitterInfoMO.New()

		arg_5_0.emitterInfo:init(arg_5_1.emitterInfo)
	else
		arg_5_0.emitterInfo = nil
	end

	arg_5_0.playerFinisherInfo = arg_5_1.playerFinisherInfo
	arg_5_0.powerInfo = arg_5_1.powerInfo
	arg_5_0.cardHeatValue = arg_5_1.cardHeatValue
	arg_5_0.fightTasks = arg_5_1.fightTasks
end

function var_0_0._buildBuff(arg_6_0, arg_6_1)
	local var_6_0 = FightBuffMO.New()

	var_6_0:init(arg_6_1, arg_6_0.targetId)

	return var_6_0
end

function var_0_0._buildEntity(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = FightEntityMO.New()

	var_7_0:init(arg_7_1, arg_7_2)

	return var_7_0
end

return var_0_0
