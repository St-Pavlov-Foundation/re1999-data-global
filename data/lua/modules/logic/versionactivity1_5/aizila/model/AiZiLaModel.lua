module("modules.logic.versionactivity1_5.aizila.model.AiZiLaModel", package.seeall)

slot0 = class("AiZiLaModel", BaseModel)

function slot0.onInit(slot0)
	slot0._epsiodeItemModelDict = {}

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
	slot0._curEpisodeId = 0
	slot0._curActivityId = VersionActivity1_5Enum.ActivityId.AiZiLa
	slot0._unlockEventIds = {}
	slot0._optionEventIds = {}
	slot0._selectEventIds = {}
	slot0._collectItemIds = {}

	slot0:_clearModel()
end

function slot0._clearModel(slot0)
	slot0._itemModel = slot0:_clearOrCreateModel(slot0._itemModel)
	slot0._equipModel = slot0:_clearOrCreateModel(slot0._equipModel)
	slot0._episodeModel = slot0:_clearOrCreateModel(slot0._episodeModel)
	slot0._epsiodeItemModelDict = slot0._epsiodeItemModelDict or {}

	for slot4, slot5 in pairs(slot0._epsiodeItemModelDict) do
		slot5:clear()
	end
end

function slot0._clearOrCreateModel(slot0, slot1)
	return AiZiLaHelper.clearOrCreateModel(slot1)
end

function slot0.setCurEpisodeId(slot0, slot1)
	slot0._curEpisodeId = slot1
end

function slot0.getCurEpisodeId(slot0)
	return slot0._curEpisodeId
end

function slot0.getCurActivityID(slot0)
	return slot0._curActivityId
end

function slot0.isEpisodeClear(slot0, slot1)
	return false
end

function slot0.isEpisodeLock(slot0, slot1)
	return slot0:getEpisodeMO(slot1) == nil
end

function slot0.getEquipMO(slot0, slot1)
	return slot0._equipModel:getById(slot1)
end

function slot0.getEquipMOList(slot0)
	return slot0._equipModel:getList()
end

function slot0.getEpisodeMO(slot0, slot1)
	return slot0._episodeModel:getById(slot1)
end

function slot0.getRecordMOList(slot0)
	if not slot0._recordMOList then
		slot0._recordMOList = {}

		for slot5, slot6 in ipairs(AiZiLaConfig.instance:getRecordEventList(VersionActivity1_5Enum.ActivityId.AiZiLa) or {}) do
			slot7 = AiZiLaRecordMO.New()

			slot7:init(slot6)
			table.insert(slot0._recordMOList, slot7)
		end
	end

	return slot0._recordMOList
end

function slot0.getHandbookMOList(slot0)
	if not slot0._handbookMOList then
		slot0._handbookMOList = {}

		for slot5, slot6 in ipairs(AiZiLaConfig.instance:getItemList() or {}) do
			slot7 = AiZiLaHandbookMO.New()

			slot7:init(slot6.id)
			table.insert(slot0._handbookMOList, slot7)
		end
	end

	return slot0._handbookMOList
end

function slot0._updateIdDict(slot0, slot1, slot2)
	if slot2 and #slot2 > 0 then
		for slot6, slot7 in ipairs(slot2) do
			if slot1[slot7] == nil then
				slot1[slot7] = true
			end
		end
	end
end

function slot0._isHasIdDict(slot0, slot1, slot2)
	if slot1[slot2] then
		return true
	end

	return false
end

function slot0._updateMOModel(slot0, slot1, slot2, slot3, slot4)
	return AiZiLaHelper.updateMOModel(slot1, slot2, slot3, slot4)
end

function slot0._updateEpsiodeModel(slot0, slot1)
	slot0:_updateMOModel(AiZiLaEpsiodeMO, slot0._episodeModel, slot1.episodeId, slot1)
end

function slot0._updateItemModel(slot0, slot1)
	return slot0:_updateMOModel(AiZiLaItemMO, slot0._itemModel, slot1.uid, slot1)
end

function slot0._updateEquipModel(slot0, slot1)
	if not AiZiLaConfig.instance:getEquipCo(VersionActivity1_5Enum.ActivityId.AiZiLa, slot1) then
		logError(string.format("[144_爱兹拉角色活动 export_装备] 找不到装备 id:%s", slot1))

		return slot0._equipModel
	end

	slot0:_checkEquipUpLevelRed()

	return slot0:_updateMOModel(AiZiLaEquipMO, slot0._equipModel, slot2.typeId, slot1)
end

function slot0.getItemQuantity(slot0, slot1)
	for slot7, slot8 in ipairs(slot0._itemModel:getList()) do
		if slot8.itemId == slot1 then
			slot3 = 0 + slot8.quantity
		end
	end

	return slot3
end

function slot0.isSelectOptionId(slot0, slot1)
	return slot0:_isHasIdDict(slot0._optionEventIds, slot1)
end

function slot0.isSelectEventId(slot0, slot1)
	return slot0:_isHasIdDict(slot0._selectEventIds, slot1)
