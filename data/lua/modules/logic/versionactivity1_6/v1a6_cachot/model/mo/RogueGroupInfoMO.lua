module("modules.logic.versionactivity1_6.v1a6_cachot.model.mo.RogueGroupInfoMO", package.seeall)

slot0 = pureTable("RogueGroupInfoMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1.id
	slot0.name = slot1.name
	slot0.clothId = slot1.clothId
	slot0.heroList = {}

	for slot5, slot6 in ipairs(slot1.heroList) do
		table.insert(slot0.heroList, HeroModel.instance:getByHeroId(slot6) and slot7.uid or "0")
	end

	slot0.equips = {}

	for slot5, slot6 in ipairs(slot1.equips) do
		slot7 = HeroGroupEquipMO.New()

		slot7:init(slot6)
		table.insert(slot0.equips, slot7)
	end
end

function slot0.getFirstEquipMo(slot0, slot1)
	if not slot0.equips[slot1] then
		return nil
	end

	return EquipModel.instance:getEquip(slot2.equipUid[1])
end

return slot0
