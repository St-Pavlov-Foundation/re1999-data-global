module("modules.logic.antique.model.AntiqueMo", package.seeall)

slot0 = pureTable("AntiqueMo")

function slot0.ctor(slot0)
	slot0.id = 0
	slot0.getTime = 0
end

function slot0.init(slot0, slot1)
	slot0.id = tonumber(slot1.antiqueId)
	slot0.getTime = slot1.getTime
end

function slot0.reset(slot0, slot1)
	slot0.id = tonumber(slot1.antiqueId)
	slot0.getTime = slot1.getTime
end

return slot0
