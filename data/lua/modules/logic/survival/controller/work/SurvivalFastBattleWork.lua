module("modules.logic.survival.controller.work.SurvivalFastBattleWork", package.seeall)

local var_0_0 = class("SurvivalFastBattleWork", SurvivalStepBaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0._stepMo.paramInt[1] or 0
	local var_1_1 = SurvivalMapHelper.instance:getEntity(var_1_0)

	if not var_1_1 then
		arg_1_0:onDone(true)

		return
	end

	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_killed)
	var_1_1:addEffect(SurvivalEnum.UnitEffectPath.FastFight)

	arg_1_0._entity = var_1_1

	TaskDispatcher.runDelay(arg_1_0._delayDone, arg_1_0, SurvivalEnum.UnitEffectTime[SurvivalEnum.UnitEffectPath.FastFight])
end

function var_0_0._delayDone(arg_2_0)
	arg_2_0._entity:removeEffect(SurvivalEnum.UnitEffectPath.FastFight)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	arg_3_0._entity = nil

	TaskDispatcher.cancelTask(arg_3_0._delayDone, arg_3_0)
end

return var_0_0
