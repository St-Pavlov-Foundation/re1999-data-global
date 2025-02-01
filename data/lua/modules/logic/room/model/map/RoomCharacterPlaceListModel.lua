module("modules.logic.room.model.map.RoomCharacterPlaceListModel", package.seeall)

slot0 = class("RoomCharacterPlaceListModel", ListScrollModel)

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
	slot0:clearMapData()
	slot0:clearFilterData()
end

function slot0.clearMapData(slot0)
	uv0.super.clear(slot0)

	slot0._selectHeroId = nil
end

function slot0.clearFilterData(slot0)
	slot0._filterCareerDict = {}
	slot0._order = RoomCharacterEnum.CharacterOrderType.RareDown

	slot0:setIsFilterOnBirthday()
end

function slot0.setCharacterPlaceList(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(HeroModel.instance:getList()) do
		if RoomConfig.instance:getRoomCharacterConfig(slot7.skin) then
			if slot0:isFilterBirthday(slot7.heroId) and slot0:isFilterCareer(slot7.config.career) then
				slot14 = RoomCharacterPlaceMO.New()

				slot14:init({
					heroId = slot7.heroId,
					use = RoomCharacterModel.instance:getCharacterMOById(slot7.heroId) and slot12:isPlaceSourceState() and (slot12.characterState == RoomCharacterEnum.CharacterState.Map or slot12.characterState == RoomCharacterEnum.CharacterState.Revert)
				})
				table.insert(slot1, slot14)
			end
		end
	end

	table.sort(slot1, slot0._sortFunction)
	slot0:setList(slot1)
	slot0:_refreshSelect()
end

function slot0._sortFunction(slot0, slot1)
	if slot0.use and not slot1.use then
		return true
	elseif not slot0.use and slot1.use then
		return false
	end

	if uv0.instance._selectHeroId and not slot0.use and not slot1.use then
		if slot0.heroId == slot2 and slot1.heroId ~= slot2 then
			return true
		elseif slot0.heroId ~= slot2 and slot1.heroId == slot2 then
			return false
		end
	end

	if uv0.instance:getOrder() == RoomCharacterEnum.CharacterOrderType.RareUp and slot0.heroConfig.rare ~= slot1.heroConfig.rare then
		return slot0.heroConfig.rare < slot1.heroConfig.rare
	elseif slot3 == RoomCharacterEnum.CharacterOrderType.RareDown and slot0.heroConfig.rare ~= slot1.heroConfig.rare then
		return slot1.heroConfig.rare < slot0.heroConfig.rare
	end

	slot4 = HeroConfig.instance:getFaithPercent(slot0.heroMO.faith)[1]
	slot5 = HeroConfig.instance:getFaithPercent(slot1.heroMO.faith)[1]

	if slot3 == RoomCharacterEnum.CharacterOrderType.FaithUp then
		if slot4 ~= slot5 then
			return slot4 < slot5
		end

		if slot0.heroConfig.rare ~= slot1.heroConfig.rare then
			return slot1.heroConfig.rare < slot0.heroConfig.rare
		end
	elseif slot3 == RoomCharacterEnum.CharacterOrderType.FaithDown then
		if slot4 ~= slot5 then
			return slot5 < slot4
		end

		if slot0.heroConfig.rare ~= slot1.heroConfig.rare then
			return slot1.heroConfig.rare < slot0.heroConfig.rare
		end
	end

	if RoomCharacterModel.instance:isOnBirthday(slot0.heroId) ~= RoomCharacterModel.instance:isOnBirthday(slot1.heroId) then
		return slot6
	end

	return slot0.id < slot1.id
end

function slot0.setOrder(slot0, slot1)
	slot0._order = slot1
end

function slot0.getOrder(slot0)
	return slot0._order
end

function slot0.setFilterCareer(slot0, slot1)
	slot0._filterCareerDict = {}

	if slot1 and #slot1 > 0 then
		for slot5, slot6 in ipairs(slot1) do
			slot0._filterCareerDict[slot6] = true
		end
	end

	slot0:setIsFilterOnBirthday()
end

function slot0.getFilterCareer(slot0)
	for slot4, slot5 in pairs(slot0._filterCareerDict) do
		if slot5 == true then
			return slot4
		end
	end
end

function slot0.isFilterCareer(slot0, slot1)
	return slot0:isFilterCareerEmpty() or slot0._filterCareerDict[slot1]
end

function slot0.isFilterCareerEmpty(slot0)
	return not LuaUtil.tableNotEmpty(slot0._filterCareerDict)
end

function slot0.getIsFilterOnBirthday(slot0)
	return slot0._isFilterOnBirthday
end

function slot0.setIsFilterOnBirthday(slot0, slot1)
	slot0._isFilterOnBirthday = slot1
end

function slot0.isFilterBirthday(slot0, slot1)
	slot2 = true

	if slot1 and slot0:getIsFilterOnBirthday() then
		slot2 = RoomCharacterModel.instance:isOnBirthday(slot1)
	end

	return slot2
end

function slot0.hasHeroOnBirthday(slot0)
	slot1 = false

	for slot6, slot7 in ipairs(slot0:getList()) do
		if RoomCharacterModel.instance:isOnBirthday(slot7.id) then
			slot1 = true

			break
		end
	end

	return slot1
end

function slot0.clearSelect(slot0)
	for slot4, slot5 in ipairs(slot0._scrollViews) do
		slot5:setSelect(nil)
	end

	slot0._selectHeroId = nil
end

function slot0._refreshSelect(slot0)
	slot1 = nil

	for slot6, slot7 in ipairs(slot0:getList()) do
		if slot7.id == slot0._selectHeroId then
			slot1 = slot7
		end
	end

	for slot6, slot7 in ipairs(slot0._scrollViews) do
		slot7:setSelect(slot1)
	end
end

function slot0.setSelect(slot0, slot1)
	slot0._selectHeroId = slot1

	slot0:_refreshSelect()
end

function slot0.initCharacterPlace(slot0)
	slot0:setCharacterPlaceList()
end

function slot0.initFilter(slot0)
	slot0:setFilterCareer()
end

function slot0.initOrder(slot0)
	slot0._order = RoomCharacterEnum.CharacterOrderType.RareDown
end

slot0.instance = slot0.New()

return slot0
