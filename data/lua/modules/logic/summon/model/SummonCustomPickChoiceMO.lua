module("modules.logic.summon.model.SummonCustomPickChoiceMO", package.seeall)

slot0 = pureTable("SummonCustomPickChoiceMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1
	slot0.ownNum = 0
	slot0.exSkillLevel = 0
	slot0.rank = 0

	slot0:initSkillLevel()
end

function slot0.initSkillLevel(slot0)
	slot2 = 0

	if not string.nilorempty(HeroConfig.instance:getHeroCO(slot0.id).duplicateItem) and string.split(slot3, "|")[1] then
		slot6 = string.splitToNumber(slot5, "#")
		slot2 = ItemModel.instance:getItemQuantity(slot6[1], slot6[2])
	end

	slot0.ownNum = 0
	slot0.exSkillLevel = 0

	if HeroModel.instance:getByHeroId(slot0.id) then
		slot0.exSkillLevel = slot4.exSkillLevel
		slot0.ownNum = slot0.exSkillLevel + 1 + slot2
		slot0.rank = slot4.rank
	end
end

function slot0.hasHero(slot0)
	return slot0.ownNum > 0
end

function slot0.getSkillLevel(slot0)
	return slot0.exSkillLevel
end

return slot0
