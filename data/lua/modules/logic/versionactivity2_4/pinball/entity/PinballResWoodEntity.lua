module("modules.logic.versionactivity2_4.pinball.entity.PinballResWoodEntity", package.seeall)

slot0 = class("PinballResWoodEntity", PinballResEntity)

function slot0.isBounce(slot0)
	return false
end

function slot0.onHitEnter(slot0, slot1, slot2, slot3, slot4)
	if not PinballEntityMgr.instance:getEntity(slot1) then
		return
	end

	slot5.vx = slot5.vx * (1 - slot0.decv)
	slot5.vy = slot5.vy * (1 - slot0.decv)
end

function slot0.onHitCount(slot0)
	PinballModel.instance:addGameRes(slot0.resType, slot0.resNum)
	PinballEntityMgr.instance:addNumShow(slot0.resNum, slot0.x + slot0.width, slot0.y + slot0.height)
	slot0:markDead()
end

function slot0.onInitByCo(slot0)
	slot1 = string.splitToNumber(slot0.spData, "#") or {}
	slot0.resNum = slot1[1] or 0
	slot0.decv = (slot1[2] or 0) / 1000
	slot0.decv = Mathf.Clamp(slot0.decv, 0, 1)
end

return slot0
