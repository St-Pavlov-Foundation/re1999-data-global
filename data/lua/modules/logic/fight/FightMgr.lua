module("modules.logic.fight.FightMgr", package.seeall)

local var_0_0 = class("FightMgr", FightBaseClass)

function var_0_0.onConstructor(arg_1_0)
	return
end

function var_0_0.changeCardScript(arg_2_0, arg_2_1)
	return
end

function var_0_0.startFight(arg_3_0, arg_3_1, arg_3_2)
	FightDataHelper.initDataMgr()
	FightDataHelper.initFightData(arg_3_1)
	arg_3_0:enterStage(FightStageMgr.StageType.Normal)
	arg_3_0:enterStage(FightStageMgr.StageType.Play)
	FightDataHelper.stageMgr:enterFightState(FightStageMgr.FightStateType.Enter)
end

function var_0_0.enterStage(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = FightDataMgr.instance.stageMgr:getCurStage()

	FightDataMgr.instance:enterStage(arg_4_1, arg_4_2)
	FightLocalDataMgr.instance:enterStage(arg_4_1, arg_4_2)
	arg_4_0:com_sendFightEvent(FightEvent.EnterStage, arg_4_1, arg_4_2)
	arg_4_0:com_sendFightEvent(FightEvent.StageChanged, arg_4_1, var_4_0)
end

function var_0_0.exitStage(arg_5_0, arg_5_1)
	FightDataMgr.instance:exitStage(arg_5_1)
	FightLocalDataMgr.instance:exitStage(arg_5_1)
	arg_5_0:com_sendFightEvent(FightEvent.ExitStage, arg_5_1)
	arg_5_0:com_sendFightEvent(FightEvent.StageChanged, FightDataMgr.instance.stageMgr:getCurStage(), arg_5_1)
end

function var_0_0.cancelOperation(arg_6_0)
	arg_6_0:com_sendFightEvent(FightEvent.BeforeCancelOperation)
	FightDataMgr.instance:cancelOperation()
	FightLocalDataMgr.instance:cancelOperation()
	arg_6_0:com_sendFightEvent(FightEvent.CancelOperation)
end

function var_0_0.reconnectFight(arg_7_0)
	return
end

var_0_0.instance = var_0_0.New()

return var_0_0
