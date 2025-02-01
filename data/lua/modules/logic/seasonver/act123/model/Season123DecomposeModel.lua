module("modules.logic.seasonver.act123.model.Season123DecomposeModel", package.seeall)

slot0 = class("Season123DecomposeModel", ListScrollModel)

function slot0.onInit(slot0)
	slot0:release()
end

function slot0.release(slot0)
	slot0._itemStartAnimTime = nil
	slot0._itemUid2HeroUid = nil
	slot0._itemMap = {}
	slot0.curSelectItemDict = {}
	slot0.curSelectItemCount = 0
	slot0.rareSelectTab = {}
	slot0.tagSelectTab = {}
	slot0.rareAscendState = false
	slot0.curOverPartSelectIndex = 1
	slot0.itemColunmCount = 6
	slot0.AnimRowCount = 4
	slot0.OpenAnimTime = 0.06
	slot0.OpenAnimStartTime = 0.05
end

function slot0.clear(slot0)
	uv0.super.clear(slot0)
end

function slot0.initDatas(slot0, slot1)
	slot0.curActId = slot1
	slot0.curSelectItemDict = {}
	slot0.curSelectItemCount = 0
	slot0.rareSelectTab = {}
	slot0.tagSelectTab = {}
	slot0.rareAscendState = false
	slot0.curOverPartSelectIndex = slot0.curOverPartSelectIndex or 1
	slot0.itemColunmCount = 6

	slot0:initPosList()
	slot0:initList()
end

function slot0.initList(slot0)
	slot1 = {}
	slot0._itemMap = Season123Model.instance:getAllItemMo(slot0.curActId) or {}

	for slot5, slot6 in pairs(slot0._itemMap) do
		if Season123Config.instance:getSeasonEquipCo(slot6.itemId) and not Season123EquipMetaUtils.isBanActivity(slot7, slot0.curActId) and slot0:isCardCanShow(slot7) then
			table.insert(slot1, slot6)
		end
	end

	table.sort(slot1, uv0.sortItemMOList)
	slot0:setList(slot1)
end

function slot0.initPosList(slot0)
	slot0._itemUid2HeroUid = {}

	if not Season123Model.instance:getSeasonAllHeroGroup(slot0.curActId) then
		return
	end

	for slot5, slot6 in ipairs(slot1) do
		if slot6.activity104Equips then
			slot0:parseHeroGroupEquips(slot6, slot7)
		end
	end
end

function slot0.parseHeroGroupEquips(slot0, slot1, slot2)
	slot0._itemMap = Season123Model.instance:getAllItemMo(slot0.curActId) or {}

	for slot6, slot7 in pairs(slot2) do
		slot8 = slot7.index
		slot9 = slot1:getHeroByIndex(slot8 + 1)

		if slot8 == Activity123Enum.MainCharPos then
			slot9 = Activity123Enum.MainRoleHeroUid
		end

		if slot9 then
			for slot13, slot14 in pairs(slot7.equipUid) do
				if slot14 ~= Activity123Enum.EmptyUid and (not slot0._itemUid2HeroUid[slot14] or slot0._itemUid2HeroUid[slot14] == Activity123Enum.EmptyUid) and slot0._itemMap[slot14] ~= nil then
					slot0._itemUid2HeroUid[slot14] = slot9
				end
			end
		end
	end
end

function slot0.isCardCanShow(slot0, slot1)
	return slot0:isCardCanShowByRare(slot1.rare) and slot0:isCardCanShowByTag(slot1)
end

function slot0.isCardCanShowByRare(slot0, slot1)
	slot2 = false
	slot3 = false

	for slot7, slot8 in pairs(slot0.rareSelectTab) do
		if slot7 == slot1 then
			slot2 = slot8
		end

		if slot8 then
			slot3 = true
		end
	end

	return slot2 or not slot3
end

function slot0.isCardCanShowByTag(slot0, slot1)
	slot2 = false
	slot3 = false
	slot4 = string.split(slot1.tag, "#")

	for slot8, slot9 in pairs(slot0.tagSelectTab) do
		for slot13, slot14 in ipairs(slot4) do
			if slot0.tagSelectTab[tonumber(slot14)] then
				slot2 = true
			end
		end

		if slot9 then
			slot3 = true
		end
	end

	return slot2 or not slot3
end

function slot0.getDelayPlayTime(slot0, slot1)
	if slot1 == nil then
		return -1
	end

	if slot0._itemStartAnimTime == nil then
		slot0._itemStartAnimTime = Time.time + slot0.OpenAnimStartTime
	end

	if not slot0:getIndex(slot1) or slot3 > slot0.AnimRowCount * slot0.itemColunmCount then
		return -1
	end

	if slot2 - slot0._itemStartAnimTime - (math.floor((slot3 - 1) / slot0.itemColunmCount) * slot0.OpenAnimTime + slot0.OpenAnimStartTime) > 0.1 then
		return -1
	else
		return slot4
	end
end

function slot0.setItemCellCount(slot0, slot1)
	slot0.itemColunmCount = slot1 or 6
end

