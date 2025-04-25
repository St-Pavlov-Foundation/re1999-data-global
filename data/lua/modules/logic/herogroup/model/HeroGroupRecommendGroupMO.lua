module("modules.logic.herogroup.model.HeroGroupRecommendGroupMO", package.seeall)

slot0 = pureTable("HeroGroupRecommendGroupMO")

function slot0.init(slot0, slot1)
	if not slot1 or not slot1.rate then
		slot0.isEmpty = true

		return
	end

	slot0.heroIdList = {}
	slot0.levels = {}
	slot0.heroDataList = {}

	for slot5, slot6 in ipairs(slot1.heroIds) do
		if slot6 > 0 then
			table.insert(slot0.heroDataList, {
				heroId = slot6,
				level = slot1.levels[slot5]
			})
		end
	end

	slot0.aidDict = {}

	for slot5, slot6 in ipairs(slot1.subHeroIds) do
		if slot6 > 0 then
			table.insert(slot0.heroDataList, {
				heroId = slot6,
				level = slot1.levels[#slot1.heroIds + slot5]
			})

			slot0.aidDict[slot6] = true
		end
	end

	slot0.cloth = slot1.cloth
	slot0.rate = slot1.rate
	slot0.assistBossId = slot1.assistBossId
end

return slot0
