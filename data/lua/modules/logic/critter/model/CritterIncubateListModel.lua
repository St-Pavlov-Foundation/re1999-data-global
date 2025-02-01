module("modules.logic.critter.model.CritterIncubateListModel", package.seeall)

slot0 = class("CritterIncubateListModel", ListScrollModel)

function slot0.setMoList(slot0, slot1)
	slot0.moList = slot0:getMoList(slot1)

	slot0:sortMoList(slot1)

	return #slot0.moList
end

function slot0.sortMoList(slot0, slot1)
	if not slot0.moList then
		slot0.moList = slot0:getMoList(slot1)
	end

	slot4 = nil

	if CritterIncubateModel.instance:getSortType() == CritterEnum.AttributeType.Efficiency then
		slot4 = CritterIncubateModel.instance:getSortWay() and CritterHelper.sortByEfficiencyDescend or CritterHelper.sortByEfficiencyAscend
	elseif slot2 == CritterEnum.AttributeType.Patience then
		slot4 = slot3 and CritterHelper.sortByPatienceDescend or CritterHelper.sortByPatienceAscend
	elseif slot2 == CritterEnum.AttributeType.Lucky then
		slot4 = slot3 and CritterHelper.sortByLuckyDescend or CritterHelper.sortByLuckyAscend
	end

	if slot4 then
		table.sort(slot0.moList, slot4)
	end

	slot0:setList(slot0.moList)
end

function slot0.getMoList(slot0, slot1)
	slot3 = {}

	for slot7, slot8 in ipairs(CritterModel.instance:getCanIncubateCritters()) do
		slot9 = true

		if slot1 and slot1:isPassedFilter(slot8) then
			table.insert(slot3, slot8)
		end
	end

	return slot3
end

function slot0.getMoIndex(slot0, slot1)
	slot2 = slot0:getList()

	return tabletool.indexOf(slot2, slot1), #slot2
end

slot0.instance = slot0.New()

return slot0
