module("modules.logic.herogroup.model.HeroGroupActivity104EquipMo", package.seeall)

slot0 = pureTable("HeroGroupActivity104EquipMo")

function slot0.init(slot0, slot1)
	slot0.index = slot1.index

	if slot0.index == 4 then
		if not slot0._mainCardNum then
			slot0.equipUid = {
				slot1.equipUid and slot1.equipUid[1] or "0"
			}
		else
			slot0.equipUid = {}

			for slot5 = 1, slot0._mainCardNum do
				table.insert(slot0.equipUid, slot1.equipUid and slot1.equipUid[slot5] or "0")
			end
		end
	else
		slot0.equipUid = {}

		if not slot0._normalCardNum then
			for slot5 = 1, 2 do
				table.insert(slot0.equipUid, slot1.equipUid and slot1.equipUid[slot5] or "0")
			end
		else
			for slot5 = 1, slot0._normalCardNum do
				table.insert(slot0.equipUid, slot1.equipUid and slot1.equipUid[slot5] or "0")
			end
		end
	end
end

function slot0.setLimitNum(slot0, slot1, slot2)
	slot0._normalCardNum = slot2
	slot0._mainCardNum = slot1
end

function slot0.getEquipUID(slot0, slot1)
	if not slot0.equipUid then
		return
	end

	return slot0.equipUid[slot1]
end

return slot0
