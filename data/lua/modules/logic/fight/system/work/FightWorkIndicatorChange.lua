module("modules.logic.fight.system.work.FightWorkIndicatorChange", package.seeall)

local var_0_0 = class("FightWorkIndicatorChange", FightEffectBase)

var_0_0.ConfigEffect = {
	ClearIndicator = 60017,
	AddIndicator = 60016
}

function var_0_0.onStart(arg_1_0)
	local var_1_0 = tonumber(arg_1_0.actEffectData.targetId)

	FightModel.instance:setWaitIndicatorAnimation(false)
	arg_1_0:com_sendFightEvent(FightEvent.OnIndicatorChange, var_1_0, arg_1_0.actEffectData.effectNum)

	if FightModel.instance:isWaitIndicatorAnimation() then
		arg_1_0:com_registTimer(arg_1_0._delayDone, 3)
		arg_1_0:com_registFightEvent(FightEvent.OnIndicatorAnimationDone, arg_1_0._delayDone)
	else
		arg_1_0:onDone(true)
	end
end

function var_0_0._delayDone(arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	return
end

return var_0_0
