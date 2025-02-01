module("modules.logic.seasonver.act123.model.Season123EquipHeroItemListModel", package.seeall)

slot0 = class("Season123EquipHeroItemListModel", ListScrollModel)
slot0.MainCharPos = ModuleEnum.MaxHeroCountInGroup
slot0.TotalEquipPos = 5
slot0.MaxPos = 1
slot0.HeroMaxPos = 2
slot0.EmptyUid = "0"

function slot0.clear(slot0)
	uv0.super.clear(slot0)

	slot0.activityId = nil
	slot0.curPos = nil
	slot0.equipUid2Pos = nil
	slot0.equipUid2Group = nil
	slot0.equipUid2Slot = nil
	slot0.curEquipMap = nil
	slot0.curSelectSlot = nil
	slot0._itemMap = nil
	slot0.recordNew = nil
	slot0._itemStartAnimTime = nil
	slot0._deckUidMap = nil
	slot0._itemIdDeckCountMap = nil
	slot0.tagModel = nil
end

function slot0.initDatas(slot0, slot1, slot2, slot3, slot4)
	logNormal("Season123EquipHeroItemListModel initDatas")
	slot0:clear()

	slot0.activityId = slot1
	slot0.stage = slot2
	slot0.curPos = uv0.MainCharPos
	slot0.equipUid2Pos = {}
	slot0.equipUid2Slot = {}
	slot0.curEquipMap = {}

	for slot9 = 1, slot0:getEquipMaxCount(slot0.curPos) do
		slot0.curEquipMap[slot9] = uv0.EmptyUid
	end

	slot0.curSelectSlot = slot3 or 1
	slot0.equipUid2Group = {}

	slot0:initSubModel()
	slot0:initUnlockIndex()
	slot0:initItemMap()
	slot0:initPlayerPrefs()
	slot0:initPosData(slot4)
	slot0:initList()
end

function slot0.initSubModel(slot0)
	slot0.tagModel = Season123EquipTagModel.New()

	slot0.tagModel:init(slot0.activityId)
end

function slot0.initUnlockIndex(slot0)
	slot0.curUnlockIndexSet = Season123HeroGroupUtils.getUnlockSlotSet(slot0.activityId)
end

function slot0.initItemMap(slot0)
	slot0._itemMap = Season123Model.instance:getAllItemMo(slot0.activityId) or {}
end

function slot0.initPlayerPrefs(slot0)
	slot0.recordNew = Season123EquipLocalRecord.New()

	slot0.recordNew:init(slot0.activityId, Activity123Enum.PlayerPrefsKeyItemUid)
end

function slot0.initPosData(slot0, slot1)
	if not slot1 then
		return
	end

	for slot5, slot6 in pairs(slot1) do
		slot0:setCardPosData(slot6, slot0.curPos, slot5)
	end
end

function slot0.setCardPosData(slot0, slot1, slot2, slot3)
	slot0.equipUid2Pos[slot1] = slot2
	slot0.equipUid2Slot[slot1] = slot3

	if slot2 == slot0.curPos then
		slot0.curEquipMap[slot3] = slot1
	end
end

function slot0.initList(slot0)
	for slot5, slot6 in pairs(slot0._itemMap) do
		slot0:setListData(slot6.itemId, slot5, slot6, {})
	end

	if HeroGroupModel.instance.battleConfig and slot2.trialMainAct104EuqipId > 0 then
		slot0:setListData(slot2.trialMainAct104EuqipId, uv0.getTrialEquipUID(slot2.trialMainAct104EuqipId, 1), nil, slot1)
	end

	table.sort(slot1, uv0.sortItemMOList)

	slot0._originList = slot1

	slot0:refreshMergeList()
end

function slot0.setListData(slot0, slot1, slot2, slot3, slot4)
	if not SeasonConfig.instance:getEquipIsOptional(slot1) and Season123Config.instance:getSeasonEquipCo(slot1) and slot0:isCardFitRole(slot5) and slot0:isCardCanShowByTag(slot2, slot5.tag) and slot5.isCardBag ~= "1" then
		slot0.equipUid2Group[slot2] = slot5.group

		if not slot3 then
			Season123ItemMO.New():init({
				quantity = 1,
				itemId = slot1,
				uid = slot2
			})
		end

		slot6 = Season123EquipListMo.New()

		slot6:init(slot3)
		table.insert(slot4, slot6)
	end
end

function slot0.isCardFitRole(slot0, slot1)
	if slot0.curPos == uv0.MainCharPos then
		return Season123EquipMetaUtils.isMainRoleCard(slot1)
	else
		return not Season123EquipMetaUtils.isMainRoleCard(slot1)
	end
