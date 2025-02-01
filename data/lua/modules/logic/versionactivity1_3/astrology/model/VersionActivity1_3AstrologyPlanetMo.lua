module("modules.logic.versionactivity1_3.astrology.model.VersionActivity1_3AstrologyPlanetMo", package.seeall)

slot0 = pureTable("VersionActivity1_3AstrologyPlanetMo")

function slot0.init(slot0, slot1)
	slot0.id = slot1.id
	slot0.angle = slot1.angle
	slot0.previewAngle = slot1.angle
	slot0.num = slot1.num
	slot0.config = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.Item, VersionActivity1_3AstrologyEnum.PlanetItem[slot0.id])
end

function slot0.updatePreviewAngle(slot0, slot1)
	slot0.deltaAngle = slot1
	slot0.previewAngle = slot0.previewAngle + slot1

	if 360 <= slot0.previewAngle then
		slot0.previewAngle = slot0.previewAngle - slot2
	elseif slot0.previewAngle <= -slot2 then
		slot0.previewAngle = slot0.previewAngle + slot2
	end
end

function slot0.getQuadrant(slot0)
	if math.ceil(slot0.previewAngle % 360 / 45) == 0 then
		slot3 = 1
	end

	return 9 - slot3
end

function slot0.getItemName(slot0)
	return slot0.config.name
end

function slot0.isFront(slot0, slot1)
	return (slot1 or slot0.previewAngle) % 360 >= 0 and slot2 <= 180
end

function slot0.getRemainNum(slot0)
	return slot0.num - slot0:getCostNum()
end

function slot0.getCostNum(slot0)
	return slot0:minDeltaAngle() / VersionActivity1_3AstrologyEnum.Angle
end

function slot0.minDeltaAngle(slot0)
	slot1 = math.abs(slot0.previewAngle % 360 - slot0.angle % 360)

	return math.min(slot1, 360 - slot1)
end

function slot0.hasAdjust(slot0)
	return slot0.angle % 360 ~= slot0.previewAngle % 360
end

return slot0
