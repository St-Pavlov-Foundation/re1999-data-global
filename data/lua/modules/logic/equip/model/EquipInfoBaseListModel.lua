module("modules.logic.equip.model.EquipInfoBaseListModel", package.seeall)

slot0 = class("EquipInfoBaseListModel", ListScrollModel)
slot0.SortBy = {
	Rare = 2,
	Level = 1
}
slot0.levelAscend = false
slot0.rareAscend = false

function slot0.onInit(slot0)
	slot0.equipMoList = {}
	slot0.levelAscend = false
	slot0.rareAscend = false
	slot0.isChangeSort = false
	slot0.sortBy = uv0.SortBy.Level
end

function slot0.onOpen(slot0, slot1)
	slot0.heroMo = slot1.heroMo

	slot0:initEquipList()
end

function slot0.initEquipList(slot0, slot1)
	slot0.equipMoList = {}
	slot0.recommendEquip = slot0.heroMo and slot0.heroMo:getRecommendEquip() or {}

	for slot7, slot8 in ipairs(EquipModel.instance:getEquips()) do
		if EquipHelper.isNormalEquip(slot8.config) then
			if slot1:isFiltering() then
				if slot1:checkIsIncludeTag(slot8.config) then
					slot8.recommondIndex = LuaUtil.tableNotEmpty(slot0.recommendEquip) and tabletool.indexOf(slot0.recommendEquip, slot8.equipId) or -1

					table.insert(slot0.equipMoList, slot8)
				end
			else
				slot8.recommondIndex = slot2 and tabletool.indexOf(slot0.recommendEquip, slot8.equipId) or -1

				table.insert(slot0.equipMoList, slot8)
			end
		end
	end

	slot0:resortEquip()
end

function slot0.refreshEquipList(slot0)
	slot0:setList(slot0.equipMoList)
end

function slot0.isEmpty(slot0)
	if slot0.equipMoList then
		return #slot0.equipMoList == 0
	else
		return true
	end
end

function slot0.resortEquip(slot0)
	uv0.levelAscend = slot0.levelAscend
	uv0.rareAscend = slot0.rareAscend
	uv0.isChangeSort = slot0.isChangeSort

	if slot0.sortBy == uv0.SortBy.Level then
		table.sort(slot0.equipMoList, slot0._sortByLevel)
	elseif slot0.sortBy == uv0.SortBy.Rare then
		table.sort(slot0.equipMoList, slot0._sortByRare)
	else
		logError("not found sotBy : " .. tostring(slot0.sortBy))
		table.sort(slot0.equipMoList, slot0._sortByLevel)
	end
end

function slot0._changeSortByLevel(slot0)
	if slot0.sortBy == uv0.SortBy.Level then
		slot0.levelAscend = not slot0.levelAscend
	else
		slot0.sortBy = uv0.SortBy.Level
		slot0.levelAscend = false
	end

	slot0.isChangeSort = true
end

function slot0._changeSortByRare(slot0)
	if slot0.sortBy == uv0.SortBy.Rare then
		slot0.rareAscend = not slot0.rareAscend
	else
		slot0.sortBy = uv0.SortBy.Rare
		slot0.rareAscend = false
	end

	slot0.isChangeSort = true
end

function slot0.changeSortByLevel(slot0)
	slot0:_changeSortByLevel()
	slot0:resortEquip()
	slot0:refreshEquipList()
end

function slot0.changeSortByRare(slot0)
	slot0:_changeSortByRare()
	slot0:resortEquip()
	slot0:refreshEquipList()
end

function slot0.isSortByLevel(slot0)
	return slot0.sortBy == uv0.SortBy.Level
end

function slot0.isSortByRare(slot0)
	return slot0.sortBy == uv0.SortBy.Rare
end

function slot0.getSortState(slot0)
	return slot0.levelAscend and 1 or -1, slot0.rareAscend and 1 or -1
end

function slot0._sortByLevel(slot0, slot1)
	slot2, slot3 = EquipHelper.typeSort(slot0.config, slot1.config)

	if slot3 then
		return slot2
	end

	if slot0.equipType == EquipEnum.ClientEquipType.TrialEquip ~= (slot1.equipType == EquipEnum.ClientEquipType.TrialEquip) then
		return slot0.equipType == EquipEnum.ClientEquipType.TrialEquip
	end

	if slot0.recommondIndex ~= slot1.recommondIndex then
		if slot0.recommondIndex < 0 or slot1.recommondIndex < 0 then
			return slot0.recommondIndex > 0
		end

		if not uv0.isChangeSort then
			return slot0.recommondIndex < slot1.recommondIndex
		end
	end

	if slot0.level ~= slot1.level then
		if uv0.levelAscend then
			return slot0.level < slot1.level
		else
			return slot1.level < slot0.level
		end
	end

	if slot0.config.rare ~= slot1.config.rare then
		if uv0.rareAscend then
			return slot0.config.rare < slot1.config.rare
		else
			return slot1.config.rare < slot0.config.rare
		end
	end

	if slot0.equipId ~= slot1.equipId then
		return slot1.equipId < slot0.equipId
	end

	return slot0.id < slot1.id
end

function slot0._sortByRare(slot0, slot1)
	slot2, slot3 = EquipHelper.typeSort(slot0.config, slot1.config)

	if slot3 then
		return slot2
	end

	if slot0.equipType == EquipEnum.ClientEquipType.TrialEquip ~= (slot1.equipType == EquipEnum.ClientEquipType.TrialEquip) then
		return slot0.equipType == EquipEnum.ClientEquipType.TrialEquip
	end

	if slot0.recommondIndex ~= slot1.recommondIndex and (slot0.recommondIndex < 0 or slot1.recommondIndex < 0) then
		return slot0.recommondIndex > 0
	end

	if slot0.config.rare ~= slot1.config.rare then
		if uv0.rareAscend then
			return slot0.config.rare < slot1.config.rare
		else
			return slot1.config.rare < slot0.config.rare
		end
	end

	if slot0.level ~= slot1.level then
		if uv0.levelAscend then
			return slot0.level < slot1.level
		else
			return slot1.level < slot0.level
		end
	end

	if slot0.equipId ~= slot1.equipId then
		return slot1.equipId < slot0.equipId
	end

	return slot0.id < slot1.id
end

function slot0.setCurrentSelectEquipMo(slot0, slot1)
	slot0.currentSelectEquipMo = slot1
end

function slot0.getCurrentSelectEquipMo(slot0)
	return slot0.currentSelectEquipMo
end

function slot0.isSelectedEquip(slot0, slot1)
	return slot0.currentSelectEquipMo and slot0.currentSelectEquipMo.uid == slot1
end

function slot0.clear(slot0)
	slot0:onInit()

	slot0.selectedEquipMo = nil
end

function slot0.clearRecommend(slot0)
	if not EquipModel.instance:getEquips() then
		return
	end

	for slot4, slot5 in ipairs(EquipModel.instance:getEquips()) do
		slot5:clearRecommend()
	end
end

return slot0
