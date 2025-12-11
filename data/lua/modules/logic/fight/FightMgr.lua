module("modules.logic.fight.FightMgr", package.seeall)

local var_0_0 = class("FightMgr", FightBaseClass)

function var_0_0.onConstructor(arg_1_0)
	return
end

function var_0_0.startFight(arg_2_0, arg_2_1, arg_2_2)
	FightDataHelper.initDataMgr()
	FightDataHelper.initFightData(arg_2_1)
	FightDataHelper.stageMgr:setStage(FightStageMgr.StageType.Play)
	FightDataHelper.stageMgr:enterFightState(FightStageMgr.FightStateType.Enter)
end

function var_0_0.cancelOperation(arg_3_0)
	arg_3_0:com_sendFightEvent(FightEvent.BeforeCancelOperation)
	FightDataMgr.instance:cancelOperation()
	FightLocalDataMgr.instance:cancelOperation()
	arg_3_0:com_sendFightEvent(FightEvent.CancelOperation)
end

function var_0_0.reconnectFight(arg_4_0)
	return
end

var_0_0.instance = var_0_0.New()

return var_0_0