end

function slot0.isUnlockEventId(slot0, slot1)
	return slot0:_isHasIdDict(slot0._unlockEventIds, slot1)
end

function slot0.isCollectItemId(slot0, slot1)
	return slot0:_isHasIdDict(slot0._collectItemIds, slot1)
end

function slot0.getInfosReply(slot0, slot1)
	slot0:_clearData()

	for slot7, slot8 in ipairs(slot1.Act144InfoNO.act144Episodes or {}) do
		slot0:_updateEpsiodeModel(slot8)
	end

	for slot8, slot9 in ipairs(slot2.act144Items or {}) do
		slot0:_updateItemModel(slot9)
	end

	for slot9, slot10 in ipairs(slot2.equipIds or {}) do
		slot0:_updateEquipModel(slot10)
	end

	slot0:_updateIdDict(slot0._optionEventIds, slot2.optionIds)
	slot0:_updateIdDict(slot0._unlockEventIds, slot2.unlockEventIds)
	slot0:_updateIdDict(slot0._selectEventIds, slot2.selectEventIds)
	slot0:_updateIdDict(slot0._collectItemIds, slot2.collectItemIds)
	slot0:checkItemRed()
	slot0:checkRecordRed()
end

function slot0.enterEpisodeReply(slot0, slot1)
end

function slot0.selectOptionReply(slot0, slot1)
	slot0:_updateIdDict(slot0._optionEventIds, slot1.optionIds)
	slot0:_updateIdDict(slot0._unlockEventIds, slot1.unlockEventIds)
	slot0:_updateIdDict(slot0._selectEventIds, slot1.selectEventIds)
	slot0:checkRecordRed()
end

function slot0.settleEpisodeReply(slot0, slot1)
end

function slot0.settlePush(slot0, slot1)
	slot0:_updateIdDict(slot0._collectItemIds, slot1.collectItemIds)
	slot0:checkItemRed()
end

function slot0.nextDayReply(slot0, slot1)
end

function slot0.upgradeEquipReply(slot0, slot1)
	slot0:_updateEquipModel(slot1.newEquipId)
end

function slot0.episodePush(slot0, slot1)
	slot0:_updateEpsiodeModel(slot1.act144Episode)
end

function slot0.itemChangePush(slot0, slot1)
	for slot6, slot7 in ipairs(slot1.deleteAct144Items or {}) do
		slot0._itemModel:remove(slot0._itemModel:getById(slot7.uid))
	end

	for slot7, slot8 in ipairs(slot1.updateAct144Items or {}) do
		slot0:_updateItemModel(slot8)
	end

	slot0:_checkEquipUpLevelRed()
end

function slot0.isHasEquipUpLevel(slot0)
	for slot5, slot6 in ipairs(slot0._equipModel:getList()) do
		if slot6:isCanUpLevel() then
			return true
		end
	end

	return false
end

function slot0._checkEquipUpLevelRed(slot0)
	table.insert({}, {
		id = RedDotEnum.DotNode.V1a5AiZiLaEquip,
		value = slot0:isHasEquipUpLevel() and 1 or 0
	})
	RedDotRpc.instance:clientAddRedDotGroupList(slot1, true)
end

function slot0.checkItemRed(slot0)
	slot1 = {}

	slot0:_addRedMOList(RedDotEnum.DotNode.V1a5AiZiLaHandbookNew, slot0:getHandbookMOList(), RedDotEnum.DotNode.V1a5AiZiLaHandbook, slot1)
	RedDotRpc.instance:clientAddRedDotGroupList(slot1, true)
end

function slot0.finishItemRed(slot0)
	for slot5, slot6 in ipairs(slot0:getHandbookMOList()) do
		if slot6:isHasRed() then
			slot6:finishRed()
		end
	end

	slot0:checkItemRed()
end

function slot0.checkRecordRed(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(slot0:getRecordMOList()) do
		slot0:_addRedMOList(RedDotEnum.DotNode.V1a5AiZiLaRecordEventNew, slot7:getEventMOList(), nil, slot1)
	end

	slot0:_addRedMOList(RedDotEnum.DotNode.V1a5AiZiLaRecordNew, slot2, RedDotEnum.DotNode.V1a5AiZiLaRecord, slot1)
	RedDotRpc.instance:clientAddRedDotGroupList(slot1, true)
end

function slot0._addRedMOList(slot0, slot1, slot2, slot3, slot4)
	slot5 = slot4 or {}
	slot6 = false

	for slot10, slot11 in ipairs(slot2) do
		slot13 = slot11:getRedUid()

		if slot11:isHasRed() then
			slot6 = true
		end

		table.insert(slot5, {
			id = slot1,
			uid = slot13,
			value = slot12 and 1 or 0
		})
	end

	if slot3 then
		table.insert(slot5, {
			id = slot3,
			value = slot6 and 1 or 0
		})
	end

	return slot5
end

slot0.instance = slot0.New()

return slot0
