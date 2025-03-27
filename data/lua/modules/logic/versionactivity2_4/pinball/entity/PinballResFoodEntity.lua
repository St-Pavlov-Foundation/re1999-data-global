module("modules.logic.versionactivity2_4.pinball.entity.PinballResFoodEntity", package.seeall)

slot0 = class("PinballResFoodEntity", PinballResEntity)

function slot0.onHitCount(slot0)
	for slot6 = 1, slot0.divNum do
		slot8 = PinballEntityMgr.instance:addEntity(PinballEnum.UnitType.ResSmallFood)

		slot8:initByCo(slot0.unitCo)

		slot9, slot10 = PinballHelper.rotateAngle(slot8.width * slot0.childScale * 0.5 + slot0.width * 0.5, slot8.height * slot0.childScale * 0.5 + slot0.height * 0.5, math.random(0, 360) + 360 / slot0.divNum * slot6)
		slot8.x = slot9 + slot0.x
		slot8.y = slot10 + slot0.y
		slot8.resNum = slot0.resNum
		slot8.scale = slot0.childScale * slot0.scale
		slot8.width = slot8.width * slot0.childScale
		slot8.height = slot8.height * slot0.childScale

		slot8:loadRes()
		slot8:tick(0)
		slot8:playAnim("clone")
	end

	PinballEntityMgr.instance:removeEntity(slot0.id)
end

function slot0.onInitByCo(slot0)
	slot1 = string.splitToNumber(slot0.spData, "#") or {}
	slot0.resNum = slot1[1] or 0
	slot0.divNum = slot1[2] or 0
	slot0.childScale = (slot1[3] or 1000) / 1000
end

return slot0
