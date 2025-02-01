module("modules.logic.activity.controller.chessmap.step.ActivityChessStepCreateObject", package.seeall)

slot0 = class("ActivityChessStepCreateObject", ActivityChessStepBase)

function slot0.start(slot0)
	slot1 = slot0.originData.id
	slot2 = slot0.originData.x
	slot3 = slot0.originData.y

	ActivityChessGameModel.instance:removeObjectById(slot1)
	ActivityChessGameController.instance:deleteInteractObj(slot1)

	slot5 = ActivityChessGameModel.instance:addObject(ActivityChessGameModel.instance:getActId(), slot0.originData)

	ActivityChessGameController.instance:addInteractObj(slot5)
	logNormal("create object finish !" .. tostring(slot5.id))
	slot0:finish()
end

return slot0
