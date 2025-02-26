module("modules.logic.season.model.Activity104EquipItemListModel", package.seeall)

slot0 = class("Activity104EquipItemListModel", ListScrollModel)
slot0.MainCharPos = 4
slot0.TotalEquipPos = 5
slot0.MaxPos = 2
slot0.HeroMaxPos = 1
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
	logNormal("Activity104EquipItemListModel initDatas")
	slot0:clear()

	slot0.activityId = slot1
	slot0.curPos = slot3
	slot0.groupIndex = slot2
	slot0.equipUid2Pos = {}
	slot0.equipUid2Slot = {}
	slot0.curEquipMap = {}

	for slot9 = 1, slot0:getEquipMaxCount(slot0.curPos) do
		slot0.curEquipMap[slot9] = uv0.EmptyUid
	end

	slot0.curSelectSlot = slot4 or 1
	slot0.equipUid2Group = {}

	slot0:initSubModel()
	slot0:initItemMap()
	slot0:initPlayerPrefs()
	slot0:initPosData()
	slot0:initList()
end

function slot0.initSubModel(slot0)
	slot0.tagModel = Activity104EquipTagModel.New()

	slot0.tagModel:init(slot0.activityId)
end

function slot0.initItemMap(slot0)
	slot0._itemMap = Activity104Model.instance:getAllItemMo(slot0.activityId) or {}
end

function slot0.initPlayerPrefs(slot0)
	slot0.recordNew = SeasonEquipLocalRecord.New()

	slot0.recordNew:init(slot0.activityId, Activity104Enum.PlayerPrefsKeyItemUid)
end

function slot0.getTrialEquipUID(...)
	return table.concat({
		...
	}, "#")
end

function slot0.isTrialEquip(slot0)
	return tonumber(slot0) == nil
end

function slot0.curSelectIsTrialEquip(slot0)
	return slot0.curEquipMap[slot0.curSelectSlot] and uv0.isTrialEquip(slot1)
end

function slot0.curMapIsTrialEquipMap(slot0)
	if slot0.curPos == uv0.MainCharPos then
		return HeroGroupModel.instance.battleConfig and slot1.trialMainAct104EuqipId > 0
	end

	if not slot0:getGroupMO() then
		return
	end

	if slot1.trialDict and slot2[slot0.curPos + 1] then
		for slot9 = 1, slot0:getEquipMaxCount(slot3) do
			if HeroConfig.instance:getTrial104Equip(slot9, slot4[1], slot4[2]) and slot10 > 0 then
				return true
			end
		end
	end
end

function slot0.initPosData(slot0)
	if not slot0:getGroupMO() then
		return
	end

	for slot6, slot7 in pairs(slot1.activity104Equips) do
		for slot12 = 1, slot0:getEquipMaxCount(slot6) do
			if slot0._itemMap[slot7.equipUid[slot12]] then
				slot0:setCardPosData(slot13, slot6, slot12)
			end
		end
	end

	if slot1.trialDict then
		for slot7, slot8 in pairs(slot3) do
			for slot14 = 1, slot0:getEquipMaxCount(slot7 - 1) do
				if HeroConfig.instance:getTrial104Equip(slot14, slot8[1], slot8[2]) and slot15 > 0 then
					slot0:setCardPosData(uv0.getTrialEquipUID(slot15, slot14, slot8[1]), slot9, slot14)
				end
			end
		end
	end

	if HeroGroupModel.instance.battleConfig and slot4.trialMainAct104EuqipId > 0 then
		slot5 = 1

		slot0:setCardPosData(uv0.getTrialEquipUID(slot4.trialMainAct104EuqipId, slot5), uv0.MainCharPos, slot5)
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

	if slot0:getGroupMO() and slot2.trialDict then
		for slot7, slot8 in pairs(slot3) do
			for slot12 = 1, uv0.MaxPos do
				if HeroConfig.instance:getTrial104Equip(slot12, slot8[1], slot8[2]) and slot13 > 0 then
					slot0:setListData(slot13, uv0.getTrialEquipUID(slot13, slot12, slot8[1]), nil, slot1)
				end
			end
		end
	end

	if HeroGroupModel.instance.battleConfig and slot3.trialMainAct104EuqipId > 0 then
		slot0:setListData(slot3.trialMainAct104EuqipId, uv0.getTrialEquipUID(slot3.trialMainAct104EuqipId, 1), nil, slot1)
	end

	table.sort(slot1, uv0.sortItemMOList)

	slot0._originList = slot1

	slot0:refreshMergeList()
