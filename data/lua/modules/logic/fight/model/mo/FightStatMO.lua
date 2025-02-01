module("modules.logic.fight.model.mo.FightStatMO", package.seeall)

slot0 = pureTable("FightStatMO")

function slot0.init(slot0, slot1)
	slot0.entityId = slot1.heroUid
	slot0.harm = tonumber(slot1.harm)
	slot0.hurt = tonumber(slot1.hurt)
	slot0.heal = tonumber(slot1.heal)
	slot0.cards = {}

	for slot5, slot6 in ipairs(slot1.cards) do
		table.insert(slot0.cards, {
			skillId = slot6.skillId,
			useCount = slot6.useCount
		})
	end
end

return slot0
