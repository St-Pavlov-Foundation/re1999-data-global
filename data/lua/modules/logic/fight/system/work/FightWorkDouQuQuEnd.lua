module("modules.logic.fight.system.work.FightWorkDouQuQuEnd", package.seeall)

local var_0_0 = class("FightWorkDouQuQuEnd", FightWorkItem)

function var_0_0.onStart(arg_1_0)
	arg_1_0:cancelFightWorkSafeTimer()
	arg_1_0:com_registFightEvent(FightEvent.DouQuQuSettlementFinish, arg_1_0._onDouQuQuSettlementFinish)
	Activity174Controller.instance:openFightResultView()
end

function var_0_0._onDouQuQuSettlementFinish(arg_2_0)
	FightSystem.instance:dispose()
	FightModel.instance:clearRecordMO()
	FightController.instance:exitFightScene()
end

return var_0_0
