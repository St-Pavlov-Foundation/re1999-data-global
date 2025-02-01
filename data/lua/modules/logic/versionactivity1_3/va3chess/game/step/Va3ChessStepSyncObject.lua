module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepSyncObject", package.seeall)

slot0 = class("Va3ChessStepSyncObject", Va3ChessStepBase)

function slot0.start(slot0)
	slot1 = slot0.originData.object

	if Va3ChessGameModel.instance:getObjectDataById(slot1.id) then
		slot0:_syncObject(slot2, slot1.data, slot1.direction)
	end

	slot0:finish()
end

function slot0._syncObject(slot0, slot1, slot2, slot3)
	if Va3ChessGameModel.instance:syncObjectData(slot1, slot2) == nil then
		return
	end

	if slot0:dataHasChanged(slot4, "alertArea") then
		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RefreshAlarmArea)
	end

	if slot0:dataHasChanged(slot4, "goToObject") and Va3ChessGameController.instance.interacts:get(slot1) then
		slot5.goToObject:updateGoToObject()
	end

	if slot0:dataHasChanged(slot4, "lostTarget") and Va3ChessGameController.instance.interacts:get(slot1) then
		slot5.effect:refreshSearchFailed()
		slot5.goToObject:refreshTarget()
	end

	if slot0:dataHasChanged(slot4, "pedalStatus") and Va3ChessGameController.instance.interacts:get(slot1) and slot5:getHandler().refreshPedalStatus then
		slot5:getHandler():refreshPedalStatus()
	end

	if not Va3ChessGameController.instance.interacts:get(slot1) or not slot5.chessEffectObj then
		return
	end

	if slot2.attributes and slot2.attributes.sleep and slot5.chessEffectObj.setSleep then
		slot5.chessEffectObj:setSleep(slot2.attributes.sleep)
	end

	if slot5.chessEffectObj.refreshKillEffect then
		slot5.chessEffectObj:refreshKillEffect()
	end

	if slot3 then
		slot5:getHandler():faceTo(slot3)
	end
end

function slot0.dataHasChanged(slot0, slot1, slot2)
	if slot1[slot2] ~= nil or slot1.__deleteFields and slot1.__deleteFields[slot2] then
		return true
	end

	return false
end

return slot0
