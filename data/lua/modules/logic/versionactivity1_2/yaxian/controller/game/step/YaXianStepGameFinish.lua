module("modules.logic.versionactivity1_2.yaxian.controller.game.step.YaXianStepGameFinish", package.seeall)

slot0 = class("YaXianStepGameFinish", YaXianStepBase)

function slot0.start(slot0)
	YaXianGameController.instance:setSelectObj(nil)
	Activity115Rpc.instance:sendGetAct115InfoRequest(YaXianGameEnum.ActivityId)
	YaXianGameController.instance:updateAllPosInteractActive()
	TaskDispatcher.runDelay(slot0.openResultView, slot0, YaXianGameEnum.StepFinishDelay)
end

function slot0.openResultView(slot0)
	if slot0.originData.win then
		logNormal("game victory!")
		YaXianGameController.instance:gameVictory()
	else
		logNormal("game over!")
		YaXianGameController.instance:gameOver()
	end

	slot0:finish()
end

function slot0.dispose(slot0)
	TaskDispatcher.cancelTask(slot0.openResultView, slot0)
end

return slot0
