module("modules.logic.versionactivity1_2.yaxian.controller.game.step.YaXianStepNextRound", package.seeall)

slot0 = class("YaXianStepNextRound", YaXianStepBase)

function slot0.start(slot0)
	if YaXianGameController.instance.state then
		slot1:setCurEvent(nil)
	end

	YaXianGameModel.instance:setRound(slot0.originData.currentRound)
	YaXianGameController.instance:dispatchEvent(YaXianEvent.UpdateRound)
	slot0:finish()
end

return slot0
