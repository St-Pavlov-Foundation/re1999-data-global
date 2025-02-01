module("modules.logic.versionactivity1_2.yaxian.controller.game.step.YaXianStepDeleteObject", package.seeall)

slot0 = class("YaXianStepDeleteObject", YaXianStepBase)

function slot0.start(slot0)
	if YaXianGameModel.instance:getPlayerInteractMo() and slot1.id == slot0.originData.id and slot0.originData.reason == YaXianGameEnum.DeleteInteractReason.Win then
		slot0:finish()

		return
	end

	YaXianGameController.instance:dispatchEvent(YaXianEvent.DeleteInteractObj, slot0.originData.id)
	slot0:finish()
end

return slot0
