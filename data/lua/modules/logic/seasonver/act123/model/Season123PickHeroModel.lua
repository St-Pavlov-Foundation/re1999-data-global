module("modules.logic.seasonver.act123.model.Season123PickHeroModel", package.seeall)

slot0 = class("Season123PickHeroModel", ListScrollModel)

function slot0.release(slot0)
	slot0:clear()

	slot0._lastSelectedMap = nil
	slot0._curSelectMap = nil
	slot0._curSelectList = nil
end

function slot0.init(slot0, slot1, slot2, slot3, slot4)
	slot0.activityId = slot1
	slot0.stage = slot2
	slot0._curSelectMap = {}
	slot0._curSelectList = {}

	slot0:initSelectedList(slot3)
	slot0:initHeroList(slot0._lastSelectedMap, slot4)
end

function slot0.initHeroList(slot0, slot1, slot2)
	slot3 = {}

	for slot9, slot10 in ipairs(tabletool.copy(CharacterBackpackCardListModel.instance:getCharacterCardList())) do
		slot11 = Season123PickHeroMO.New()

		slot11:init(slot10.uid, slot10.heroId, slot10.skin, 0 + 1)
		table.insert(slot3, slot11)

		if slot1 and slot1[slot10.heroId] and not slot0._curSelectMap[slot10.uid] then
			slot0._curSelectMap[slot10.uid] = true

			table.insert(slot0._curSelectList, slot10.uid)
		end

		if slot2 and slot2 == slot10.uid then
			slot0._lastSelectedHeroUid = slot2
		end
	end

	logNormal("hero list count : " .. tostring(#slot3))
	table.sort(slot3, uv0.sortList)
	slot0:setList(slot3)

	slot0.heroMOList = slot0:getHeroMOList()
end

function slot0.initSelectedList(slot0, slot1)
	slot0._maxLimit = Activity123Enum.PickHeroCount
	slot0._lastSelectedMap = {}

	if not slot1 then
		return
	end

	for slot5 = 1, Activity123Enum.PickHeroCount do
		if not slot1[slot5].isSupport and not slot6:getIsEmpty() then
			slot0._lastSelectedMap[slot6.heroId] = true
		end

		if slot6.isSupport then
			slot0._maxLimit = slot0._maxLimit - 1
		end
	end
end

function slot0.sortList(slot0, slot1)
	if uv0.instance._curSelectMap[slot0.uid] ~= uv0.instance._curSelectMap[slot1.uid] then
		return slot2
	end

	return slot0.index < slot1.index
end

function slot0.getHeroMOList(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(slot0:getList()) do
		if HeroModel.instance:getById(slot7.uid) then
			table.insert(slot1, slot8)
		end
	end

	return slot1
end

function slot0.refreshList(slot0)
	slot0:initHeroList(nil)
end

function slot0.cleanSelected(slot0)
	for slot4, slot5 in pairs(slot0._curSelectMap) do
		slot0._curSelectMap[slot4] = nil
	end

	for slot4, slot5 in pairs(slot0._curSelectList) do
		slot0._curSelectList[slot4] = nil
	end
end

function slot0.setHeroSelect(slot0, slot1, slot2)
	if slot0:getById(slot1) then
		if slot2 then
			if not slot0._curSelectMap[slot1] then
				slot0._curSelectMap[slot1] = true

				table.insert(slot0._curSelectList, slot1)
			end
		elseif slot0._curSelectMap[slot1] then
			slot0._curSelectMap[slot1] = nil

			tabletool.removeValue(slot0._curSelectList, slot1)
		end

		slot3.isSelect = slot2
	end

	slot0._lastSelectedHeroUid = slot1
end

function slot0.getSelectCount(slot0)
	return #slot0._curSelectList
end

function slot0.getSelectedHeroMO(slot0)
	if slot0._lastSelectedHeroUid then
		return HeroModel.instance:getById(slot0._lastSelectedHeroUid)
	end
end

function slot0.isHeroSelected(slot0, slot1)
	return slot0._curSelectMap[slot1]
end

function slot0.getSelectedIndex(slot0, slot1)
	return tabletool.indexOf(slot0._curSelectList, slot1)
end

function slot0.getLimitCount(slot0)
	return slot0._maxLimit
end

function slot0.getSelectMOList(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0._curSelectList) do
		if slot0:getById(slot6) == nil and slot6 ~= 0 and slot6 ~= Activity123Enum.EmptyUid then
			if HeroModel.instance:getById(slot6) then
				Season123PickHeroMO.New():init(slot8.uid, slot8.heroId, slot8.skin, 0)
			end
		end

		table.insert(slot1, slot7)
	end

	return slot1
end

slot0.instance = slot0.New()

return slot0
