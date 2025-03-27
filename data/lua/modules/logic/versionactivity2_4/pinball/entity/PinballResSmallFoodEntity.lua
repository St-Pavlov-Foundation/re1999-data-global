module("modules.logic.versionactivity2_4.pinball.entity.PinballResSmallFoodEntity", package.seeall)

slot0 = class("PinballResSmallFoodEntity", PinballResEntity)

function slot0.initByCo(slot0, slot1)
	uv0.super.initByCo(slot0, slot1)

	slot0._initDt = UnityEngine.Time.realtimeSinceStartup
end

function slot0.onHitCount(slot0)
	PinballModel.instance:addGameRes(slot0.resType, slot0.resNum)
	PinballEntityMgr.instance:addNumShow(slot0.resNum, slot0.x + slot0.width, slot0.y + slot0.height)
	PinballEntityMgr.instance:removeEntity(slot0.id)
end

return slot0