end

function slot0.isCardCanShowByTag(slot0, slot1, slot2)
	if slot0.tagModel then
		return slot0.tagModel:isCardNeedShow(slot2)
	end

	return true
end

function slot0.refreshMergeList(slot0)
	slot1 = {}
	slot2 = {
		[slot9] = true
	}
	slot3 = {}
	slot4 = {}

	for slot8, slot9 in pairs(slot0.curEquipMap) do
		if slot9 ~= uv0.EmptyUid then
			-- Nothing
		end
	end

	for slot8 = 1, #slot0._originList do
		slot10 = slot0._originList[slot8].itemId

		if slot2[slot0._originList[slot8].id] or slot0.equipUid2Pos[slot9] then
			table.insert(slot1, slot0._originList[slot8])
		elseif slot3[slot10] == nil then
			table.insert(slot1, slot0._originList[slot8])

			slot3[slot10] = 1
			slot4[slot9] = slot10
		else
			slot3[slot10] = slot11 + 1
		end
	end

	slot0._deckUidMap = slot4
	slot0._itemIdDeckCountMap = slot3

	slot0:setList(slot1)
end

function slot0.changeSelectSlot(slot0, slot1)
	if slot1 <= slot0:getEquipMaxCount(slot0.curPos) and slot1 > 0 then
		slot0.curSelectSlot = slot1
	end
end

function slot0.getEquipMO(slot0, slot1)
	return slot0._itemMap[slot1]
end

function slot0.equipShowItem(slot0, slot1)
	slot0.curEquipMap[slot0.curSelectSlot] = slot1
end

function slot0.equipItem(slot0, slot1, slot2)
	slot0.curEquipMap[slot2] = slot1
	slot0.equipUid2Pos[slot1] = slot0.curPos
	slot0.equipUid2Slot[slot1] = slot2
end

function slot0.unloadShowSlot(slot0, slot1)
	slot0.curEquipMap[slot1] = uv0.EmptyUid
end

function slot0.unloadItem(slot0, slot1)
	slot0.equipUid2Pos[slot1] = nil
	slot0.equipUid2Slot[slot1] = nil

	for slot6 = 1, slot0:getEquipMaxCount(slot0.curPos) do
		if slot0.curEquipMap[slot6] == slot1 then
			slot0.curEquipMap[slot6] = uv0.EmptyUid
		end
	end
end

function slot0.unloadItemByPos(slot0, slot1, slot2)
	for slot6, slot7 in pairs(slot0.equipUid2Pos) do
		if slot7 == slot1 and slot0.equipUid2Slot[slot6] == slot2 then
			slot0:unloadItem(slot6)

			return
		end
	end
end

function slot0.getItemUidByPos(slot0, slot1, slot2)
	for slot6, slot7 in pairs(slot0.equipUid2Pos) do
		if slot7 == slot1 and slot0.equipUid2Slot[slot6] == slot2 then
			return slot6
		end
	end

	return uv0.EmptyUid
end

function slot0.getItemEquipedPos(slot0, slot1)
	return slot0.equipUid2Pos[slot1], slot0.equipUid2Slot[slot1]
end

function slot0.getEquipMaxCount(slot0, slot1)
	return slot1 == uv0.MainCharPos and uv0.HeroMaxPos or uv0.MaxPos
end

function slot0.getPosHeroUid(slot0, slot1)
	return nil
end

function slot0.slotIsLock(slot0, slot1)
	return not Season123Model.instance:isSeasonStagePosUnlock(slot0.activityId, slot0.stage, slot1, slot0.curPos)
end

function slot0.disableBecauseSameCard(slot0, slot1)
	if slot0.equipUid2Group[slot1] then
		for slot6, slot7 in pairs(slot0.curEquipMap) do
			if slot0.equipUid2Group[slot7] and slot6 ~= slot0.curSelectSlot and slot8 == slot2 then
				return true
			end
		end
	end

	return false
end

function slot0.disableBecauseRole(slot0, slot1)
	if not SeasonConfig.instance:getSeasonEquipCo(slot1) then
		return false
	end

	if slot0.curPos == uv0.MainCharPos then
		if Season123EquipMetaUtils.isMainRoleCard(slot2) then
			return false
		end
	elseif not slot3 then
		return false
	end

	return true
end

function slot0.isItemUidInShowSlot(slot0, slot1)
	return slot0.curEquipMap[slot0.curSelectSlot] == slot1
end

