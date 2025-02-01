module("modules.logic.room.model.critter.RoomTrainHeroListModel", package.seeall)

slot0 = class("RoomTrainHeroListModel", ListScrollModel)

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
	slot0:clearData()
	slot0:clearFilterData()
end

function slot0.clearData(slot0)
	uv0.super.clear(slot0)

	slot0._selectHeroId = nil
end

function slot0.clearFilterData(slot0)
	slot0._order = RoomCharacterEnum.CharacterOrderType.RareDown
end

function slot0.setHeroList(slot0, slot1)
	slot0.critterFilterMO = slot1

	slot0:updateHeroList()
end

function slot0.updateHeroList(slot0, slot1)
	slot3 = {
		[slot8.trainInfo.heroId] = true
	}

	for slot7, slot8 in ipairs(CritterModel.instance:getCultivatingCritters()) do
		if slot1 ~= slot8.trainInfo.heroId then
			-- Nothing
		end
	end

	slot4 = {}
	slot0._trainHeroMODict = slot0._trainHeroMODict or {}
	slot7 = slot0:_isHasFilterType(CritterEnum.FilterType.Race)

	for slot11, slot12 in ipairs(HeroModel.instance:getList()) do
		if CritterConfig.instance:getCritterHeroPreferenceCfg(slot12.heroId) ~= nil then
			if slot0:getById(slot12.heroId) == nil then
				slot14 = RoomTrainHeroMO.New()

				slot14:initHeroMO(slot12)

				slot0._trainHeroMODict[slot12.heroId] = slot14
			else
				slot14:updateSkinId(slot12.skin)
			end

			if not slot3[slot12.heroId] then
				if not slot7 or slot0:_checkFilterisPass(slot14) then
					table.insert(slot4, slot14)
				end
			end
		end
	end

	table.sort(slot4, slot0:_getSortFunction())
	slot0:setList(slot4)
	slot0:_refreshSelect()
end

function slot0._isHasFilterType(slot0, slot1)
	if slot0.critterFilterMO and slot0.critterFilterMO:getFilterCategoryDict() and slot2[slot1] and #slot3 > 0 then
		return true
	end

	return false
end

function slot0._checkFilterisPass(slot0, slot1)
	slot3 = slot1:getPrefernectIds()

	if slot1:getPrefernectType() == CritterEnum.PreferenceType.All then
		return true
	elseif slot2 == CritterEnum.PreferenceType.Catalogue then
		for slot7 = 1, #slot3 do
			if slot0.critterFilterMO:checkRaceByCatalogueId(slot3[slot3]) then
				return true
			end
		end
	elseif slot2 == CritterEnum.PreferenceType.Critter then
		for slot7 = 1, #slot3 do
			if slot0.critterFilterMO:checkRaceByCatalogueId(CritterConfig.instance:getCritterCatalogue(slot3[slot7])) then
				return true
			end
		end
	end

	return false
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
	slot0._critterMO = RoomTrainCritterListModel.instance:getById(RoomTrainCritterListModel.instance:getSelectId())

	if slot0._sortFunc then
		return slot0._sortFunc
	end

	function slot0._sortFunc(slot0, slot1)
		if uv0._critterMO and uv0:_getCritterValue(slot0, uv0._critterMO) ~= uv0:_getCritterValue(slot1, uv0._critterMO) then
			return slot3 < slot2
		end

		if uv0:_getAttrValue(slot0, uv0._sortAttrId) ~= uv0:_getAttrValue(slot1, uv0._sortAttrId) then
			if uv0._isSortHightToLow then
				return slot3 < slot2
			end

			return slot2 < slot3
		end

		if slot0.heroConfig.rare ~= slot1.heroConfig.rare then
			return slot1.heroConfig.rare < slot0.heroConfig.rare
		end

		if slot0.heroId ~= slot1.heroId then
			return slot1.heroId < slot0.heroId
		end
	end

	return slot0._sortFunc
end

function slot0._getAttrValue(slot0, slot1, slot2)
	if slot1:getAttributeInfoMO().attributeId == slot2 then
		return 100
	end

	return 0
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

function slot0.setOrder(slot0, slot1)
	slot0._order = slot1
end

function slot0.getOrder(slot0)
	return slot0._order
end

function slot0.getById(slot0, slot1)
	return uv0.super.getById(slot0, slot1) or slot0._trainHeroMODict and slot0._trainHeroMODict[slot1]
end

function slot0.clearSelect(slot0)
	for slot4, slot5 in ipairs(slot0._scrollViews) do
		slot5:setSelect(nil)
	end

	slot0._selectHeroId = nil
end

function slot0._refreshSelect(slot0)
	for slot5, slot6 in ipairs(slot0._scrollViews) do
		slot6:setSelect(slot0:getById(slot0._selectHeroId))
	end
end

function slot0.getSelectId(slot0)
	return slot0._selectHeroId
end

function slot0.setSelect(slot0, slot1)
	slot0._selectHeroId = slot1

	slot0:_refreshSelect()
end

function slot0.initFilter(slot0)
	slot0:setFilterCareer()
end

function slot0.initOrder(slot0)
	slot0._order = RoomCharacterEnum.CharacterOrderType.RareDown
end

slot0.instance = slot0.New()

return slot0
