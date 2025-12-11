module("modules.logic.fight.system.work.FightWorkDouQuQuOneRound", package.seeall)

local var_0_0 = class("FightWorkDouQuQuOneRound", FightWorkItem)

function var_0_0.onLogicEnter(arg_1_0, arg_1_1)
	arg_1_0.proto = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	FightDataHelper.paTaMgr:resetOp()
	arg_2_0:com_registFightEvent(FightEvent.OnRoundSequenceFinish, arg_2_0._onRoundSequenceFinish)
	FightModel.instance:updateFightRound(arg_2_0.proto)
	FightGameMgr.playMgr:playShow()
	FightController.instance:dispatchEvent(FightEvent.RespBeginRound)
	arg_2_0:cancelFightWorkSafeTimer()
end

function var_0_0._onRoundSequenceFinish(arg_3_0)
	arg_3_0:onDone(true)
end

return var_0_0
