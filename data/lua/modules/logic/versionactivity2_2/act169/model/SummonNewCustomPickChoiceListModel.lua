module("modules.logic.versionactivity2_2.act169.model.SummonNewCustomPickChoiceListModel", package.seeall)

slot0 = class("SummonNewCustomPickChoiceListModel", ListScrollModel)

function slot0.onInit(slot0)
	slot0:clear()
end

function slot0.reInit(slot0)
	slot0:clear()
end

function slot0.initDatas(slot0, slot1)
	slot0._actId = slot1
	slot0._selectIdList = {}
	slot0._selectIdMap = {}

	slot0:initList()
end

slot0.SkillLevel2Order = {
	[0] = 50,
	40,
	30,
	20,
	10,
	60
}

function slot1(slot0, slot1)
	if HeroModel.instance:getByHeroId(slot0.id) ~= nil ~= (HeroModel.instance:getByHeroId(slot1.id) ~= nil) then
		return slot5
	end

	if (slot2 and slot2.exSkillLevel or -1) ~= (slot3 and slot3.exSkillLevel or -1) then
		return (uv0.SkillLevel2Order[slot6] or 999) < (uv0.SkillLevel2Order[slot7] or 999)
	end

	return slot0.id < slot1.id
end

function slot0.initList(slot0)
	slot0.ownList = {}
	slot0.noGainList = {}

	for slot5, slot6 in ipairs(slot0:getCharIdList()) do
		slot7 = SummonCustomPickChoiceMO.New()

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

function slot0.haveAllRole(slot0)
	return slot0._actId and slot0.noGainList and #slot0.noGainList <= 0
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

	SummonNewCustomPickChoiceController.instance:dispatchEvent(SummonNewCustomPickEvent.OnCustomPickListChanged)
end

function slot0.clearSelectIds(slot0)
	slot0._selectIdMap = {}
	slot0._selectIdList = {}
end

function slot0.getSelectIds(slot0)
	return slot0._selectIdList
end

function slot0.getMaxSelectCount(slot0)
	return SummonNewCustomPickViewModel.instance:getMaxSelectCount(slot0._actId)
end

function slot0.getSelectCount(slot0)
	if slot0._selectIdList then
		return #slot0._selectIdList
	end

	return 0
end

function slot0.isHeroIdSelected(slot0, slot1)
	if slot0._selectIdMap then
		return slot0._selectIdMap[slot1] ~= nil
	end

	return false
end

function slot0.getActivityId(slot0)
	return slot0._actId
end

function slot0.getCharIdList(slot0)
	if SummonNewCustomPickViewConfig.instance:getSummonConfigById(slot0._actId) then
		return string.splitToNumber(slot1.heroIds, "#")
	end

	return {}
end

slot0.instance = slot0.New()

return slot0
