module("modules.logic.equip.model.EquipDecomposeListModel", package.seeall)

slot0 = class("EquipDecomposeListModel", ListScrollModel)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

slot0.SortTag = {
	Rare = 2,
	Level = 1
}
slot0.DefaultFilterRare = 4

function slot0.checkEquipCanDecompose(slot0, slot1)
	if not slot1 then
		return false
	end

	if slot1.level > 1 then
		return false
	end

	if not EquipHelper.isNormalEquip(slot1.config) then
		return false
	end

	if uv0.DefaultFilterRare <= slot2.rare then
		return false
	end

	if not slot0.filterMo then
		return true
	end

	return slot0.filterMo:checkIsIncludeTag(slot1.config)
end

function slot0.getSortTag(slot0)
	return slot0.sortTag
end

function slot0.getSortIsAscend(slot0, slot1)
	if slot1 == uv0.SortTag.Level then
		return slot0.levelAscend
	else
		return slot0.rareAscend
	end
end

function slot0.isEmpty(slot0)
	return #slot0.equipList == 0
end

function slot0.getEquipData(slot0)
	if slot0.equipList then
		tabletool.clear(slot0.equipList)
	else
		slot0.equipList = {}
	end

	slot3 = EquipModel.instance
	slot5 = slot3

	for slot4, slot5 in ipairs(slot3.getEquips(slot5)) do
		if slot0:checkEquipCanDecompose(slot5) then
			table.insert(slot0.equipList, slot5)
		end
	end
end

function slot0.initEquipData(slot0)
	slot0.selectedEquipDict = {}
	slot0.selectedEquipCount = 0
	slot0.sortTag = uv0.SortTag.Rare

	slot0:resetLevelSortStatus()
	slot0:resetRareSortStatus()
	slot0:getEquipData()
	slot0:sortEquipList()
end

function slot0.updateEquipData(slot0, slot1)
	slot0:clearSelectEquip()

	slot0.filterMo = slot1

	slot0:getEquipData()
	slot0:sortEquipList()
end

function slot0.resetLevelSortStatus(slot0)
	slot0.levelAscend = false
end

function slot0.resetRareSortStatus(slot0)
	slot0.rareAscend = false
end

function slot0.changeLevelSortStatus(slot0)
	slot0.sortTag = uv0.SortTag.Level
	slot0.levelAscend = not slot0.levelAscend

	EquipController.instance:dispatchEvent(EquipEvent.OnEquipDecomposeSortStatusChange)
end

function slot0.changeRareStatus(slot0)
	slot0.sortTag = uv0.SortTag.Rare
	slot0.rareAscend = not slot0.rareAscend

	EquipController.instance:dispatchEvent(EquipEvent.OnEquipDecomposeSortStatusChange)
end

function slot0.sortEquipList(slot0)
	if slot0.sortTag == uv0.SortTag.Level then
		table.sort(slot0.equipList, uv0.sortByLv)
	else
		table.sort(slot0.equipList, uv0.sortByRare)
	end
end

function slot0.sortByLv(slot0, slot1)
	if slot0.level ~= slot1.level then
		if uv0.instance.levelAscend then
			return slot0.level < slot1.level
		else
			return slot1.level < slot0.level
		end
	end

	if slot0.config.rare ~= slot1.config.rare then
		if uv0.instance.rareAscend then
			return slot2.rare < slot3.rare
		else
			return slot3.rare < slot2.rare
		end
	end

	if slot2.id ~= slot3.id then
		return slot2.id < slot3.id
	end

	return slot0.id < slot1.id
end

function slot0.sortByRare(slot0, slot1)
	if slot0.config.rare ~= slot1.config.rare then
		if uv0.instance.rareAscend then
			return slot2.rare < slot3.rare
		else
			return slot3.rare < slot2.rare
		end
	end

	if slot0.level ~= slot1.level then
		if uv0.instance.levelAscend then
			return slot0.level < slot1.level
		else
			return slot1.level < slot0.level
		end
	end

	if slot2.id ~= slot3.id then
		return slot2.id < slot3.id
	end

	return slot0.id < slot1.id
end

function slot0.refreshEquip(slot0)
	slot0:setList(slot0.equipList)
end

function slot0.getSelectCount(slot0)
	return slot0.selectedEquipCount
end

function slot0.isSelect(slot0, slot1)
	return slot0.selectedEquipDict[slot1]
end

function slot0.selectEquipMo(slot0, slot1)
	if EquipEnum.DecomposeMaxCount <= slot0.selectedEquipCount then
		return
	end

	if slot0.selectedEquipDict[slot1.id] then
		return
	end

	slot0.selectedEquipDict[slot1.id] = true
	slot0.selectedEquipCount = slot0.selectedEquipCount + 1

	EquipController.instance:dispatchEvent(EquipEvent.OnEquipDecomposeSelectEquipChange)
end

function slot0.desSelectEquipMo(slot0, slot1)
	if not slot0.selectedEquipDict[slot1.id] then
		return
	end

	slot0.selectedEquipDict[slot1.id] = nil
	slot0.selectedEquipCount = slot0.selectedEquipCount - 1

	EquipController.instance:dispatchEvent(EquipEvent.OnEquipDecomposeSelectEquipChange)
end

function slot0.getDecomposeEquipCount(slot0)
	return math.floor(slot0:getAddExp() / 100)
end

function slot0.getAddExp(slot0)
	slot1 = 0

	if slot0.selectedEquipDict then
		for slot5, slot6 in pairs(slot0.selectedEquipDict) do
			slot1 = slot1 + EquipConfig.instance:getIncrementalExp(EquipModel.instance:getEquip(tostring(slot5)))
		end
	end

	return slot1
end

function slot0.fastAddEquip(slot0)
	tabletool.clear(slot0.selectedEquipDict)

	slot0.selectedEquipCount = 0

	for slot4, slot5 in ipairs(slot0.equipList) do
		if not slot5.isLock then
			if slot5.config.rare <= slot0.filterRare then
				slot0.selectedEquipCount = slot0.selectedEquipCount + 1
				slot0.selectedEquipDict[slot5.id] = true
			end

			if EquipEnum.DecomposeMaxCount <= slot0.selectedEquipCount then
				break
			end
		end
	end

	EquipController.instance:dispatchEvent(EquipEvent.OnEquipDecomposeSelectEquipChange)
end

function slot0.setFilterRare(slot0, slot1)
	slot0.filterRare = slot1
end

function slot0.clearSelectEquip(slot0)
	tabletool.clear(slot0.selectedEquipDict)

	slot0.selectedEquipCount = 0

	EquipController.instance:dispatchEvent(EquipEvent.OnEquipDecomposeSelectEquipChange)
end

function slot0.clear(slot0)
	tabletool.clear(slot0.equipList)
	uv0.super.clear(slot0)
end

slot0.instance = slot0.New()

return slot0
