module("modules.logic.activity.controller.chessmap.step.ActivityChessStepSyncObject", package.seeall)

slot0 = class("ActivityChessStepSyncObject", ActivityChessStepBase)

function slot0.start(slot0)
	slot1 = slot0.originData.object
	slot2 = slot1.id
	slot5 = ActivityChessGameModel.instance:getObjectDataById(slot2).data

	if ActivityChessGameModel.instance:syncObjectData(slot2, slot1.data) ~= nil then
		slot7 = slot4.data

		if slot0:dataHasChanged(slot6, "alertArea") then
			ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.RefreshAlarmArea)
		end

		if slot0:dataHasChanged(slot6, "goToObject") and ActivityChessGameController.instance.interacts:get(slot2) then
			slot8.goToObject:updateGoToObject()
		end

		if slot0:dataHasChanged(slot6, "lostTarget") and ActivityChessGameController.instance.interacts:get(slot2) then
			slot8.effect:refreshSearchFailed()
			slot8.goToObject:refreshTarget()
		end
	end

	slot0:finish()
end

function slot0.dataHasChanged(slot0, slot1, slot2)
	if slot1[slot2] ~= nil or slot1.__deleteFields and slot1.__deleteFields[slot2] then
		return true
	end

	return false
end

function slot0.finish(slot0)
	uv0.super.finish(slot0)
end

return slot0
