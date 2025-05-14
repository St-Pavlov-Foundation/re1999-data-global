module("modules.logic.versionactivity1_2.yaxian.controller.game.step.YaXianStepGameFinish", package.seeall)

local var_0_0 = class("YaXianStepGameFinish", YaXianStepBase)

function var_0_0.start(arg_1_0)
	YaXianGameController.instance:setSelectObj(nil)
	Activity115Rpc.instance:sendGetAct115InfoRequest(YaXianGameEnum.ActivityId)
	YaXianGameController.instance:updateAllPosInteractActive()
	TaskDispatcher.runDelay(arg_1_0.openResultView, arg_1_0, YaXianGameEnum.StepFinishDelay)
end

function var_0_0.openResultView(arg_2_0)
	if arg_2_0.originData.win then
		logNormal("game victory!")
		YaXianGameController.instance:gameVictory()
	else
		logNormal("game over!")
		YaXianGameController.instance:gameOver()
	end

	arg_2_0:finish()
end

function var_0_0.dispose(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0.openResultView, arg_3_0)
end

return var_0_0
