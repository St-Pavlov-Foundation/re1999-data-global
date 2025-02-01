module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepCreateObject", package.seeall)

slot0 = class("Va3ChessStepCreateObject", Va3ChessStepBase)

function slot0.start(slot0)
	slot1 = slot0.originData.id

	Va3ChessGameModel.instance:removeObjectById(slot1)
	Va3ChessGameController.instance:deleteInteractObj(slot1)

	slot2 = Va3ChessGameModel.instance:getActId()
	slot3 = Va3ChessGameModel.instance:addObject(slot2, slot0.originData)

	slot3:setHaveBornEff(true)
	Va3ChessGameController.instance:addInteractObj(slot3)
	logNormal("create object finish !" .. tostring(slot3.id))

	if Va3ChessConfig.instance:getInteractObjectCo(slot2, slot1) and slot4.createAudioId and slot4.createAudioId ~= 0 then
		AudioMgr.instance:trigger(slot4.createAudioId)
	end

	slot0:finish()
end

return slot0
