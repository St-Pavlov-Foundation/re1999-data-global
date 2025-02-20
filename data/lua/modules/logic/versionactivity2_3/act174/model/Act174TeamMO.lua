module("modules.logic.versionactivity2_3.act174.model.Act174TeamMO", package.seeall)

slot0 = pureTable("Act174TeamMO")

function slot0.init(slot0, slot1)
	slot0.index = slot1.index
	slot0.battleHeroInfo = {}

	for slot5, slot6 in ipairs(slot1.battleHeroInfo) do
		slot0.battleHeroInfo[slot5] = slot0:creatBattleHero(slot6)
	end
end

function slot0.creatBattleHero(slot0, slot1)
	return {
		index = slot1.index,
		heroId = slot1.heroId,
		itemId = slot1.itemId,
		priorSkill = slot1.priorSkill
	}
end

function slot0.notEmpty(slot0)
	for slot4, slot5 in ipairs(slot0.battleHeroInfo) do
		if slot5.heroId and slot5.heroId ~= 0 then
			return true
		end
	end

	return false
end

return slot0
