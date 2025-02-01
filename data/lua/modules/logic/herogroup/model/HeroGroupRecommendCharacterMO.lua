module("modules.logic.herogroup.model.HeroGroupRecommendCharacterMO", package.seeall)

slot0 = pureTable("HeroGroupRecommendCharacterMO")

function slot0.init(slot0, slot1)
	if not slot1 or not slot1.rate then
		slot0.isEmpty = true
		slot0.heroRecommendInfos = {}

		return
	end

	slot0.heroId = slot1.heroId
	slot0.heroRecommendInfos = slot1.infos
	slot0.rate = slot1.rate
end

return slot0
