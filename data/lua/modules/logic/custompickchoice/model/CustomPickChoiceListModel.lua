module("modules.logic.custompickchoice.model.CustomPickChoiceListModel", package.seeall)

slot0 = class("CustomPickChoiceListModel", BaseModel)

function slot1(slot0, slot1)
	if HeroModel.instance:getByHeroId(slot0.id) ~= nil ~= (HeroModel.instance:getByHeroId(slot1.id) ~= nil) then
		return slot5
	end

	if (slot2 and slot2.exSkillLevel or -1) ~= (slot3 and slot3.exSkillLevel or -1) then
		if slot6 == 5 or slot7 == 5 then
			return slot6 ~= 5
		end

		return slot7 < slot6
	end

	return slot1.id < slot0.id
end

function slot0.onInit(slot0)
	slot0._selectIdList = {}
	slot0._selectIdMap = {}
	slot0.allHeroList = {}
	slot0.noGainList = {}
	slot0.ownList = {}
	slot0.maxSelectCount = nil
end

function slot0.reInit(slot0)
	slot0:onInit()
end

function slot0.initData(slot0, slot1, slot2)
	slot0:onInit()
	slot0:initList(slot1)

	slot0.maxSelectCount = slot2 or 1
end

function slot0.initList(slot0, slot1)
	slot0.noGainList = {}
	slot0.ownList = {}
	slot0.allHeroList = {}

	if not slot1 then
		return
	end

	for slot5, slot6 in ipairs(slot1) do
		slot7 = SummonCustomPickChoiceMO.New()

		slot7:init(slot6)

		if slot7:hasHero() then
			table.insert(slot0.ownList, slot7)
		else
			table.insert(slot0.noGainList, slot7)
		end

		table.insert(slot0.allHeroList, slot7)
	end

	table.sort(slot0.ownList, uv0)
	table.sort(slot0.noGainList, uv0)
end

function slot0.setSelectId(slot0, slot1)
	if not slot0._selectIdList then
		return
	end

	if slot0._selectIdMap[slot1] then
		slot0._selectIdMap[slot1] = nil

		tabletool.removeValue(slot0._selectIdList, slot1)
	else
		slot0._selectIdMap[slot1] = true

		table.insert(slot0._selectIdList, slot1)
	end
end

function slot0.clearAllSelect(slot0)
	slot0._selectIdMap = {}
	slot0._selectIdList = {}
end

function slot0.getSelectIds(slot0)
	return slot0._selectIdList
end

function slot0.getSelectCount(slot0)
	if slot0._selectIdList then
		return #slot0._selectIdList
	end

	return 0
end

function slot0.getMaxSelectCount(slot0)
	return slot0.maxSelectCount
end

function slot0.isHeroIdSelected(slot0, slot1)
	if slot0._selectIdMap then
		return slot0._selectIdMap[slot1] ~= nil
	end

	return false
end

slot0.instance = slot0.New()

return slot0
