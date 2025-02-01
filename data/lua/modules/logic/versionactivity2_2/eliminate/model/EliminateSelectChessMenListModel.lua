module("modules.logic.versionactivity2_2.eliminate.model.EliminateSelectChessMenListModel", package.seeall)

slot0 = class("EliminateSelectChessMenListModel", MultiSortListScrollModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._initList = {}
	slot0._addList = {}
	slot0._presetList = {}
	slot0._selectedChessMen = nil
	slot0._quickEdit = nil
end

function slot0.setQuickEdit(slot0, slot1)
	slot0._quickEdit = slot1
end

function slot0.getQuickEdit(slot0)
	return slot0._quickEdit
end

function slot0.getAddIds(slot0)
	slot1 = {}

	for slot5 = 1, slot0._addMaxCount do
		if slot0._addList[slot5] then
			table.insert(slot1, slot6.config.id)
		end
	end

	return slot1
end

function slot0.isInAddList(slot0, slot1)
	for slot5 = 1, slot0._addMaxCount do
		if slot0._addList[slot5] == slot1 then
			return true
		end
	end
end

function slot0.getAddChessMen(slot0, slot1)
	return slot0._addList[slot1]
end

function slot0.getAddMaxCount(slot0)
	return slot0._addMaxCount
end

function slot0.getAutoList(slot0)
	if #slot0._presetList > 0 then
		return slot0._presetList
	end

	slot1 = {}

	for slot5 = 1, slot0._addMaxCount do
		if slot0._initList[slot5] and EliminateTeamSelectionModel.instance:hasChessPieceOrPreset(slot6.config.id) then
			table.insert(slot1, slot6.config.id)
		else
			break
		end
	end

	return slot1
end

function slot0.canAddChessMen(slot0, slot1)
	for slot5 = 1, slot0._addMaxCount do
		if slot0._addList[slot5] == nil then
			return true
		end
	end
end

function slot0.addSelectedChessMen(slot0, slot1)
	tabletool.removeValue(slot0._initList, slot1)

	for slot5 = 1, slot0._addMaxCount do
		if slot0._addList[slot5] == nil then
			slot0._addList[slot5] = slot1

			break
		end
	end

	slot0:_changeChessMen()
end

function slot0._removeListValue(slot0, slot1, slot2)
	for slot6, slot7 in pairs(slot1) do
		if slot7 == slot2 then
			slot1[slot6] = nil

			break
		end
	end
end

function slot0.removeSelectedChessMen(slot0, slot1)
	slot0:_removeListValue(slot0._addList, slot1)
	table.insert(slot0._initList, slot1)
	slot0:_changeChessMen()
end

function slot0._changeChessMen(slot0)
	slot0:updateList()
	EliminateMapController.instance:dispatchEvent(EliminateMapEvent.ChangeChessMen)
end

function slot0.setSelectedChessMen(slot0, slot1)
	slot0._selectedChessMen = slot1

	EliminateMapController.instance:dispatchEvent(EliminateMapEvent.SelectChessMen)
end

function slot0.getSelectedChessMen(slot0)
	return slot0._selectedChessMen
end

function slot0._sortRare(slot0, slot1, slot2, slot3)
	if slot0.config.level ~= slot1.config.level then
		if slot2 then
			return slot4 < slot5
		else
			return slot5 < slot4
		end
	end
end

function slot0._sortPower(slot0, slot1, slot2, slot3)
	if slot0.config.defaultPower ~= slot1.config.defaultPower then
		if slot2 then
			return slot4 < slot5
		else
			return slot5 < slot4
		end
	end
end

function slot0._sortResource(slot0, slot1, slot2, slot3)
	if slot0.costValue ~= slot1.costValue then
		if slot2 then
			return slot4 < slot5
		else
			return slot5 < slot4
		end
	end
end

function slot0._sortDefault(slot0, slot1, slot2)
	return slot0.config.id < slot1.config.id
end

function slot0._sortFirst(slot0, slot1, slot2)
	if EliminateTeamSelectionModel.instance:hasChessPieceOrPreset(slot0.config.id) ~= EliminateTeamSelectionModel.instance:hasChessPieceOrPreset(slot1.config.id) then
		return slot3
	end
end

function slot0.initList(slot0)
	slot0:initSort()
	slot0:addSortType(EliminateMapEnum.SortType.Rare, uv0._sortRare)
	slot0:addSortType(EliminateMapEnum.SortType.Power, uv0._sortPower)
	slot0:addSortType(EliminateMapEnum.SortType.Resource, uv0._sortResource)
	slot0:addOtherSort(uv0._sortFirst, uv0._sortDefault)
	slot0:setCurSortType(EliminateMapEnum.SortType.Rare)

	slot0._addMaxCount = EliminateOutsideModel.instance:getUnlockSlotNum()
	slot0._initList = tabletool.copy(EliminateConfig.instance:getSoldierChessList())
	slot0._addList = {}
	slot0._presetList = {}

	slot0:_initPresetList()
	slot0:_initPrevSelectedChecss()
	slot0:_cleanList()
	slot0:updateList()
end

function slot0._cleanList(slot0)
	slot1 = {
		[slot6.id] = true
	}

	for slot5, slot6 in pairs(slot0._addList) do
		-- Nothing
	end

	for slot6 = #slot0._initList, 1, -1 do
		if slot1[slot0._initList[slot6].id] then
			table.remove(slot0._initList, slot6)
		end
	end
end

function slot0._initPrevSelectedChecss(slot0)
	if EliminateTeamSelectionModel.instance:isPreset() then
		return
	end

	for slot6, slot7 in ipairs(string.split(EliminateMapController.getPrefsString(EliminateMapEnum.PrefsKey.ChessSelected, ""), ",")) do
		slot8 = string.split(slot7, "_")
		slot10 = tonumber(slot8[2])

		if tonumber(slot8[1]) and slot10 and EliminateConfig.instance:getSoldierChessById(slot10) then
			slot0._addList[slot9] = slot11
		end
	end
end

function slot0.serializeAddList(slot0)
	for slot5 = 1, slot0._addMaxCount do
		if slot0._addList[slot5] then
			slot7 = string.format("%d_%d", slot5, slot6.id)
			slot1 = string.nilorempty(nil) and slot7 or slot7 .. "," .. slot7
		end
	end

	return slot1
end

function slot0._initPresetList(slot0)
	if not EliminateTeamSelectionModel.instance:isPreset() then
		return
	end

	for slot5 = #slot0._initList, 1, -1 do
		if slot0._initList[slot5] and EliminateTeamSelectionModel.instance:isPresetSoldier(slot6.id) then
			table.insert(slot0._presetList, slot6.id)
			table.insert(slot0._addList, slot6)
			table.remove(slot0._initList, slot5)
		end
	end
end

function slot0.updateList(slot0)
	slot0:setSortList(slot0._initList)
end

function slot0.clearList(slot0)
	slot0:clear()
	slot0:reInit()
end

slot0.instance = slot0.New()

return slot0