end

function slot0.setListData(slot0, slot1, slot2, slot3, slot4)
	if not SeasonConfig.instance:getEquipIsOptional(slot1) and SeasonConfig.instance:getSeasonEquipCo(slot1) and slot0:isCardFitRole(slot5) and slot0:isCardCanShowByTag(slot2, slot5.tag) then
		slot0.equipUid2Group[slot2] = slot5.group

		if not slot3 then
			Activity104ItemMo.New():init({
				quantity = 1,
				itemId = slot1,
				uid = slot2
			})
		end

		slot6 = Activity104EquipListMo.New()

		slot6:init(slot3)
		table.insert(slot4, slot6)
	end
end

function slot0.isCardFitRole(slot0, slot1)
	if slot0.curPos == uv0.MainCharPos then
		return SeasonEquipMetaUtils.isMainRoleCard(slot1.rare)
	else
		return not SeasonEquipMetaUtils.isMainRoleCard(slot1.rare)
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

function slot0.getCurItemEquip(slot0)
	if not slot0:getGroupMO() then
		return nil
	end

	for slot6, slot7 in pairs(slot1.activity104Equips) do
		if slot7.index == slot0.curPos then
			return slot7
		end
	end
end

function slot0.getEquipMaxCount(slot0, slot1)
	return slot1 == uv0.MainCharPos and uv0.HeroMaxPos or uv0.MaxPos
end

function slot0.getPosHeroUid(slot0, slot1, slot2)
	if not slot0:getGroupMO(slot2) then
		return nil
	end

	return slot3:getHeroByIndex(slot1 + 1)
end

function slot0.slotIsLock(slot0, slot1)
	return not Activity104Model.instance:isSeasonPosUnlock(slot0.activityId, slot0.groupIndex, slot1, slot0.curPos)
end

function slot0.disableBecauseCareerNotFit(slot0, slot1)
	return slot0:isEquipCareerNoFit(slot1, slot0.curPos, slot0:getGroupMO())
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
		if SeasonEquipMetaUtils.isMainRoleCard(slot2.rare) then
			return false
		end
	elseif not slot3 then
		return false
	end

	return true
end

function slot0.isEquipCareerNoFit(slot0, slot1, slot2, slot3)
	if slot2 == uv0.MainCharPos or not slot3 then
		return false
	end

	if not SeasonConfig.instance:getSeasonEquipCo(slot1) then
		return false
	end

	slot6 = nil

	if not string.nilorempty(slot3:getHeroByIndex(slot2 + 1)) then
		slot6 = HeroModel.instance:getById(slot5)
	end

	if not slot6 then
		return false
	end

	slot7 = slot6.config.career

	if not string.nilorempty(slot4.career) then
		if CharacterEnum.CareerType.Ling == slot7 or CharacterEnum.CareerType.Zhi == slot7 then
			return slot4.career ~= Activity104Enum.CareerType.Ling_Or_Zhi
		else
			return tonumber(slot4.career) ~= slot7
		end
	end

	return false
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
	slot3 = SeasonConfig.instance:getSeasonEquipCo(slot1.itemId)

	if SeasonConfig.instance:getSeasonEquipCo(slot0.itemId) ~= nil and slot3 ~= nil then
		if uv0.instance:disableBecauseRole(slot1.itemId) ~= uv0.instance:disableBecauseRole(slot0.itemId) then
			return slot5
		end

		if slot2.rare ~= slot3.rare then
			return slot3.rare < slot2.rare
		else
			return slot3.equipId < slot2.equipId
		end
	else
		return slot0.itemUid < slot1.itemUid
	end
end

