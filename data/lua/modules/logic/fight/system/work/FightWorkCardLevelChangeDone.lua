module("modules.logic.fight.system.work.FightWorkCardLevelChangeDone", package.seeall)

local var_0_0 = class("FightWorkCardLevelChangeDone", BaseWork)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.onStart(arg_2_0)
	if FightCardModel.instance:isChanging() then
		TaskDispatcher.runDelay(arg_2_0._delayDone, arg_2_0, 10)
		FightController.instance:registerCallback(FightEvent.OnChangeCardEffectDone, arg_2_0._onChangeCardEffectDone, arg_2_0)
	else
		arg_2_0:onDone(true)
	end
end

function var_0_0._onChangeCardEffectDone(arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.OnChangeCardEffectDone, arg_3_0._onChangeCardEffectDone, arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0._delayDone(arg_4_0)
	if FightCardModel.instance:isChanging() then
		logError("卡牌升降星超时，isChanging=true")
	else
		logError("卡牌升降星超时，isChanging=false")
	end

	arg_4_0:onDone(true)
end

function var_0_0.clearWork(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._delayDone, arg_5_0)
	FightController.instance:unregisterCallback(FightEvent.OnChangeCardEffectDone, arg_5_0._onChangeCardEffectDone, arg_5_0)
end

return var_0_0
