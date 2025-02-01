module("modules.logic.versionactivity1_2.yaxian.controller.game.step.YaXianStepCreateObject", package.seeall)

slot0 = class("YaXianStepCreateObject", YaXianStepBase)

function slot0.start(slot0)
	slot1 = slot0.originData.id

	YaXianGameModel.instance:removeObjectById(slot1)
	YaXianGameController.instance:deleteInteractObj(slot1)

	slot2 = YaXianGameModel.instance:addObject(slot0.originData)

	YaXianGameController.instance:addInteractObj(slot2)
	logNormal("create object finish !" .. tostring(slot2.id))
	slot0:finish()
end

return slot0
