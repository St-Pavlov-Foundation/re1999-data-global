module("modules.logic.fight.system.work.FightWorkEffectDealCard1", package.seeall)

local var_0_0 = class("FightWorkEffectDealCard1", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	if FightModel.instance:getVersion() < 4 then
		arg_1_0:onDone(true)

		return
	end

	local var_1_0 = arg_1_0:com_registWorkDoneFlowSequence()

	var_1_0:registWork(FightWorkDistributeCard)
	var_1_0:registWork(FightWorkFunction, arg_1_0._afterDistribute, arg_1_0)
	var_1_0:start()
end

function var_0_0._afterDistribute(arg_2_0)
	return
end

function var_0_0.clearWork(arg_3_0)
	return
end

return var_0_0
