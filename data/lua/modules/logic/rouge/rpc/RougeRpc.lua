module("modules.logic.rouge.rpc.RougeRpc", package.seeall)

slot0 = class("RougeRpc", BaseRpc)

function slot0.sendGetRougeInfoRequest(slot0, slot1, slot2, slot3)
	slot4 = RougeModule_pb.GetRougeInfoRequest()
	slot4.season = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGetRougeInfoReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RougeModel.instance:updateRougeInfo(slot2.rougeInfo)
	RougeModel.instance:setTeamInitHeros(slot2.initHeroIds)
end

function slot0.onReceiveRougeInfoPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RougeModel.instance:updateRougeInfo(slot2.rougeInfo)
end

function slot0.sendEnterRougeSelectDifficultyRequest(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	RougeModule_pb.EnterRougeSelectDifficultyRequest().season = slot1

	for slot11, slot12 in ipairs(slot2) do
		slot7.version:append(slot12)
	end

	slot7.difficulty = slot3

	if slot4 then
		for slot12, slot13 in ipairs(slot4:getLimitIds()) do
			slot7.limiterNO.limitIds:append(slot13)
		end

		for slot13, slot14 in ipairs(slot4:getLimitBuffIds()) do
			slot7.limiterNO.limitBuffIds:append(slot14)
		end
	end

	return slot0:sendMsg(slot7, slot5, slot6)
end

function slot0.onReceiveEnterRougeSelectDifficultyReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.season

	RougeModel.instance:updateRougeInfo(slot2.rougeInfo)
end

function slot0.sendEnterRougeSelectRewardRequest(slot0, slot1, slot2, slot3, slot4)
	RougeModule_pb.EnterRougeSelectRewardRequest().season = slot1

	for slot9, slot10 in ipairs(slot2) do
		slot5.rewardId:append(slot10)
	end

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveEnterRougeSelectRewardReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.season

	RougeModel.instance:updateRougeInfo(slot2.rougeInfo)
end

function slot0.sendEnterRougeSelectStyleRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = RougeModule_pb.EnterRougeSelectStyleRequest()
	slot5.season = slot1
	slot5.style = slot2

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveEnterRougeSelectStyleReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.season

	RougeModel.instance:updateRougeInfo(slot2.rougeInfo)
end

function slot0.sendEnterRougeSelectHeroesRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	RougeModule_pb.EnterRougeSelectHeroesRequest().season = slot1

	for slot10, slot11 in ipairs(slot2) do
		slot6.heroesList:append(slot11)
	end

	if slot3 then
		slot6.assistHeroUid = slot3
	end

	return slot0:sendMsg(slot6, slot4, slot5)
end

function slot0.onReceiveEnterRougeSelectHeroesReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.season

	RougeModel.instance:updateRougeInfo(slot2.rougeInfo)
end

function slot0.sendRougeGroupChangeRequest(slot0, slot1, slot2, slot3, slot4)
	RougeModule_pb.RougeGroupChangeRequest().season = slot1

	for slot9, slot10 in ipairs(slot2) do
		slot11 = slot5.battleHeroList:add()
		slot11.index = slot10.index
		slot11.heroId = slot10.heroId
		slot11.equipUid = slot10.equipUid
		slot11.supportHeroId = slot10.supportHeroId
		slot11.supportHeroSkill = slot10.supportHeroSkill
	end

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveRougeGroupChangeReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RougeModel.instance:updateTeamInfo(slot2.teamInfo)
end

function slot0.sendRougeRoundMoveRequest(slot0, slot1)
	slot2 = RougeModule_pb.RougeRoundMoveRequest()
	slot2.season = RougeModel.instance:getSeason() or 1
	slot2.layer = RougeMapModel.instance:getLayerId()
	slot2.nodeId = slot1

	return slot0:sendMsg(slot2)
end

function slot0.onReceiveRougeRoundMoveReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RougeMapModel.instance:updateMapInfo(slot2.map)

	if not RougeMapModel.instance:needPlayMoveToEndAnim() then
		RougeMapController.instance:startMove()
	end
end

function slot0.sendRougeChoiceEventRequest(slot0, slot1, slot2, slot3)
	slot4 = RougeModule_pb.RougeChoiceEventRequest()
	slot4.season = RougeModel.instance:getSeason() or 1
	slot4.layer = RougeMapModel.instance:getLayerId()
	slot5 = RougeMapModel.instance:getCurNode()
	slot4.nodeId = slot5.nodeId
	slot4.eventId = slot5.eventId
	slot4.choiceId = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveRougeChoiceEventReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RougeMapModel.instance:updateMapInfo(slot2.map)
	RougeStatController.instance:statRougeChoiceEvent()
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onReceiveChoiceEvent)
end

