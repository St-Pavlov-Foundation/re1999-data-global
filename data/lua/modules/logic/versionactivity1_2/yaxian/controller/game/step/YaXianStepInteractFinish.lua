module("modules.logic.versionactivity1_2.yaxian.controller.game.step.YaXianStepInteractFinish", package.seeall)

slot0 = class("YaXianStepInteractFinish", YaXianStepBase)

function slot0.start(slot0)
	YaXianGameModel.instance:addFinishInteract(slot0.originData.id)
	YaXianGameController.instance:dispatchEvent(YaXianEvent.OnInteractFinish)
	slot0:finish()
end

return slot0
