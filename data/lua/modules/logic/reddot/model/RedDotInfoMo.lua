module("modules.logic.reddot.model.RedDotInfoMo", package.seeall)

slot0 = pureTable("RedDotInfoMo")

function slot0.init(slot0, slot1)
	slot0.uid = tonumber(slot1.id)
	slot0.value = tonumber(slot1.value)
	slot0.time = slot1.time
	slot0.ext = slot1.ext
end

function slot0.reset(slot0, slot1)
	slot0.value = tonumber(slot1.value)
	slot0.time = slot1.time
	slot0.ext = slot1.ext
end

return slot0