function slot0.sendRougeSelectDropRequest(slot0, slot1, slot2, slot3)
	RougeModule_pb.RougeSelectDropRequest().season = RougeModel.instance:getSeason() or 1

	for slot8, slot9 in ipairs(slot1) do
		slot4.collectionPos:append(slot9 - 1)
	end

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveRougeSelectDropReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RougeMapModel.instance:updateMapInfo(slot2.map)
end

function slot0.sendRougeSelectLostCollectionRequest(slot0, slot1, slot2, slot3)
	RougeModule_pb.RougeSelectLostCollectionRequest().season = RougeModel.instance:getSeason() or 1

	for slot8, slot9 in ipairs(slot1) do
		slot4.collectionUid:append(slot9.uid)
	end

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveRougeSelectLostCollectionReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RougeMapModel.instance:updateMapInfo(slot2.map)
end

function slot0.sendRougeSelectHealRequest(slot0, slot1, slot2, slot3)
	RougeModule_pb.RougeSelectHealRequest().season = RougeModel.instance:getSeason() or 1

	for slot8, slot9 in ipairs(slot1) do
		slot4.heroIds:append(slot9)
	end

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveRougeSelectHealReply(slot0, slot1, slot2)
end

function slot0.sendRougeSelectReviveRequest(slot0, slot1, slot2, slot3)
	RougeModule_pb.RougeSelectReviveRequest().season = RougeModel.instance:getSeason() or 1

	for slot8, slot9 in ipairs(slot1) do
		slot4.heroIds:append(slot9)
	end

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveRougeSelectReviveReply(slot0, slot1, slot2)
end

function slot0.sendRougePieceMoveRequest(slot0, slot1, slot2, slot3)
	slot4 = RougeModule_pb.RougePieceMoveRequest()
	slot4.season = RougeModel.instance:getSeason() or 1
	slot4.layer = RougeMapModel.instance:getLayerId()
	slot4.middleLayer = RougeMapModel.instance:getMiddleLayerId()
	slot4.index = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveRougePieceMoveReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RougeMapModel.instance:updateMapInfo(slot2.map)
end

function slot0.sendRougePieceTalkSelectRequest(slot0, slot1, slot2, slot3)
	slot4 = RougeModule_pb.RougePieceTalkSelectRequest()
	slot4.season = RougeModel.instance:getSeason() or 1
	slot4.layer = RougeMapModel.instance:getLayerId()
	slot4.middleLayer = RougeMapModel.instance:getMiddleLayerId()
	slot4.index = RougeMapModel.instance:getCurPosIndex()
	slot4.select = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveRougePieceTalkSelectReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RougeMapModel.instance:updateMapInfo(slot2.map)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onReceivePieceChoiceEvent)
end

function slot0.sendRougeLeaveMiddleLayerRequest(slot0, slot1)
	slot2 = RougeModule_pb.RougeLeaveMiddleLayerRequest()
	slot2.season = RougeModel.instance:getSeason() or 1
	slot2.layer = RougeMapModel.instance:getLayerId()
	slot2.middleLayer = RougeMapModel.instance:getMiddleLayerId()
	slot2.nextLayer = slot1

	RougeMapModel.instance:setWaitLeaveMiddleLayerReply(true)

	return slot0:sendMsg(slot2)
end

function slot0.onReceiveRougeLeaveMiddleLayerReply(slot0, slot1, slot2)
	RougeMapModel.instance:setWaitLeaveMiddleLayerReply(nil)

	if slot1 ~= 0 then
		return
	end

	RougeMapModel.instance:updateMapInfo(slot2.createEventMap)
	RougeMapModel.instance:setFinalMapInfo(slot2.finalMap)
	ViewMgr.instance:openView(ViewName.RougeNextLayerView, RougeMapModel.instance:getLayerId())
