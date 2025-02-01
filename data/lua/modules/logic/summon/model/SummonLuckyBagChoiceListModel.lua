module("modules.logic.summon.model.SummonLuckyBagChoiceListModel", package.seeall)

slot0 = class("SummonLuckyBagChoiceListModel", ListScrollModel)

function slot0.onInit(slot0)
	slot0:clear()
end

function slot0.reInit(slot0)
	slot0:clear()
end

function slot1(slot0, slot1)
	if HeroModel.instance:getByHeroId(slot0.id) ~= nil ~= (HeroModel.instance:getByHeroId(slot1.id) ~= nil) then
		return slot5
	end

	if (slot2 and slot2.exSkillLevel or -1) ~= (slot3 and slot3.exSkillLevel or -1) then
		return slot6 < slot7
	end

	return slot0.id < slot1.id
end

function slot0.initDatas(slot0, slot1, slot2)
	slot0._poolId = slot2
	slot0._luckyBagId = slot1
	slot0._selectHeroId = nil

	slot0:initList()
end

function slot0.initList(slot0)
	slot0.noGainList = {}
	slot0.ownList = {}

	for slot5, slot6 in ipairs(slot0:getCharIdList()) do
		slot7 = SummonLuckyBagChoiceMO.New()

		slot7:init(slot6)

		if slot7:hasHero() then
			table.insert(slot0.ownList, slot7)
		else
			table.insert(slot0.noGainList, slot7)
		end
	end

	table.sort(slot0.ownList, uv0)
	table.sort(slot0.noGainList, uv0)
end

function slot0.setSelectId(slot0, slot1)
	slot0._selectHeroId = slot1
end

function slot0.getSelectId(slot0)
	return slot0._selectHeroId
end

function slot0.getLuckyBagId(slot0)
	return slot0._luckyBagId
end

function slot0.getPoolId(slot0)
	return slot0._poolId
end

function slot0.getCharIdList(slot0)
	return SummonConfig.instance:getLuckyBagHeroIds(slot0._poolId, slot0._luckyBagId)
end

slot0.instance = slot0.New()

return slot0
