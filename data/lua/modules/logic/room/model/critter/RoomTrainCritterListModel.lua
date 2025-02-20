module("modules.logic.room.model.critter.RoomTrainCritterListModel", package.seeall)

slot0 = class("RoomTrainCritterListModel", ListScrollModel)

function slot0.onInit(slot0)
	slot0:_clearData()
end

function slot0.reInit(slot0)
	slot0:_clearData()
end

function slot0.clear(slot0)
	uv0.super.clear(slot0)
	slot0:_clearData()
end

function slot0._clearData(slot0)
end

function slot0.setCritterList(slot0, slot1)
	slot0._filterMO = slot1

	if slot0._sortAttrId == nil then
		slot0._sortAttrId = CritterEnum.AttributeType.Efficiency
	end

	if slot0._isSortHightToLow == nil then
		slot0._isSortHightToLow = true
	end

	slot0:updateCritterList()
end

function slot0.updateCritterList(slot0, slot1)
	slot2 = slot0._filterMO
	slot3 = {}

	for slot9 = 1, #CritterModel.instance:getList() do
		if slot5[slot9] and not slot10:isMaturity() then
			if slot10:isCultivating() and slot1 ~= slot10.id or slot2 and not slot2:isPassedFilter(slot10) then
				-- Nothing
			else
				table.insert(slot3, slot10)
			end
		end
	end

	slot0._trainCritterMODict = {
		[slot10.id] = slot10
	}

	table.sort(slot3, slot0:_getSortFunction())
	slot0:setList(slot3)
end

function slot0.sortByAttrId(slot0, slot1, slot2)
	if slot1 ~= nil then
		slot0._sortAttrId = slot1
	end

	if slot2 ~= nil then
		slot0._isSortHightToLow = slot2
	end

	slot0:sort(slot0:_getSortFunction())
end

function slot0._getSortFunction(slot0)
	slot0._trainHeroMO = RoomTrainHeroListModel.instance:getById(RoomTrainHeroListModel.instance:getSelectId())

	if slot0._sortFunc then
		return slot0._sortFunc
	end

	function slot0._sortFunc(slot0, slot1)
		if uv0._trainHeroMO and uv0:_getCritterValue(uv0._trainHeroMO, slot0) ~= uv0:_getCritterValue(uv0._trainHeroMO, slot1) then
			return slot3 < slot2
		end

		slot2, slot3 = uv0:_getAttrValue(slot0, uv0._sortAttrId)
		slot4, slot5 = uv0:_getAttrValue(slot1, uv0._sortAttrId)

		if slot3 ~= slot5 then
			if uv0._isSortHightToLow then
				return slot5 < slot3
			end

			return slot3 < slot5
		end

		if slot2 ~= slot4 then
			if uv0._isSortHightToLow then
				return slot4 < slot2
			end

			return slot2 < slot4
		end

		return CritterHelper.sortByTotalAttrValue(slot0, slot1)
	end

	return slot0._sortFunc
end

function slot0._getCritterValue(slot0, slot1, slot2)
	if slot1:chcekPrefernectCritterId(slot2:getDefineId()) then
		if slot1:getPrefernectType() == CritterEnum.PreferenceType.All then
			return 110
		elseif slot3 == CritterEnum.PreferenceType.Catalogue then
			return 120
		elseif slot3 == CritterEnum.PreferenceType.Critter then
			return 130
		end

		return 10
	end

	return 0
end

function slot0._getAttrValue(slot0, slot1, slot2)
	if slot2 == CritterEnum.AttributeType.Efficiency then
		return slot1.efficiency, slot1.efficiencyIncrRate
	elseif slot2 == CritterEnum.AttributeType.Patience then
		return slot1.patience, slot1.patienceIncrRate
	elseif slot2 == CritterEnum.AttributeType.Lucky then
		return slot1.lucky, slot1.luckyIncrRate
	end

	return 0
end

function slot0.getSortAttrId(slot0)
	return slot0._sortAttrId
end

function slot0.getSortIsHightToLow(slot0)
	return slot0._isSortHightToLow
end

function slot0.clearSelect(slot0)
	for slot4, slot5 in ipairs(slot0._scrollViews) do
		slot5:setSelect(nil)
	end

	slot0._selectUid = nil
end

function slot0._refreshSelect(slot0)
	for slot5, slot6 in ipairs(slot0._scrollViews) do
		slot6:setSelect(slot0:getById(slot0._selectUid))
	end
end

function slot0.setSelect(slot0, slot1)
	slot0._selectUid = slot1

	slot0:_refreshSelect()
end

function slot0.getSelectId(slot0)
	return slot0._selectUid
end

function slot0.getById(slot0, slot1)
	return uv0.super.getById(slot0, slot1) or slot0._trainCritterMODict and slot0._trainCritterMODict[slot1]
end

function slot0.setFilterResType(slot0, slot1, slot2)
	slot0._filterIncludeList = {}
	slot0._filterExcludeList = {}

	slot0:_setList(slot0._filterIncludeList, slot1)
	slot0:_setList(slot0._filterExcludeList, slot2)
end

function slot0.isFilterType(slot0, slot1, slot2)
	if slot0:_isSameValue(slot0._filterIncludeList, slot1) and slot0:_isSameValue(slot0._filterExcludeList, slot2) then
		return true
	end

	return false
end

function slot0.isFilterTypeEmpty(slot0)
	return slot0:_isEmptyList(slot0._filterTypeList)
end

function slot0._setList(slot0, slot1, slot2)
	tabletool.addValues(slot1, slot2)
end

function slot0._isListValue(slot0, slot1, slot2)
	if slot2 and tabletool.indexOf(slot1, slot2) then
		return true
	end

	return false
end

function slot0._isSameValue(slot0, slot1, slot2)
	if slot0:_isEmptyList(slot1) and slot0:_isEmptyList(slot2) then
		return true
	end

	if #slot1 ~= #slot2 then
		return false
	end

	for slot6, slot7 in ipairs(slot2) do
		if not tabletool.indexOf(slot1, slot7) then
			return false
		end
	end

	for slot6, slot7 in ipairs(slot1) do
		if not tabletool.indexOf(slot2, slot7) then
			return false
		end
	end

	return true
end

function slot0._isEmptyList(slot0, slot1)
	return slot1 == nil or #slot1 < 1
end

slot0.instance = slot0.New()

return slot0