end

function slot0.sendRougeBuyGoodsRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = RougeModule_pb.RougeBuyGoodsRequest()
	slot5.season = RougeModel.instance:getSeason() or 1
	slot5.layer = RougeMapModel.instance:getLayerId()
	slot5.nodeId = RougeMapModel.instance:getCurNode().nodeId
	slot5.eventId = slot1

	slot5.goodsPos:append(slot2)

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveRougeBuyGoodsReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RougeMapModel.instance:updateMapInfo(slot2.map)
end

function slot0.sendRougeEndShopEventRequest(slot0, slot1, slot2, slot3)
	if not RougeMapModel.instance:getCurNode() then
		if slot2 then
			slot2(slot3)
		end

		return
	end

	slot5 = RougeModule_pb.RougeEndShopEventRequest()
	slot5.season = RougeModel.instance:getSeason() or 1
	slot5.layer = RougeMapModel.instance:getLayerId()
	slot5.nodeId = slot4.nodeId
	slot5.eventId = slot1

	return slot0:sendMsg(slot5, slot2, slot3)
end

function slot0.onReceiveRougeEndShopEventReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RougeMapModel.instance:updateMapInfo(slot2.map)
end

function slot0.sendRougeShopRefreshRequest(slot0, slot1, slot2, slot3)
	slot4 = RougeModule_pb.RougeShopRefreshRequest()
	slot4.season = RougeModel.instance:getSeason() or 1
	slot4.layer = RougeMapModel.instance:getLayerId()
	slot4.nodeId = RougeMapModel.instance:getCurNode().nodeId
	slot4.eventId = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveRougeShopRefreshReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RougeMapModel.instance:updateMapInfo(slot2.map)
end

function slot0.onReceiveRougeInMapItemUpdatePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RougePopController.instance:addPopViewWithViewName(ViewName.RougeCollectionDropView, {
		collectionList = slot2.collectionId,
		viewEnum = RougeMapEnum.CollectionDropViewEnum.OnlyShow
	})
end

function slot0.onReceiveRougeLayerMapInfoPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RougeMapModel.instance:updateMapInfo(slot2.map)
end

function slot0.onReceiveRougeLayerSimpleMapInfoPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RougeMapModel.instance:updateSimpleMapInfo(slot2.map)
end

function slot0.sendRougeRecruitHeroRequest(slot0, slot1)
	RougeModule_pb.RougeRecruitHeroRequest().season = RougeModel.instance:getSeason() or 1

	if slot1 then
		for slot6, slot7 in ipairs(slot1) do
			slot2.heroIds:append(slot7)
		end
	end

	return slot0:sendMsg(slot2)
end

function slot0.onReceiveRougeRecruitHeroReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RougeModel.instance:updateTeamLife(slot2.teamInfo.heroLifeList)
	RougeModel.instance:updateExtraHeroInfo(slot2.teamInfo.heroInfoList)
end

function slot0.onReceiveRougeFightResultPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RougeModel.instance:updateFightResultMo(slot2)
end

function slot0.onReceiveRougeInteractiveTeamHpUpdatePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RougeModel.instance:updateTeamLifeAndDispatchEvent(slot2.heroLifeList)
	RougeMapTipPopController.instance:addPopTipByInteractId(slot2.interactiveId)
end

function slot0.onReceiveRougeEntrustInfoPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RougeMapModel.instance:updateEntrustInfo(slot2.entrustInfo)
end

function slot0.sendRougeInlayRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = RougeModule_pb.RougeInlayRequest()
	slot6.season = RougeModel.instance:getSeason()
	slot6.targetId = slot1
	slot6.holdId = slot3 - 1
	slot6.consumeId = slot2

	return slot0:sendMsg(slot6, slot4, slot5)
end

function slot0.onReceiveRougeInlayReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.season

	RougeCollectionModel.instance:rougeInlay(slot2.item, slot2.preItem, slot2.reason)
	RougeController.instance:dispatchEvent(RougeEvent.AdjustBackPack)
end

