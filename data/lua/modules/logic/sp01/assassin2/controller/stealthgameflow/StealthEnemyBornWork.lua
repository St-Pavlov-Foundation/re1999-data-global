module("modules.logic.sp01.assassin2.controller.stealthgameflow.StealthEnemyBornWork", package.seeall)

local var_0_0 = class("StealthEnemyBornWork", BaseWork)
local var_0_1 = 0.5

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = AssassinStealthGameModel.instance:getEnemyOperationData()
	local var_1_1 = var_1_0 and var_1_0.summons

	if var_1_1 and #var_1_1 > 0 then
		AssassinStealthGameController.instance:enemyBornByList(var_1_1)
		TaskDispatcher.cancelTask(arg_1_0._bornEnemyFinished, arg_1_0)
		TaskDispatcher.runDelay(arg_1_0._bornEnemyFinished, arg_1_0, var_0_1)
	else
		arg_1_0:_bornEnemyFinished()
	end
end

function var_0_0._bornEnemyFinished(arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._bornEnemyFinished, arg_3_0)
end

return var_0_0
