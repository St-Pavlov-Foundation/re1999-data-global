module("modules.logic.room.model.backpack.RoomCritterDecomposeListModel", package.seeall)

slot0 = class("RoomCritterDecomposeListModel", ListScrollModel)
slot1 = 6

function slot0.onInit(slot0)
	slot0:clear()
	slot0:clearData()
end

function slot0.reInit(slot0)
	slot0:clearData()
end

function slot0.clearData(slot0)
	slot0:clearCritterList()
	slot0:setIsSortByRareAscend(false)
	slot0:setFilterRare(CritterEnum.CritterDecomposeMinRare)
	slot0:setFilterMature(CritterEnum.MatureFilterType.All)
end

function slot0.clearCritterList(slot0)
	if slot0.critterList then
		tabletool.clear(slot0.critterList)
	else
		slot0.critterList = {}
	end

	slot0:clearSelectedCritter()
end

function slot0.clearSelectedCritter(slot0)
	if slot0.selectedCritterDict then
		tabletool.clear(slot0.selectedCritterDict)
	else
		slot0.selectedCritterDict = {}
	end

	slot0.selectedCritterCount = 0

	CritterController.instance:dispatchEvent(CritterEvent.CritterDecomposeChangeSelect)
end

function slot0.updateCritterList(slot0, slot1)
	slot0:clearCritterList()

	slot4 = slot0.filterMature == CritterEnum.MatureFilterType.Mature

	for slot8, slot9 in ipairs(CritterModel.instance:getAllCritters()) do
		slot10 = false

		if not slot0.filterMature or slot0.filterMature == CritterEnum.MatureFilterType.All then
			slot10 = slot0:checkCanDecompose(slot9, slot1)
		else
			slot11 = slot9:isMaturity()

			if slot4 and slot11 or not slot4 and not slot11 then
				slot10 = slot0:checkCanDecompose(slot9, slot1)
			end
		end

		if slot10 then
			table.insert(slot0.critterList, slot9)
		end
	end

	slot0:sortCritterList()
end

function slot0.checkCanDecompose(slot0, slot1, slot2)
	slot3 = false

	if slot1 and not slot1:isLock() then
		slot5 = slot1:getId()

		if not slot1:isCultivating() and not ManufactureModel.instance:getCritterWorkingBuilding(slot5) and not RoomMapTransportPathModel.instance:getTransportPathMOByCritterUid(slot5) and slot1:getDefineCfg().rare < uv0 then
			slot3 = (not slot2 or slot2:isPassedFilter(slot1)) and true
		end
	end

	return slot3
end

function slot0.sortCritterList(slot0)
	if slot0:getIsSortByRareAscend() then
		table.sort(slot0.critterList, CritterHelper.sortByRareAscend)
	else
		table.sort(slot0.critterList, CritterHelper.sortByRareDescend)
	end
end

function slot0.refreshCritterShowList(slot0)
	slot0:setList(slot0.critterList)
end

function slot0.checkDecomposeCountLimit(slot0)
	slot1 = true

	if tonumber(CritterConfig.instance:getCritterConstStr(CritterEnum.ConstId.DecomposeCountLimit)) and slot0.selectedCritterDict then
		for slot10, slot11 in ipairs(CritterModel.instance:getAllCritters()) do
			if slot11:isMaturity() then
				slot4 = 0 + 1

				if slot0.selectedCritterDict[slot11:getId()] then
					slot5 = 0 + 1
				end
			end
		end

		if slot3 > slot4 - slot5 then
			slot1 = false
		end
	end

	return slot1
end

function slot0.fastAddCritter(slot0)
	tabletool.clear(slot0.selectedCritterDict)

	slot0.selectedCritterCount = 0

	for slot4, slot5 in ipairs(slot0.critterList) do
		if not slot5:isLock() then
			if slot5:getDefineCfg().rare <= slot0:getFilterRare() then
				slot0.selectedCritterCount = slot0.selectedCritterCount + 1
				slot0.selectedCritterDict[slot5.id] = true
			end

			if CritterEnum.DecomposeMaxCount <= slot0.selectedCritterCount then
				break
			end
		end
	end

	CritterController.instance:dispatchEvent(CritterEvent.CritterDecomposeChangeSelect)
end

function slot0.selectDecomposeCritter(slot0, slot1)
	if CritterEnum.DecomposeMaxCount <= slot0.selectedCritterCount then
		return
	end

	if slot0.selectedCritterDict[slot1.id] then
		return
	end

	slot0.selectedCritterDict[slot1.id] = true
	slot0.selectedCritterCount = slot0.selectedCritterCount + 1

	CritterController.instance:dispatchEvent(CritterEvent.CritterDecomposeChangeSelect)
end

function slot0.unselectDecomposeCritter(slot0, slot1)
	if not slot0.selectedCritterDict[slot1.id] then
		return
	end

	slot0.selectedCritterDict[slot1.id] = nil
	slot0.selectedCritterCount = slot0.selectedCritterCount - 1

	CritterController.instance:dispatchEvent(CritterEvent.CritterDecomposeChangeSelect)
end

function slot0.isSelect(slot0, slot1)
	return slot0.selectedCritterDict[slot1]
end

function slot0.getSelectCount(slot0)
	return slot0.selectedCritterCount
end

function slot0.getDecomposeCritterCount(slot0)
	slot1 = 0

	if slot0.selectedCritterDict then
		for slot5, slot6 in pairs(slot0.selectedCritterDict) do
			for slot13, slot14 in ipairs(DungeonConfig.instance:getRewardItems(CritterModel.instance:getCritterMOByUid(slot5):getDefineCfg().banishBonus)) do
				slot1 = slot1 + slot14[3]
			end
		end
	end

	return slot1
end

function slot0.getSelectUIds(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0.selectedCritterDict) do
		slot1[#slot1 + 1] = slot5
	end

	return slot1
end

function slot0.setFilterMature(slot0, slot1)
	slot0.filterMature = slot1
end

function slot0.setFilterRare(slot0, slot1)
	slot0.filterRare = slot1
end

function slot0.setIsSortByRareAscend(slot0, slot1)
	slot0._rareAscend = slot1

	CritterController.instance:dispatchEvent(CritterEvent.CritterChangeSort)
end

function slot0.getFilterMature(slot0)
	return slot0.filterMature or CritterEnum.MatureFilterType.All
end

function slot0.getFilterRare(slot0)
	return slot0.filterRare or CritterEnum.CritterDecomposeMinRare
end

function slot0.getIsSortByRareAscend(slot0)
	return slot0._rareAscend
end

function slot0.isEmpty(slot0)
	return slot0:getCount() <= 0
end

slot0.instance = slot0.New()

return slot0
