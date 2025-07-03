module("modules.logic.fight.system.work.FightWorkPlayCardIndex", package.seeall)

local var_0_0 = class("FightWorkPlayCardIndex", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.fightStepData = arg_1_1
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	if FightHelper.isPlayerCardSkill(arg_2_0.fightStepData) then
		FightController.instance:dispatchEvent(FightEvent.InvalidUsedCard, arg_2_0.fightStepData.cardIndex, -1)
		FightPlayCardModel.instance:playCard(arg_2_0.fightStepData.cardIndex)
		TaskDispatcher.runDelay(arg_2_0._delayAfterDissolveCard, arg_2_0, 1 / FightModel.instance:getUISpeed())
	else
		arg_2_0:onDone(true)
	end
end

function var_0_0._delayAfterDissolveCard(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._delayAfterDissolveCard, arg_4_0)
end

return var_0_0
