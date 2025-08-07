module("modules.logic.sp01.assassin2.controller.stealthgameflow.StealthEnemyTurnEndWork", package.seeall)

local var_0_0 = class("StealthEnemyTurnEndWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0, var_1_1, var_1_2 = AssassinStealthGameModel.instance:getMapPosRecordOnTurn()

	if var_1_0 and var_1_1 and var_1_2 then
		AssassinStealthGameModel.instance:setMapPosRecordOnTurn()
		AssassinStealthGameController.instance:dispatchEvent(AssassinEvent.TweenStealthMapPos, {
			x = var_1_0,
			y = var_1_1,
			scale = var_1_2
		})
		TaskDispatcher.cancelTask(arg_1_0._tweenMapFinished, arg_1_0)
		TaskDispatcher.runDelay(arg_1_0._tweenMapFinished, arg_1_0, AssassinEnum.StealthConst.MapTweenPosTime)
	else
		arg_1_0:_tweenMapFinished()
	end
end

function var_0_0._tweenMapFinished(arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._tweenMapFinished, arg_3_0)
end

return var_0_0
