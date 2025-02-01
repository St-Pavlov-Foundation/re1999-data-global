module("modules.logic.seasonver.act166.model.Season166TeachMO", package.seeall)

slot0 = pureTable("Season166TeachMO")

function slot0.ctor(slot0)
	slot0.id = 0
	slot0.passCount = 0
end

function slot0.setData(slot0, slot1)
	slot0.id = slot1.id
	slot0.passCount = slot1.passCount
end

return slot0
