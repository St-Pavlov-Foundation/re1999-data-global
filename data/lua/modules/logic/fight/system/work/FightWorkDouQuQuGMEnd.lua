module("modules.logic.fight.system.work.FightWorkDouQuQuGMEnd", package.seeall)

local var_0_0 = class("FightWorkDouQuQuGMEnd", FightWorkItem)

function var_0_0.onStart(arg_1_0)
	arg_1_0:cancelFightWorkSafeTimer()
	arg_1_0:_onDouQuQuSettlementFinish()
end

function var_0_0._onDouQuQuSettlementFinish(arg_2_0)
	FightSystem.instance:dispose()
	FightModel.instance:clearRecordMO()
	FightController.instance:exitFightScene()
end

return var_0_0
