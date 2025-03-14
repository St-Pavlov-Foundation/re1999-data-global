module("modules.logic.backpack.model.MaterialDataMO", package.seeall)

slot0 = pureTable("MaterialDataMO")

function slot0.ctor(slot0)
	slot0.materilType = nil
	slot0.materilId = nil
	slot0.quantity = nil
	slot0.uid = nil
	slot0.roomBuildingLevel = nil
end

function slot0.init(slot0, slot1)
	slot0.materilType = slot1.materilType
	slot0.materilId = slot1.materilId
	slot0.quantity = slot1.quantity
	slot0.uid = slot1.uid
	slot0.roomBuildingLevel = slot1.roomBuildingLevel
end

function slot0.initValue(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.materilType = slot1
	slot0.materilId = slot2
	slot0.quantity = slot3
	slot0.uid = slot4
	slot0.roomBuildingLevel = slot5
end

return slot0
