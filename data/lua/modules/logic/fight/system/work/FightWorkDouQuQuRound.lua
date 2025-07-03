module("modules.logic.fight.system.work.FightWorkDouQuQuRound", package.seeall)

local var_0_0 = class("FightWorkDouQuQuRound", FightWorkItem)

function var_0_0.onStart(arg_1_0)
	arg_1_0.douQuQuMgr = FightDataModel.instance.douQuQuMgr

	if arg_1_0.douQuQuMgr.isFinish then
		arg_1_0:onDone(true)

		return
	end

	arg_1_0:cancelFightWorkSafeTimer()
	arg_1_0:com_registMsg(FightMsgId.FightAct174Reply, arg_1_0._onFightAct174Reply)
	Activity174Rpc.instance:sendViewFightAct174Request(arg_1_0.douQuQuMgr.index, arg_1_0.douQuQuMgr.round + 1)
end

function var_0_0._onFightAct174Reply(arg_2_0, arg_2_1)
	FightDataHelper.paTaMgr:resetOp()
	arg_2_0:com_registFightEvent(FightEvent.OnRoundSequenceFinish, arg_2_0._onRoundSequenceFinish)
	FightModel.instance:updateFightRound(arg_2_1.fightRound)
	FightSystem.instance:startRound()
	FightController.instance:dispatchEvent(FightEvent.RespBeginRound)
end

function var_0_0._onRoundSequenceFinish(arg_3_0)
	if arg_3_0.douQuQuMgr.isFinish then
		arg_3_0:onDone(true)

		return
	end

	Activity174Rpc.instance:sendViewFightAct174Request(arg_3_0.douQuQuMgr.index, arg_3_0.douQuQuMgr.round + 1)
end

return var_0_0