function slot0.getGroupMO(slot0, slot1)
	return HeroGroupModel.instance:getCurGroupMO()
end

function slot0.flushSlot(slot0, slot1)
	slot0:unloadItemByPos(slot0.curPos, slot1)

	if slot0.curEquipMap[slot1] ~= uv0.EmptyUid then
		slot0:unloadItem(slot2)
		slot0:equipItem(slot2, slot1)
	end
end

function slot0.resumeSlotData(slot0)
	for slot5 = 1, slot0:getEquipMaxCount(slot0.curPos) do
		slot0.curEquipMap[slot5] = slot0:getItemUidByPos(slot0.curPos, slot5)
	end
end

function slot0.flushGroup(slot0)
	return slot0:packUpdateEquips()
end

function slot0.packUpdateEquips(slot0)
	slot1 = {}

	for slot5 = 1, uv0.TotalEquipPos do
		slot7 = {
			index = slot5 - 1,
			heroUid = slot0:getPosHeroUid(slot5 - 1) or uv0.EmptyUid,
			equipUid = {}
		}

		for slot12 = 1, slot0:getEquipMaxCount(slot5 - 1) do
			slot7.equipUid[slot12] = uv0.EmptyUid
		end

		slot1[slot5] = slot7
	end

	for slot5, slot6 in pairs(slot0.equipUid2Pos) do
		if not uv0.isTrialEquip(slot5) and slot0.equipUid2Slot[slot5] then
			slot1[slot6 + 1].equipUid[slot7] = slot5
		end
	end

	return slot1
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

	for slot5 = 0, uv0.TotalEquipPos - 1 do
		for slot10 = slot0:getEquipMaxCount(slot5), 1, -1 do
			if Activity104Model.instance:isSeasonPosUnlock(slot0.activityId, slot0.groupIndex, slot10, slot5) then
				slot1 = math.max(slot1, slot10)
			end
		end
	end

	return slot1
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

function slot0.fiterFightCardDataList(slot0, slot1, slot2)
	slot3 = {}
	slot4 = {}

	if slot2 then
		slot6 = FightModel.instance:getBattleId() and lua_battle.configDict[slot5]

		for slot11, slot12 in ipairs(slot2) do
			if slot12.pos < 0 then
				slot13 = (slot6 and slot6.playerMax or ModuleEnum.HeroCountInGroup) - slot13
			end

			slot4[slot13] = slot12.trialId
		end
	end

	slot8 = slot3

	slot0:_fiterFightCardData(uv0.TotalEquipPos, slot8, slot1)

	for slot8 = 1, uv0.TotalEquipPos - 1 do
		slot0:_fiterFightCardData(slot8, slot3, slot1, slot4)
	end

	return slot3
end

function slot0._fiterFightCardData(slot0, slot1, slot2, slot3, slot4)
	slot6 = slot4 and slot4[slot1]
	slot7 = slot3 and slot3[slot1] and slot3[slot1].heroUid

	if slot1 - 1 == uv0.MainCharPos then
		slot7 = nil
	end

	if (not slot7 or slot7 == uv0.EmptyUid) and slot5 ~= uv0.MainCharPos then
		return
	end

	slot10 = 1

	for slot14 = 1, slot0:getEquipMaxCount(slot5) do
		slot16 = nil

		if slot3 and slot3[slot1] and slot3[slot1].equipUid and slot3[slot1].equipUid[slot14] then
			slot16 = Activity104Model.instance:getItemIdByUid(slot15)
		end

		if not slot16 or slot16 == 0 then
			if slot6 then
				slot16 = HeroConfig.instance:getTrial104Equip(slot14, slot6)
			elseif slot5 == uv0.MainCharPos then
				slot18 = FightModel.instance:getBattleId() and lua_battle.configDict[slot17]
				slot16 = slot18 and slot18.trialMainAct104EuqipId
			end
		end

		if slot16 and slot16 > 0 then
			table.insert(slot2, {
				equipId = slot16,
				heroUid = slot7,
				trialId = slot6,
				count = slot10 + 1
			})
		end
	end
end

slot0.instance = slot0.New()

return slot0
