module("modules.logic.rouge.model.RougeNewReddotNOMO", package.seeall)

slot0 = pureTable("RougeNewReddotNOMO")

function slot0.init(slot0, slot1)
	slot0.type = slot1.type
	slot0.idNum = #slot1.ids
	slot0.idMap = {}

	for slot5, slot6 in ipairs(slot1.ids) do
		slot0.idMap[slot6] = slot6
	end
end

function slot0.removeId(slot0, slot1)
	if slot1 == 0 then
		slot0.idMap = {}
		slot0.idNum = 0
	end

	if slot0.idMap[slot1] then
		slot0.idMap[slot1] = nil
		slot0.idNum = slot0.idNum - 1
	end
end

return slot0
