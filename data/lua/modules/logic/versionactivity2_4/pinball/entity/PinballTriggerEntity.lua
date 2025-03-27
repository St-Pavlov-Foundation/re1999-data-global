module("modules.logic.versionactivity2_4.pinball.entity.PinballTriggerEntity", package.seeall)

slot0 = class("PinballTriggerEntity", PinballColliderEntity)

function slot0.onHitEnter(slot0, slot1, slot2, slot3, slot4)
	slot5 = PinballEntityMgr.instance:addEntity(PinballEnum.UnitType.CommonEffect)

	slot5:setDelayDispose(2)

	slot5.x = slot2
	slot5.y = slot3

	slot5:tick(0)
	slot5:playAnim("hit")
end

return slot0
