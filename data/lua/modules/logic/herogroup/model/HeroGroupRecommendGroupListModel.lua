module("modules.logic.herogroup.model.HeroGroupRecommendGroupListModel", package.seeall)

slot0 = class("HeroGroupRecommendGroupListModel", ListScrollModel)

function slot0.setGroupList(slot0, slot1)
	slot0:setCurrentShowRecommendGroupMoId(slot1)

	slot3 = {}

	for slot7, slot8 in ipairs(slot1.heroRecommendInfos) do
		slot9 = HeroGroupRecommendGroupMO.New()

		slot9:init(slot8)
		table.insert(slot3, slot9)
	end

	table.sort(slot3, function (slot0, slot1)
		return slot1.rate < slot0.rate
	end)

	for slot7 = #slot2 + 1, 5 do
		slot8 = HeroGroupRecommendGroupMO.New()

		slot8:init()
		table.insert(slot3, slot8)
	end

	slot0:setList(slot3)
end

function slot0.setCurrentShowRecommendGroupMoId(slot0, slot1)
	slot0.showGroupId = slot1.id
end

function slot0.isShowSampleMo(slot0, slot1)
	return slot0.showGroupId == slot1.id
end

slot0.instance = slot0.New()

return slot0