function slot0.sendRougeDemountRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = RougeModule_pb.RougeDemountRequest()
	slot5.season = RougeModel.instance:getSeason()
	slot5.targetId = slot1
	slot5.holdId = slot2 - 1

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveRougeDemountReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.season

	RougeCollectionModel.instance:rougeDemount(slot2.item, slot2.reason)
	RougeController.instance:dispatchEvent(RougeEvent.AdjustBackPack)
end

function slot0.sendRougeAddToBarRequest(slot0, slot1, slot2, slot3)
	slot4 = RougeModule_pb.RougeAddToBarRequest()
	slot4.season = RougeModel.instance:getSeason() or 1
	slot4.targetId = slot1
	slot4.rotation = slot3
	slot4.pos.row = slot2.y
	slot4.pos.col = slot2.x

	slot0:sendMsg(slot4)
end

function slot0.onReceiveRougeAddToBarReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end
end

function slot0.sendRougeRemoveFromBarRequest(slot0, slot1)
	slot2 = RougeModule_pb.RougeRemoveFromBarRequest()
	slot2.season = RougeModel.instance:getSeason()
	slot2.id = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveRougeRemoveFromBarReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RougeController.instance:dispatchEvent(RougeEvent.AdjustBackPack)
end

function slot0.onReceiveRougeAddItemWarehousePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.season

	RougeCollectionModel.instance:onReceiveNewInfo2Bag(slot2.items, slot2.reason)
end

function slot0.onReceiveRougeRemoveItemWarehousePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RougeCollectionModel.instance:deleteSomeCollectionFromWarehouse(slot2.ids)
end

function slot0.onReceiveRougeItemBagPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.season

	RougeCollectionModel.instance:onReceiveNewInfo2Slot(slot2.bag)
end

function slot0.onReceiveRougeItemWarehousePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RougeCollectionModel.instance:onReceiveNewInfo2Bag(slot2.bag)
end

function slot0.onReceiveRougeAddItemBagPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RougeCollectionModel.instance:onReceiveNewInfo2Slot(slot2.layouts, slot2.reason)
end

function slot0.onReceiveRougeRemoveItemBagPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.season

	RougeCollectionModel.instance:deleteSomeCollectionFromSlot(slot2.ids)
end

function slot0.onReceiveRougeItemUpdatePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.season

	RougeCollectionModel.instance:updateCollectionItems(slot2.items)
end

function slot0.sendRougeOneKeyAddToBarRequest(slot0, slot1)
	slot2 = RougeModule_pb.RougeOneKeyAddToBarRequest()
	slot2.season = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveRougeOneKeyAddToBarReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RougeStatController.instance:operateCollection(RougeStatController.operateType.Auto)
	RougeController.instance:dispatchEvent(RougeEvent.AdjustBackPack)
end

function slot0.sendRougeOneKeyRemoveFromBarRequest(slot0, slot1)
	slot2 = RougeModule_pb.RougeOneKeyRemoveFromBarRequest()
	slot2.season = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveRougeItemLayoutEffectUpdatePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = {}

	for slot7, slot8 in ipairs(slot2.updates) do
		slot10 = slot8.baseEffects
		slot11 = slot8.relations
		slot12 = slot8.attr

		if not RougeCollectionModel.instance:getCollectionByUid(tonumber(slot8.id)) then
			return
		end

		if not RougeCollectionModel.instance:isCollectionPlaceInSlotArea(slot9) then
			return
		end

		slot13:updateBaseEffects(slot10)
		slot13:updateEffectRelations(slot11)
		slot13:updateAttrValues(slot12)
		table.insert(slot3, slot13)
	end

	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.UpdateSlotCollectionEffect, slot3)
end

function slot0.onReceiveRougeItemEffectChangeItemPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	if not slot0:_checkIsTriggerEffectChangeItem(slot2) then
		return
	end

	slot4 = RougeCollectionHelper.buildNewCollectionSlotMO(slot2.trigger)
	slot5 = RougeCollectionHelper.buildCollectionSlotMOs(slot2.rmLayouts)
	slot6 = {}
	slot7 = {}
	slot8 = tonumber(slot2.showType)

	if slot2.addToBag then
		for slot12, slot13 in ipairs(slot2.addToBag) do
			table.insert(slot6, tonumber(slot13))
		end
	end

	if slot2.addToWarehouse then
		for slot12, slot13 in ipairs(slot2.addToWarehouse) do
			table.insert(slot7, tonumber(slot13))
		end
	end

	RougeCollectionModel.instance:saveTmpCollectionTriggerEffectInfo(slot4, slot5, slot6, slot7, slot8)