function slot0.sortItemMOList(slot0, slot1)
	slot2 = uv0.instance:getItemUidToHeroUid(slot0.uid) ~= nil
	slot3 = uv0.instance:getItemUidToHeroUid(slot1.uid) ~= nil
	slot5 = Season123Config.instance:getSeasonEquipCo(slot1.itemId)

	if Season123Config.instance:getSeasonEquipCo(slot0.itemId) ~= nil and slot5 ~= nil then
		if slot4.isMain == Activity123Enum.isMainRole ~= (slot5.isMain == Activity123Enum.isMainRole) then
			return slot6
		end

		if slot4.rare ~= slot5.rare then
			if uv0.instance.rareAscendState then
				return slot4.rare < slot5.rare
			else
				return slot5.rare < slot4.rare
			end
		else
			if slot4.equipId ~= slot5.equipId then
				return slot5.equipId < slot4.equipId
			end

			if (uv0.instance.curSelectItemDict[slot0.uid] ~= nil and uv0.instance.curSelectItemDict[slot0.uid] ~= false) ~= (uv0.instance.curSelectItemDict[slot1.uid] ~= nil and uv0.instance.curSelectItemDict[slot1.uid] ~= false) then
				return slot8
			end

			if slot2 ~= slot3 then
				return slot3
			end

			return slot0.uid < slot1.uid
		end
	else
		return slot0.uid < slot1.uid
	end
end

function slot0.getItemUidToHeroUid(slot0, slot1)
	return slot0._itemUid2HeroUid[slot1]
end

function slot0.setCurSelectItemUid(slot0, slot1)
	if not slot0.curSelectItemDict[slot1] then
		slot0.curSelectItemDict[slot1] = slot0._itemMap[slot1]
		slot0.curSelectItemCount = slot0.curSelectItemCount + 1
	else
		slot0.curSelectItemDict[slot1] = nil
		slot0.curSelectItemCount = slot0.curSelectItemCount - 1
	end
end

function slot0.isSelectedItem(slot0, slot1)
	return slot0.curSelectItemDict[slot1] ~= nil
end

function slot0.clearCurSelectItem(slot0)
	slot0.curSelectItemDict = {}
	slot0.curSelectItemCount = 0
end

function slot0.setRareSelectItem(slot0, slot1)
	for slot5, slot6 in pairs(slot1) do
		slot0.rareSelectTab[slot5] = slot6
	end
end

function slot0.setTagSelectItem(slot0, slot1)
	for slot5, slot6 in pairs(slot1) do
		slot0.tagSelectTab[slot5] = slot6
	end
end

function slot0.hasSelectFilterItem(slot0)
	if GameUtil.getTabLen(slot0.rareSelectTab) > 0 then
		for slot4, slot5 in pairs(slot0.rareSelectTab) do
			if slot5 then
				return true
			end
		end
	end

	if GameUtil.getTabLen(slot0.tagSelectTab) > 0 then
		for slot4, slot5 in pairs(slot0.tagSelectTab) do
			if slot5 then
				return true
			end
		end
	end

	return false
end

function slot0.setRareAscendState(slot0, slot1)
	slot0.rareAscendState = slot1
end

function slot0.sortDecomposeItemListByRare(slot0)
	slot1 = slot0:getList()

	table.sort(slot1, uv0.sortItemMOList)
	slot0:setList(slot1)
end

function slot0.setCurOverPartSelectIndex(slot0, slot1)
	slot0.curOverPartSelectIndex = slot1
end

function slot0.selectOverPartItem(slot0)
	if slot0:getCount() == 0 then
		return
	end

	slot0:clearCurSelectItem()

	if Season123EquipBookModel.instance:getCount() == 0 then
		Season123EquipBookModel.instance:initDatas(slot0.curActId)
	end

	Season123EquipBookModel.instance:getAllEquipItem()

	slot3 = 0

	for slot8, slot9 in pairs(slot0:getList()) do
		slot12 = Season123EquipBookModel.instance.allEquipItemMap[slot9.itemId].count - slot0.curOverPartSelectIndex

		if slot9.itemId ~= -1 then
			slot4 = slot9.itemId
			slot3 = 0
		end

		if slot12 > 0 and slot3 < slot12 and not slot0:isSelectItemMaxCount() then
			slot0.curSelectItemDict[slot9.uid] = slot9
			slot3 = slot3 + 1
			slot0.curSelectItemCount = slot0.curSelectItemCount + 1
		end
	end
end

function slot0.isSelectItemMaxCount(slot0)
	return Activity123Enum.maxDecomposeCount <= slot0.curSelectItemCount
end

function slot0.getDecomposeItemsByItemId(slot0, slot1, slot2)
	slot0._itemMap = Season123Model.instance:getAllItemMo(slot1) or {}

	if GameUtil.getTabLen(slot0._itemMap) == 0 then
		return nil
	end

	if slot0:getCount() == 0 then
		slot0:initDatas(slot1)
	end

	slot4 = {}

	for slot9, slot10 in pairs(slot0:getDict()) do
		if slot10.itemId == slot2 then
			table.insert(slot4, slot10)
		end
	end

	return slot4
end

function slot0.isDecomposeItemUsedByHero(slot0, slot1)
	for slot5, slot6 in pairs(slot1) do
		if slot0:getItemUidToHeroUid(slot6.uid) and slot7 ~= Activity123Enum.EmptyUid then
			return true
		end
	end

	return false
end

function slot0.removeHasDecomposeItems(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0.curSelectItemDict[slot6] = nil
		slot0._itemMap[slot6] = nil
	end
end

slot0.instance = slot0.New()

return slot0
