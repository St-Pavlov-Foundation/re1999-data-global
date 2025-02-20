module("modules.logic.tower.model.TowerOpenMo", package.seeall)

slot0 = pureTable("TowerOpenMo")

function slot0.init(slot0, slot1)
	slot0.id = slot1
end

function slot0.updateInfo(slot0, slot1)
	slot0.type = slot1.type
	slot0.towerId = slot1.towerId
	slot0.id = slot1.towerId
	slot0.status = slot1.status
	slot0.round = slot1.round
	slot0.nextTime = slot1.nextTime
end

return slot0
