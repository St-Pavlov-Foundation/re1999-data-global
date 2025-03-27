module("modules.logic.versionactivity2_4.wuerlixi.model.WuErLiXiMapActUnitMo", package.seeall)

slot0 = pureTable("WuErLiXiMapActUnitMo")

function slot0.ctor(slot0)
	slot0.id = 0
	slot0.type = 0
	slot0.count = 0
	slot0.dir = 0
end

function slot0.init(slot0, slot1)
	slot2 = string.splitToNumber(slot1, "#")
	slot0.type = slot2[1]
	slot0.count = slot2[2]
	slot0.dir = slot2[3]
	slot0.id = slot2[4] or slot2[1]
end

return slot0