function slot0.isAllSlotEmpty(slot0)
	for slot5 = 1, slot0:getEquipMaxCount(slot0.curPos) do
		if slot0.curEquipMap[slot5] ~= uv0.EmptyUid then
			return false
		end
	end

	return true
end

function slot0.sortItemMOList(slot0, slot1)
	slot3 = Season123Config.instance:getSeasonEquipCo(slot1.itemId)

	if Season123Config.instance:getSeasonEquipCo(slot0.itemId) ~= nil and slot3 ~= nil then
		if uv0.instance:disableBecauseRole(slot1.itemId) ~= uv0.instance:disableBecauseRole(slot0.itemId) then
			return slot5
		end

		if slot2.rare ~= slot3.rare then
			return slot3.rare < slot2.rare
		else
			return slot3.equipId < slot2.equipId
		end
	else
		return slot0.id < slot1.id
	end
end

function slot0.flushSlot(slot0, slot1)
	slot0:unloadItemByPos(slot0.curPos, slot1)

	if slot0.curEquipMap[slot1] ~= uv0.EmptyUid then
		slot0:unloadTeamLimitCard(slot2)
		slot0:unloadItem(slot2)
		slot0:equipItem(slot2, slot1)
	end
end

function slot0.unloadTeamLimitCard(slot0, slot1)
	if not slot0:getById(slot1) then
		return
	end

	slot3 = slot0:getList()
	slot5 = false

	if Season123Config.instance:getSeasonEquipCo(slot2.itemId) and slot4.teamLimit == 0 then
		return false
	end

	for slot9, slot10 in pairs(slot0.equipUid2Pos) do
		if slot9 ~= slot1 and slot0._itemMap[slot9] and Season123Config.instance:getSeasonEquipCo(slot0._itemMap[slot9].itemId) and slot11.teamLimit ~= 0 and slot11.teamLimit == slot4.teamLimit then
			slot0:unloadItem(slot9)

			slot5 = true
		end
	end

	return slot5
end

function slot0.resumeSlotData(slot0)
	for slot5 = 1, slot0:getEquipMaxCount(slot0.curPos) do
		slot0.curEquipMap[slot5] = slot0:getItemUidByPos(slot0.curPos, slot5)
	end
end

function slot0.getEquipedCards(slot0)
	return slot0:packUpdateEquips()
end

function slot0.packUpdateEquips(slot0)
	for slot5 = 1, uv0.HeroMaxPos do
	end

	return {
		[slot5] = slot0.curEquipMap[slot5] or uv0.EmptyUid
	}
end

function slot0.checkResetCurSelected(slot0)
	for slot5 = 1, slot0:getEquipMaxCount(slot0.curPos) do
		if slot0.curEquipMap[slot5] ~= uv0.EmptyUid and not slot0._itemMap[slot0.curEquipMap[slot5]] then
			slot0.curEquipMap[slot5] = uv0.EmptyUid
		end
	end
end

function slot0.getShowUnlockSlotCount(slot0)
	slot1 = 0

	for slot7 = slot0:getEquipMaxCount(slot0.curPos), 1, -1 do
		if slot0:isEquipCardPosUnlock(slot7, slot2) then
			return math.max(slot1, slot7)
		end
	end

	return slot1
end

function slot0.isEquipCardPosUnlock(slot0, slot1, slot2)
	return slot0.curUnlockIndexSet[Season123Model.instance:getUnlockCardIndex(slot2, slot1)] == true
end

function slot0.getNeedShowDeckCount(slot0, slot1)
	if slot0._deckUidMap[slot1] == nil then
		return false
	end

	return slot0._itemIdDeckCountMap[slot2] > 1, slot3
end

function slot0.getDelayPlayTime(slot0, slot1)
	if slot1 == nil then
		return -1
	end

	slot2 = slot0.curPos == uv0.MainCharPos and SeasonEquipHeroViewContainer.ColumnCount or SeasonEquipItem.ColumnCount

	if slot0._itemStartAnimTime == nil then
		slot0._itemStartAnimTime = Time.time + SeasonEquipItem.OpenAnimStartTime
	end

	if not slot0:getIndex(slot1) or slot4 > SeasonEquipItem.AnimRowCount * slot2 then
		return -1
	end

	if math.floor((slot4 - 1) / slot2) * SeasonEquipItem.OpenAnimTime + SeasonEquipItem.OpenAnimStartTime < slot3 - slot0._itemStartAnimTime then
		return -1
	else
		return slot5 - slot6
	end
end

function slot0.flushRecord(slot0)
	if slot0.recordNew then
		slot0.recordNew:recordAllItem()
	end
end

slot0.instance = slot0.New()

return slot0
