module("modules.logic.versionactivity2_4.pinball.entity.PinballTriggerObstacleEntity", package.seeall)

slot0 = class("PinballTriggerObstacleEntity", PinballTriggerEntity)

function slot0.onInitByCo(slot0)
	slot0.force = (tonumber(slot0.spData) or 1000) / 1000
	slot0.baseForceX = slot0.force
	slot0.baseForceY = slot0.force
end

return slot0