end

function slot0._checkIsTriggerEffectChangeItem(slot0, slot1)
	if not slot1 then
		return false
	end

	slot3 = slot1.rmLayouts

	if slot1.showType == RougeEnum.EffectTriggerType.Engulf or slot2 == RougeEnum.EffectTriggerType.LevelUp then
		return slot3 and #slot3 > 0
	end

	return true
end

function slot0.onReceiveRougeOneKeyRemoveFromBarReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RougeCollectionModel.instance:onKeyClearSlotArea()
	RougeStatController.instance:operateCollection(RougeStatController.operateType.Clear)
	RougeController.instance:dispatchEvent(RougeEvent.AdjustBackPack)
end

function slot0.sendRougeComposeRequest(slot0, slot1, slot2, slot3)
	slot4 = RougeModule_pb.RougeComposeRequest()
	slot4.season = slot1
	slot4.composeId = slot2

	if slot3 then
		for slot8, slot9 in ipairs(slot3) do
			slot4.consumeIds:append(slot9)
		end
	end

	slot0:sendMsg(slot4)
end

function slot0.onReceiveRougeComposeReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.season
	slot4 = slot2.item
	slot5 = slot2.composeId

	RougeController.instance:dispatchEvent(RougeEvent.CompositeCollectionSucc)
end

function slot0.onReceiveRougeUpdateCoinPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RougeModel.instance:getRougeInfo().coin = slot2.coin

	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateRougeInfoCoin)
end

function slot0.onReceiveRougeUpdatePowerPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RougeModel.instance:updatePower(slot2.power, slot2.powerLimit)
end

function slot0.onReceiveRougeUpdateTalentPointPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RougeModel.instance:getRougeInfo().talentPoint = slot2.talentPoint

	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateRougeInfoTalentPoint)
end

function slot0.onReceiveRougeUpdateTeamExpAndLevelPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.teamLevel
	slot6 = RougeModel.instance:getRougeInfo()
	slot6.teamLevel = slot3
	slot6.teamExp = slot2.teamExp
	slot6.teamSize = slot2.teamSize

	if slot6.teamLevel ~= slot3 and slot7 > 0 then
		RougePopController.instance:addPopViewWithViewName(ViewName.RougeLevelUpView, {
			preLv = slot7,
			curLv = slot3,
			preTeamSize = slot6.teamSize,
			curTeamSize = slot5
		})
	end

	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateRougeInfoTeamValues)
end

function slot0.sendRougeAbortRequest(slot0, slot1, slot2, slot3)
	slot4 = RougeModule_pb.RougeAbortRequest()
	slot4.season = slot1 or RougeOutsideModel.instance:season()

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveRougeAbortReply(slot0, slot1, slot2)
	if RougeModel.instance:getState() < RougeEnum.State.Start then
		RougeOutsideRpc.instance:sendGetRougeOutSideInfoRequest(RougeOutsideModel.instance:season())
		RougeModel.instance:clear()

		return
	end

	if slot1 ~= 0 then
		return
	end

	RougeModel.instance:updateRougeInfo(slot2.rougeInfo)
	RougeModel.instance:onAbortRouge()
end

function slot0.sendRougeEndRequest(slot0, slot1, slot2)
	slot3 = RougeModule_pb.RougeEndRequest()
	slot3.season = RougeModel.instance:getSeason() or 1

	return slot0:sendMsg(slot3, slot1, slot2)
end

function slot0.onReceiveRougeEndReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RougeOutsideRpc.instance:sendGetRougeOutSideInfoRequest(RougeOutsideModel.instance:season())
	RougeModel.instance:updateRougeInfo(slot2.rougeInfo)
	RougeModel.instance:updateResultInfo(slot2.resultInfo)

	if not RougeStatController.instance:checkIsReset() then
		RougeStatController.instance:statEnd()
	else
		RougeStatController.instance:statEnd(RougeStatController.EndResult.Abort)
	end
