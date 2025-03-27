module("modules.logic.versionactivity2_4.pinball.model.PinballUnitCo", package.seeall)

slot0 = pureTable("PinballUnitCo")

function slot0.init(slot0, slot1)
	slot0.unitType = slot1[1]
	slot0.posX = slot1[2]
	slot0.posY = slot1[3]
	slot0.specialData = slot1[4]
	slot0.angle = slot1[5] or 0
	slot0.spriteName = slot1[6] or ""
	slot0.size = slot1[7] and Vector2(slot1[7][1], slot1[7][2]) or Vector2()
	slot0.shape = slot1[8] or PinballEnum.Shape.Rect
	slot0.scale = slot1[9] or 1
	slot0.resType = slot1[10] or PinballEnum.ResType.Food
	slot0.speed = slot1[11] and Vector2(slot1[11][1], slot1[11][2]) or Vector2()
end

return slot0
