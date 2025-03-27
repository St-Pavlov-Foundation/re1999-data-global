module("modules.logic.versionactivity2_4.pinball.entity.PinballTriggerElasticityEntity", package.seeall)

slot0 = class("PinballTriggerElasticityEntity", PinballTriggerEntity)

function slot0.onInit(slot0)
	uv0.super.onInit(slot0)
end

function slot0.onInitByCo(slot0)
	slot0.force = (tonumber(slot0.spData) or 1000) / 1000
	slot0.baseForceX = slot0.force
	slot0.baseForceY = slot0.force
end

return slot0
