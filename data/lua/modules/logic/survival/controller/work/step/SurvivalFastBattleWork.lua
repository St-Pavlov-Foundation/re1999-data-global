module("modules.logic.survival.controller.work.step.SurvivalFastBattleWork", package.seeall)

local var_0_0 = class("SurvivalFastBattleWork", SurvivalStepBaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0._stepMo.paramInt[1] or 0
	local var_1_1 = SurvivalMapHelper.instance:getEntity(var_1_0)

	if not var_1_1 then
		arg_1_0:onDone(true)

		return
	end

	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_killed)
	var_1_1:addEffect(SurvivalConst.UnitEffectPath.FastFight)

	arg_1_0._entity = var_1_1

	TaskDispatcher.runDelay(arg_1_0._delayDone, arg_1_0, SurvivalConst.UnitEffectTime[SurvivalConst.UnitEffectPath.FastFight])
end

function var_0_0._delayDone(arg_2_0)
	arg_2_0._entity:removeEffect(SurvivalConst.UnitEffectPath.FastFight)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	arg_3_0._entity = nil

	TaskDispatcher.cancelTask(arg_3_0._delayDone, arg_3_0)
end

function var_0_0.getRunOrder(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2:addWork(arg_4_0)

	arg_4_1.beforeFlow = FlowParallel.New()

	arg_4_2:addWork(arg_4_1.beforeFlow)

	arg_4_1.moveIdSet = {}
	arg_4_1.haveHeroMove = false

	return SurvivalEnum.StepRunOrder.None
end

return var_0_0
