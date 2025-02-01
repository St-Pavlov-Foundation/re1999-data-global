module("modules.logic.herogroup.model.HeroGroupRecommendCharacterListModel", package.seeall)

slot0 = class("HeroGroupRecommendCharacterListModel", ListScrollModel)

function slot0.setCharacterList(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		slot8 = HeroGroupRecommendCharacterMO.New()

		slot8:init(slot7)
		table.insert(slot2, slot8)
	end

	table.sort(slot2, function (slot0, slot1)
		return slot1.rate < slot0.rate
	end)

	for slot6 = #slot1 + 1, 5 do
		slot7 = HeroGroupRecommendCharacterMO.New()

		slot7:init()
		table.insert(slot2, slot7)
	end

	slot0:setList(slot2)

	if #slot2 > 0 then
		for slot6, slot7 in ipairs(slot0._scrollViews) do
			slot7:selectCell(1, true)
		end
	end
end

slot0.instance = slot0.New()

return slot0