end

function slot0.sendActiveTalentRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = RougeModule_pb.ActiveTalentRequest()
	slot5.season = slot1
	slot5.index = slot2

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveActiveTalentReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RougeModel.instance:updateTalentInfo(slot2.rougeTalentTree.rougeTalent)
end

function slot0.onReceiveRougeTeamHpUpdatePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RougeModel.instance:updateTeamLifeAndDispatchEvent(slot2.heroLifeList)
end

function slot0.sendRougeRepairShopBuyRequest(slot0, slot1, slot2, slot3)
	slot4 = RougeModule_pb.RougeRepairShopBuyRequest()
	slot4.season = RougeModel.instance:getSeason() or 1
	slot4.collectionId = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveRougeRepairShopBuyReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	if RougeMapModel.instance:getPieceMo(slot2.pieceInfo.index) then
		slot4:update(slot3)
	end
end

function slot0.sendRougeRepairShopRandomRequest(slot0, slot1, slot2)
	slot3 = RougeModule_pb.RougeRepairShopRandomRequest()
	slot3.season = RougeModel.instance:getSeason() or 1

	return slot0:sendMsg(slot3, slot1, slot2)
end

function slot0.onReceiveRougeRepairShopRandomReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	if RougeMapModel.instance:getPieceMo(slot2.pieceInfo.index) then
		slot4:update(slot3)
	end
end

function slot0.sendRougeDisplaceRequest(slot0, slot1, slot2, slot3)
	slot4 = RougeModule_pb.RougeDisplaceRequest()
	slot4.season = RougeModel.instance:getSeason() or 1
	slot4.collectionId = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveRougeDisplaceReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	if RougeMapModel.instance:getPieceMo(slot2.pieceInfo.index) then
		slot4:update(slot3)
	end
end

function slot0.onReceiveRougeTriggerEffectPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RougeMapTipPopController.instance:addPopTipByEffect(slot2.effect)
end

function slot0.sendRougeRandomDropRequest(slot0, slot1, slot2)
	slot3 = RougeModule_pb.RougeRandomDropRequest()
	slot3.season = RougeModel.instance:getSeason() or 1

	return slot0:sendMsg(slot3, slot1, slot2)
end

function slot0.onReceiveRougeRandomDropReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RougeMapModel.instance:updateMapInfo(slot2.map)
end

function slot0.sendRougeMonsterFixAttrRequest(slot0, slot1, slot2, slot3)
	slot4 = RougeModule_pb.RougeMonsterFixAttrRequest()
	slot4.season = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveRougeMonsterFixAttrReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.season
	slot4 = slot2.fixHpRate
end

function slot0.onReceiveRougeTeamInfoPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RougeModel.instance:updateTeamInfo(slot2.teamInfo)
end

function slot0.sendRougeUseMapSkillRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = RougeModule_pb.RougeUseMapSkillRequest()
	slot5.season = slot1
	slot5.mapSkillId = slot2

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveRougeUseMapSkillReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.season
	slot4 = slot2.mapSkill

	RougeMapModel.instance:onUpdateMapSkillInfo(slot4)
	RougeStatController.instance:trackUseMapSkill(slot4.id)
end

function slot0.sendRougeUnlockSkillRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = RougeModule_pb.RougeUnlockSkillRequest()
	slot5.season = slot1
	slot5.skillId = slot2

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveRougeUnlockSkillReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.season
	slot4 = slot2.skillId
end

function slot0.sendRougeItemTrammelsRequest(slot0, slot1, slot2, slot3)
	slot4 = RougeModule_pb.RougeItemTrammelsRequest()
	slot4.season = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveRougeItemTrammelsReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end
end

function slot0.sendRougeSelectCollectionLevelUpRequest(slot0, slot1, slot2, slot3, slot4)
	RougeModule_pb.RougeSelectCollectionLevelUpRequest().season = slot1

	if slot2 then
		for slot9, slot10 in ipairs(slot2) do
			slot5.collectionUid:append(slot10)
		end
	end

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveRougeSelectCollectionLevelUpReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RougeMapModel.instance:updateMapInfo(slot2.map)
end

slot0.instance = slot0.New()

return slot0
