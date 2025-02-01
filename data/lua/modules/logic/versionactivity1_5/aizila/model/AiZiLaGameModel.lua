module("modules.logic.versionactivity1_5.aizila.model.AiZiLaGameModel", package.seeall)

slot0 = class("AiZiLaGameModel", BaseModel)

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
	slot0._curEpisodeId = 0
	slot0._roundCount = 0
	slot0._elevation = 0
	slot0._isSafe = false
	slot0._isFirstPass = false
	slot0._curActivityId = VersionActivity1_5Enum.ActivityId.AiZiLa
	slot0._itemModel = slot0:_clearOrCreateModel(slot0._itemModel)
	slot0._resultItemModel = slot0:_clearOrCreateModel(slot0._resultItemModel)
	slot0._equipModel = slot0:_clearOrCreateModel(slot0._equipModel)
	slot0._curEpisodeMO = slot0._curEpisodeMO or AiZiLaEpsiodeMO.New()
end

function slot0._clearOrCreateModel(slot0, slot1)
	return AiZiLaHelper.clearOrCreateModel(slot1)
end

function slot0._updateMOModel(slot0, slot1, slot2, slot3, slot4)
	return AiZiLaHelper.updateMOModel(slot1, slot2, slot3, slot4)
end

function slot0._updateItemModel(slot0, slot1)
	return slot0:_updateMOModel(AiZiLaItemMO, slot0._itemModel, slot1.itemId, slot1)
end

function slot0.setEpisodeId(slot0, slot1, slot2)
	slot0._curEpisodeId = slot1
	slot0._curEpisodeMO = AiZiLaEpsiodeMO.New()

	slot0._curEpisodeMO:init(slot1)

	slot0._episodeCfg = AiZiLaConfig.instance:getEpisodeCo(VersionActivity1_5Enum.ActivityId.AiZiLa, slot1)
end

function slot0.getEpisodeId(slot0)
	return slot0._curEpisodeId
end

function slot0.getActivityID(slot0)
	return slot0._curActivityId
end

function slot0.getItemList(slot0)
	return slot0._itemModel:getList()
end

function slot0.getItemQuantity(slot0, slot1)
	return slot0._itemModel:getById(slot1) and slot2:getQuantity() or 0
end

function slot0.getResultItemList(slot0, slot1)
	return slot0._resultItemModel:getList()
end

function slot0.setIsSafe(slot0, slot1)
	slot0._isSafe = slot1
end

function slot0.getIsSafe(slot0)
	return slot0._isSafe
end

function slot0.isPass(slot0)
	return slot0._curEpisodeMO and slot0._curEpisodeMO:isPass() or false
end

function slot0.getIsFirstPass(slot0)
	return slot0._isFirstPass
end

function slot0.getEventId(slot0)
	return slot0._curEpisodeMO and slot0._curEpisodeMO.eventId or 0
end

function slot0.getBuffIdList(slot0)
	return slot0._curEpisodeMO and slot0._curEpisodeMO.buffIds
end

function slot0.getElevation(slot0)
	return slot0._curEpisodeMO and slot0._curEpisodeMO.altitude or 0
end

function slot0.getRoundCount(slot0)
	return slot0._curEpisodeMO and slot0._curEpisodeMO.day
end

function slot0.getEpisodeMO(slot0)
	return slot0._curEpisodeMO
end

function slot0.updateEpisode(slot0, slot1)
	slot0._curEpisodeMO:updateInfo(slot1)
end

function slot0.addAct144Items(slot0, slot1)
	slot0:_addModelAct144Items(slot0._itemModel, slot1)
end

function slot0.setAct144Items(slot0, slot1)
	slot0._itemModel = slot0:_clearOrCreateModel(slot0._itemModel)

	slot0:_addModelAct144Items(slot0._itemModel, slot1)
end

function slot0._addModelAct144Items(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot2) do
		if slot1:getById(slot7.itemId) then
			slot8:addInfo(slot7)
		else
			slot8 = AiZiLaItemMO.New()

			slot8:init(slot7.itemId, slot7.itemId, slot7.quantity)
			slot1:addAtLast(slot8)
		end
	end
end

function slot0.setAct144ResultItems(slot0, slot1)
	slot0._resultItemModel = slot0:_clearOrCreateModel(slot0._resultItemModel)

	slot0:_addModelAct144Items(slot0._resultItemModel, slot1)
end

function slot0.settlePush(slot0, slot1)
	slot0._isSafe = slot1.isSafe
	slot0._isFirstPass = slot1.isFirstPass

	slot0:setAct144ResultItems(slot1.tempAct144Items or {})
	slot0:updateEpisode(slot1)
end

function slot0.settleEpisodeReply(slot0, slot1)
	slot0:setAct144ResultItems(slot1.act144Episode and slot2.tempAct144Items or {})
	slot0:updateEpisode(slot2)
end

slot0.instance = slot0.New()

return slot0
