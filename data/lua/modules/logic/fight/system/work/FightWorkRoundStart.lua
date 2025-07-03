module("modules.logic.fight.system.work.FightWorkRoundStart", package.seeall)

local var_0_0 = class("FightWorkRoundStart", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	FightController.instance:dispatchEvent(FightEvent.FightRoundStart)

	FightDataHelper.operationDataMgr.extraMoveAct = 0
	FightLocalDataMgr.instance.extraMoveAct = 0

	arg_1_0:onDone(true)
end

function var_0_0.clearWork(arg_2_0)
	return
end

return var_0_0
