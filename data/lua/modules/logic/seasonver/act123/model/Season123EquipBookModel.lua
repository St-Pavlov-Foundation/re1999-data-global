module("modules.logic.seasonver.act123.model.Season123EquipBookModel", package.seeall)

slot0 = class("Season123EquipBookModel", ListScrollModel)

function slot0.onInit(slot0)
	slot0:clear()
end

function slot0.clear(slot0)
	uv0.super.clear(slot0)

	slot0.equipItemList = {}
	slot0.curSelectItemId = nil
	slot0.curActId = nil
	slot0.tagModel = nil
	slot0._itemStartAnimTime = nil
	slot0.allItemMo = nil
	slot0.recordNew = nil
	slot0.allEquipItemMap = {}
	slot0.ColumnCount = 6
	slot0.AnimRowCount = 4
	slot0.OpenAnimTime = 0.06
	slot0.OpenAnimStartTime = 0.05
end

function slot0.initDatas(slot0, slot1)
	slot0.curActId = slot1
	slot0.curSelectItemId = nil

	slot0:initSubModel()
	slot0:initPlayerPrefs()
	slot0:initList()
end

function slot0.initList(slot0)
	slot0:initConfig()
	slot0:initBackpack()

	if slot0:getCount() > 0 then
		slot0:setCurSelectItemId(slot0:getByIndex(1).id)
	end
end

function slot0.initConfig(slot0)
	slot1 = {}

	for slot6, slot7 in pairs(Season123Config.instance:getSeasonEquipCos()) do
		if not Season123EquipMetaUtils.isBanActivity(slot7, slot0.curActId) and slot0:isCardCanShowByTag(slot7.tag) then
			slot8 = Season123EquipBookMO.New()

			slot8:init(slot6)
			table.insert(slot1, slot8)
		end
	end

	slot0:setList(slot1)
end

function slot0.initBackpack(slot0)
	slot0.allItemMo = Season123Model.instance:getAllItemMo(slot0.curActId) or {}

	for slot4, slot5 in pairs(slot0.allItemMo) do
		if Season123Config.instance:getSeasonEquipCo(slot5.itemId) and slot0:getById(slot5.itemId) then
			slot7.count = slot7.count + 1

			if not slot0.recordNew:contain(slot5.itemId) then
				slot7:setIsNew(true)
			end
		end
	end

	slot0:sort(uv0.sortItemMOList)
end

function slot0.setCurSelectItemId(slot0, slot1)
	if slot0:getById(slot1) then
		slot0.curSelectItemId = slot1

		slot0.recordNew:add(slot1)
		slot2:setIsNew(false)
	else
		slot0.curSelectItemId = nil
	end
end

function slot0.initSubModel(slot0)
	slot0.tagModel = Season123EquipTagModel.New()

	slot0.tagModel:init(slot0.curActId)
end

function slot0.initPlayerPrefs(slot0)
	slot0.recordNew = Season123EquipLocalRecord.New()

	slot0.recordNew:init(slot0.curActId, Activity123Enum.PlayerPrefsKeyItemUid)
end

function slot0.isCardCanShowByTag(slot0, slot1)
	if slot0.tagModel then
		return slot0.tagModel:isCardNeedShow(slot1)
	end

	return true
end

function slot0.getDelayPlayTime(slot0, slot1)
	if slot1 == nil then
		return -1
	end

	if slot0._itemStartAnimTime == nil then
		slot0._itemStartAnimTime = Time.time + slot0.OpenAnimStartTime
	end

	if not slot0:getIndex(slot1) or slot3 > slot0.AnimRowCount * slot0.ColumnCount then
		return -1
	end

	if slot2 - slot0._itemStartAnimTime - (math.floor((slot3 - 1) / slot0.ColumnCount) * slot0.OpenAnimTime + slot0.OpenAnimStartTime) > 0.1 then
		return -1
	else
		return slot4
	end
end

function slot0.sortItemMOList(slot0, slot1)
	if slot0.count > 0 ~= (slot1.count > 0) then
		return slot2
	end

	slot5 = Season123Config.instance:getSeasonEquipCo(slot1.id)

	if Season123Config.instance:getSeasonEquipCo(slot0.id) ~= nil and slot5 ~= nil then
		if slot4.isMain == Activity123Enum.isMainRole ~= (slot5.isMain == Activity123Enum.isMainRole) then
			return slot6
		end

		if slot4.rare ~= slot5.rare then
			return slot5.rare < slot4.rare
		else
			return slot5.equipId < slot4.equipId
		end
	else
		return slot0.id < slot1.id
	end
end

function slot0.checkResetCurSelected(slot0)
	if slot0.curSelectItemId and not slot0:getById(slot0.curSelectItemId) then
		slot0.curSelectItemId = nil
	end
end

function slot0.flushRecord(slot0)
	if slot0.recordNew then
		slot0.recordNew:recordAllItem()
	end
end

function slot0.getEquipBookItemCount(slot0, slot1)
	for slot6 = 1, #slot0:getList() do
		if slot2[slot6].id == slot1 then
			return slot2[slot6].count
		end
	end

	return 0
end

function slot0.refreshBackpack(slot0)
	slot0:initConfig()
	slot0:initBackpack()
end

function slot0.removeDecomposeEquipItem(slot0, slot1)
	slot0:initConfig()
	slot0:initBackpack()

	if slot0:getById(slot0.curSelectItemId) and slot2.count == 0 then
		slot0:setCurSelectItemId(slot0:getByIndex(1).id)
	end
end

function slot0.selectFirstCard(slot0)
	if slot0:getCount() > 0 then
		slot0:setCurSelectItemId(slot0:getByIndex(1).id)
	end
end

function slot0.getAllEquipItem(slot0)
	slot0.allEquipItemMap = {}

	for slot5, slot6 in pairs(Season123Config.instance:getSeasonEquipCos()) do
		if not Season123EquipMetaUtils.isBanActivity(slot6, slot0.curActId) then
			slot7 = Season123EquipBookMO.New()

			slot7:init(slot5)

			slot0.allEquipItemMap[slot5] = slot7
		end
	end

	slot0.allItemMo = Season123Model.instance:getAllItemMo(slot0.curActId) or {}

	for slot5, slot6 in pairs(slot0.allItemMo) do
		if Season123Config.instance:getSeasonEquipCo(slot6.itemId) and slot0.allEquipItemMap[slot6.itemId] then
			slot8.count = slot8.count + 1
		end
	end
end

slot0.instance = slot0.New()

return slot0
