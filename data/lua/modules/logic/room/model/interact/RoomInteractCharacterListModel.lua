module("modules.logic.room.model.interact.RoomInteractCharacterListModel", package.seeall)

slot0 = class("RoomInteractCharacterListModel", ListScrollModel)

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

	slot0._heroMODict = nil
end

function slot0.clearMapData(slot0)
	uv0.super.clear(slot0)

	slot0._selectHeroId = nil
end

function slot0.clearFilterData(slot0)
	slot0._filterCareerDict = {}
	slot0._order = RoomCharacterEnum.CharacterOrderType.RareDown
end

function slot0.setCharacterList(slot0)
	slot1 = {}
	slot0._heroMODict = slot0._heroMODict or {}
	slot3 = RoomInteractBuildingModel.instance

	for slot7, slot8 in ipairs(HeroModel.instance:getList()) do
		if RoomConfig.instance:getRoomCharacterConfig(slot8.skin) and RoomCharacterModel.instance:getCharacterMOById(slot8.heroId) then
			slot12 = slot8.heroId

			if slot0:isFilterCareer(slot8.config.career) then
				if not slot0._heroMODict[slot12] then
					slot14 = RoomInteractCharacterMO.New()

					slot14:init({
						use = false,
						heroId = slot12
					})

					slot0._heroMODict[slot12] = slot14
				end

				slot14.use = slot3:isSelectHeroId(slot12)

				table.insert(slot1, slot14)
			end
		end
	end

	table.sort(slot1, slot0:_getSortFunction())
	slot0:setList(slot1)
	slot0:_refreshSelect()
end

function slot0.updateCharacterList(slot0)
	for slot6, slot7 in ipairs(slot0:getList()) do
		slot7.use = RoomInteractBuildingModel.instance:isSelectHeroId(slot7.heroId)
	end

	slot0:onModelUpdate()
end

function slot0._getSortFunction(slot0)
	if slot0._sortFunc then
		return slot0._sortFunc
	end

	function slot0._sortFunc(slot0, slot1)
		if slot0.heroConfig.rare ~= slot1.heroConfig.rare then
			if uv0:getOrder() == RoomCharacterEnum.CharacterOrderType.RareUp then
				return slot0.heroConfig.rare < slot1.heroConfig.rare
			elseif slot2 == RoomCharacterEnum.CharacterOrderType.RareDown then
				return slot1.heroConfig.rare < slot0.heroConfig.rare
			end
		end

		if slot0.id ~= slot1.id then
			return slot0.id < slot1.id
		end
	end

	return slot0._sortFunc
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

function slot0.initCharacter(slot0)
	slot0:setCharacterList()
end

function slot0.initFilter(slot0)
	slot0:setFilterCareer()
end

function slot0.initOrder(slot0)
	slot0._order = RoomCharacterEnum.CharacterOrderType.RareDown
end

slot0.instance = slot0.New()

return slot0
