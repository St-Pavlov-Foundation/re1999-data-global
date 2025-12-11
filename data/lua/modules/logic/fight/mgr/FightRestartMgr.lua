module("modules.logic.fight.mgr.FightRestartMgr", package.seeall)

local var_0_0 = class("FightRestartMgr", FightBaseClass)

function var_0_0.onConstructor(arg_1_0)
	return
end

function var_0_0.restart(arg_2_0)
	FightSystem.instance.restarting = true

	local var_2_0 = arg_2_0:com_registFlowSequence()

	var_2_0:registWork(FightRestartSequence)
	var_2_0:registFinishCallback(arg_2_0.onRestartFinish)
	var_2_0:start()
end

function var_0_0.onRestartFinish(arg_3_0)
	FightSystem.instance.restarting = false
end

function var_0_0.cancelRestart(arg_4_0)
	FightSystem.instance.restarting = false
end

function var_0_0.restartFightFail(arg_5_0)
	ToastController.instance:showToast(-80)
	arg_5_0:cancelRestart()
	FightController.instance:exitFightScene()
end

function var_0_0.directStartNewFight(arg_6_0)
	arg_6_0:com_registWork(FightWorkDirectStartNewFightAfterEndFight):start()
end

function var_0_0.fastRestart(arg_7_0)
	FightSystem.instance.restarting = true

	local var_7_0 = arg_7_0:com_registFlowSequence()

	var_7_0:registWork(FightRestartSequence)
	var_7_0:registFinishCallback(arg_7_0.onRestartFinish)
	var_7_0:start()
end

function var_0_0.onDestructor(arg_8_0)
	FightSystem.instance.restarting = false
end

return var_0_0
