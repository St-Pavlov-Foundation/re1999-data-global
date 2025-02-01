module("modules.logic.season.model.Activity104EquipItemBookModel", package.seeall)

slot0 = class("Activity104EquipItemBookModel", ListScrollModel)

function slot0.clear(slot0)
	uv0.super.clear(slot0)

	slot0.activityId = nil
	slot0.curSelectItemId = nil
	slot0._itemMap = nil
	slot0.recordNew = nil
	slot0._itemStartAnimTime = nil
	slot0.tagModel = nil
end

function slot0.initDatas(slot0, slot1)
	slot0.activityId = slot1
	slot0.curSelectItemId = nil

	slot0:initSubModel()
	slot0:initPlayerPrefs()
	slot0:initList()
end

function slot0.initList(slot0)
	slot0:initConfig()
	slot0:initBackpack()

	if slot0:getCount() > 0 then
		slot0:setSelectItemId(slot0:getByIndex(1).id)
	end
end

function slot0.initSubModel(slot0)
	slot0.tagModel = Activity104EquipTagModel.New()

	slot0.tagModel:init(slot0.activityId)
end

function slot0.initConfig(slot0)
	slot1 = {}

	for slot6, slot7 in pairs(SeasonConfig.instance:getSeasonEquipCos()) do
		if not SeasonConfig.instance:getEquipIsOptional(slot6) and not SeasonEquipMetaUtils.isBanActivity(slot7, slot0.activityId) and slot0:isCardCanShowByTag(slot7.tag) then
			slot8 = Activity104EquipBookMo.New()

			slot8:init(slot6)
			table.insert(slot1, slot8)
		end
	end

	slot0:setList(slot1)
end

function slot0.initPlayerPrefs(slot0)
	slot0.recordNew = SeasonEquipLocalRecord.New()

	slot0.recordNew:init(slot0.activityId, Activity104Enum.PlayerPrefsKeyItemUid)
end

function slot0.initBackpack(slot0)
	slot0._itemMap = Activity104Model.instance:getAllItemMo(slot0.activityId) or {}

	for slot4, slot5 in pairs(slot0._itemMap) do
		if SeasonConfig.instance:getSeasonEquipCo(slot5.itemId) and slot0:getById(slot5.itemId) then
			slot7.count = slot7.count + 1

			if not slot0.recordNew:contain(slot4) then
				slot7:setIsNew(true)
			end
		end
	end

	slot0:sort(uv0.sortItemMOList)
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
		slot0._itemStartAnimTime = Time.time + SeasonEquipBookItem.OpenAnimStartTime
	end

	if not slot0:getIndex(slot1) or slot3 > SeasonEquipBookItem.AnimRowCount * SeasonEquipBookItem.ColumnCount then
		return -1
	end

	if math.floor((slot3 - 1) / SeasonEquipBookItem.ColumnCount) * SeasonEquipBookItem.OpenAnimTime + SeasonEquipBookItem.OpenAnimStartTime < slot2 - slot0._itemStartAnimTime then
		return -1
	else
		return slot4 - slot5
	end
end

function slot0.sortItemMOList(slot0, slot1)
	if slot0.count > 0 ~= (slot1.count > 0) then
		return slot2
	end

	slot5 = SeasonConfig.instance:getSeasonEquipCo(slot1.id)

	if SeasonConfig.instance:getSeasonEquipCo(slot0.id) ~= nil and slot5 ~= nil then
		if slot4.rare ~= slot5.rare then
			return slot5.rare < slot4.rare
		else
			return slot5.equipId < slot4.equipId
		end
	else
		return slot0.id < slot1.id
	end
end

function slot0.setSelectItemId(slot0, slot1)
	if slot0:getById(slot1) then
		slot0.curSelectItemId = slot1

		slot2:setIsNew(false)
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

slot0.instance = slot0.New()

return slot0
