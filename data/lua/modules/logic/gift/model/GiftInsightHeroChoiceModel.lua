module("modules.logic.gift.model.GiftInsightHeroChoiceModel", package.seeall)

slot0 = class("GiftInsightHeroChoiceModel", BaseModel)

function slot0.onInit(slot0)
	slot0._curHeroId = 0
end

function slot0.setCurHeroId(slot0, slot1)
	slot0._curHeroId = slot1
end

function slot0.getCurHeroId(slot0)
	return slot0._curHeroId
end

function slot0.getFitHeros(slot0, slot1)
	slot2 = {}
	slot3 = {}
	slot5 = ItemConfig.instance:getInsightItemCo(slot1)

	for slot9, slot10 in pairs(HeroModel.instance:getAllHero()) do
		for slot15, slot16 in pairs(string.splitToNumber(slot5.heroRares, "#")) do
			if slot10.config.rare + 1 == slot16 then
				if slot10.rank < slot5.heroRank + 1 then
					table.insert(slot2, slot10)
				else
					table.insert(slot3, slot10)
				end
			end
		end
	end

	table.sort(slot2, uv0._sortFunc)
	table.sort(slot3, uv0._sortFunc)

	return slot2, slot3
end

function slot0._sortFunc(slot0, slot1)
	if slot0.config.rare ~= slot1.config.rare then
		return slot1.config.rare < slot0.config.rare
	elseif slot0.rank ~= slot1.rank then
		return slot1.rank < slot0.rank
	elseif slot0.level ~= slot1.level then
		return slot1.level < slot0.level
	else
		return slot1.heroId < slot0.heroId
	end
end

slot0.instance = slot0.New()

return slot0
