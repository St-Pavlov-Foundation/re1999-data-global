module("modules.logic.fight.system.work.FightWorkCompareDataAfterPlay", package.seeall)

local var_0_0 = class("FightWorkCompareDataAfterPlay", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	arg_1_0._flow = FightWorkFlowSequence.New()

	arg_1_0:_registCompareServer()
	arg_1_0:_registRefreshPerformance()
	arg_1_0._flow:registFinishCallback(arg_1_0._onFlowFinish, arg_1_0)
	arg_1_0._flow:start()
end

function var_0_0._registCompareServer(arg_2_0)
	arg_2_0._flow:registWork(FightWorkCompareServerEntityData)
end

function var_0_0._registRefreshPerformance(arg_3_0)
	arg_3_0._flow:registWork(FightWorkRefreshPerformanceEntityData)
	arg_3_0._flow:registWork(FightWorkFunction, arg_3_0.refreshPerformanceData, arg_3_0)
end

function var_0_0.refreshPerformanceData(arg_4_0)
	FightDataUtil.coverData(FightLocalDataMgr.instance.fieldMgr.param, FightDataMgr.instance.fieldMgr.param)
	FightDataUtil.coverData(FightLocalDataMgr.instance.fieldMgr.fightTaskBox, FightDataMgr.instance.fieldMgr.fightTaskBox)
end

function var_0_0._onFlowFinish(arg_5_0)
	FightController.instance:dispatchEvent(FightEvent.AfterCorrectData)
	arg_5_0:onDone(true)
end

function var_0_0.clearWork(arg_6_0)
	if arg_6_0._flow then
		arg_6_0._flow:disposeSelf()

		arg_6_0._flow = nil
	end
end

return var_0_0
