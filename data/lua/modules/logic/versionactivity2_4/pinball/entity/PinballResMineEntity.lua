module("modules.logic.versionactivity2_4.pinball.entity.PinballResMineEntity", package.seeall)

slot0 = class("PinballResMineEntity", PinballResEntity)

function slot0.onHitEnter(slot0, slot1, slot2, slot3, slot4)
	if not PinballEntityMgr.instance:getEntity(slot1) then
		return
	end

	if slot5:isResType() then
		slot5:doHit(1)
	end
end

function slot0.onHitCount(slot0, slot1)
	slot0.totalHitCount = slot0.totalHitCount - (slot1 or 1)

	if slot0.linkEntity then
		slot0.linkEntity.totalHitCount = slot0.linkEntity.totalHitCount - slot1
	end

	if slot0.totalHitCount <= 0 then
		PinballModel.instance:addGameRes(slot0.resType, slot0.resNum)
		PinballEntityMgr.instance:addNumShow(slot0.resNum, slot0.x + slot0.width, slot0.y + slot0.height)
		PinballEntityMgr.instance:removeEntity(slot0.id)
	end
end

function slot0.onCreateLinkEntity(slot0, slot1)
	slot1.totalHitCount = slot0.totalHitCount
end

function slot0.onInitByCo(slot0)
	slot1 = string.splitToNumber(slot0.spData, "#") or {}
	slot0.totalHitCount = slot1[1] or 0
	slot0.resNum = slot1[2] or 0
end

return slot0
