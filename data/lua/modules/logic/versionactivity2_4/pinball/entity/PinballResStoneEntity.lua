module("modules.logic.versionactivity2_4.pinball.entity.PinballResStoneEntity", package.seeall)

slot0 = class("PinballResStoneEntity", PinballResEntity)

function slot0.onHitCount(slot0)
	PinballModel.instance:addGameRes(slot0.resType, slot0.resNum)
	PinballEntityMgr.instance:addNumShow(slot0.resNum, slot0.x + slot0.width, slot0.y + slot0.height)
	PinballEntityMgr.instance:removeEntity(slot0.id)
end

function slot0.onInitByCo(slot0)
	slot0.resNum = tonumber(slot0.spData) or 0
end

return slot0
