module("modules.logic.summon.model.SummonResultMO", package.seeall)

slot0 = pureTable("SummonResultMO")

function slot0.init(slot0, slot1)
	slot0.heroId = slot1.heroId
	slot0.duplicateCount = slot1.duplicateCount
	slot0.equipId = slot1.equipId
	slot0.luckyBagId = slot1.luckyBagId

	if slot1.returnMaterials then
		slot0.returnMaterials = {}

		for slot5, slot6 in ipairs(slot1.returnMaterials) do
			slot7 = MaterialDataMO.New()

			slot7:init(slot6)
			table.insert(slot0.returnMaterials, slot7)
		end
	end

	slot0.soundOfLost = slot1.soundOfLost
	slot0.manySoundOfLost = slot1.manySoundOfLost
	slot0.isNew = slot1.isNew
	slot0._opened = false
	slot0.heroConfig = HeroConfig.instance:getHeroCO(slot0.heroId)
end

function slot0.setOpen(slot0)
	slot0._opened = true
end

function slot0.isOpened(slot0)
	return slot0._opened
end

function slot0.isLuckyBag(slot0)
	return slot0.luckyBagId ~= nil and slot0.luckyBagId ~= 0
end

return slot0
