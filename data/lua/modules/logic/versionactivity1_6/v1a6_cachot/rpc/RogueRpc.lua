module("modules.logic.versionactivity1_6.v1a6_cachot.rpc.RogueRpc", package.seeall)

slot0 = class("RogueRpc", BaseRpc)

function slot0.sendGetRogueStateRequest(slot0)
	slot0:sendMsg(RogueModule_pb.GetRogueStateRequest())
end

function slot0.onReceiveGetRogueStateReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	V1a6_CachotModel.instance:updateRogueStateInfo(slot2.state)
	V1a6_CachotProgressListModel.instance:initDatas()
end

function slot0.sendGetRogueInfoRequest(slot0, slot1)
	slot2 = RogueModule_pb.GetRogueInfoRequest()
	slot2.activityId = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveGetRogueInfoReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.info

	V1a6_CachotModel.instance:updateRogueInfo(slot3)
	V1a6_CachotRoomModel.instance:setLayerAndRoom(slot3.layer, slot3.room)
	V1a6_CachotController.instance:enterMap(false)
end

function slot0.sendGetRogueScoreRewardRequest(slot0, slot1, slot2)
	RogueModule_pb.GetRogueScoreRewardRequest().activityId = slot1

	for slot7, slot8 in ipairs(slot2) do
		slot3.rewards:append(slot8)
	end

	slot0:sendMsg(slot3)
end

function slot0.onReceiveGetRogueScoreRewardReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end
end

function slot0.sendAbortRogueRequest(slot0, slot1)
	slot2 = RogueModule_pb.AbortRogueRequest()
	slot2.activityId = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveAbortRogueReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot4 = slot2.score

	V1a6_CachotModel.instance:clearRogueInfo()
	V1a6_CachotModel.instance:updateRogueStateInfo(slot2.state)

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		return
	end

	if V1a6_CachotModel.instance:getRogueEndingInfo() then
		V1a6_CachotController.instance:openV1a6_CachotFinishView()
	end
end

function slot0._packGroup(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot1.id = slot2
	slot1.name = slot5 or ""
	slot1.clothId = slot6 or 0

	if slot3 then
		for slot10, slot11 in ipairs(slot3) do
			table.insert(slot1.heroList, slot11)
		end
	end

	if slot4 then
		for slot10, slot11 in ipairs(slot4) do
			HeroDef_pb.HeroGroupEquip().index = slot10 - 1

			for slot16, slot17 in ipairs(slot11.equipUid) do
				table.insert(slot12.equipUid, slot17)
			end

			table.insert(slot1.equips, slot12)
		end
	end
end

function slot0.sendEnterRogueRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = RogueModule_pb.EnterRogueRequest()
	slot6.activityId = slot1
	slot6.difficulty = slot2

	slot0:_packGroup(slot6.group, slot3.id, slot3.heroList, slot3.equips, slot3.groupName, slot3.clothId)

	slot10 = slot6.backupGroup
	slot11 = slot4.id

	slot0:_packGroup(slot10, slot11, slot4.heroList, slot4.equips, slot4.groupName, slot3.clothId)

	for slot10, slot11 in ipairs(slot5) do
		table.insert(slot6.equipUids, slot11)
	end

	slot0:sendMsg(slot6)
end

function slot0.onReceiveEnterRogueReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.activityId
	slot4 = slot2.info

	V1a6_CachotModel.instance:updateRogueInfo(slot4)
	V1a6_CachotRoomModel.instance:setLayerAndRoom(slot4.layer, slot4.room)
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnReceiveEnterRogueReply)
	V1a6_CachotStatController.instance:recordInitHeroGroupByEnterRogue()
end

function slot0.sendRogueEventStartRequest(slot0, slot1, slot2)
	slot3 = RogueModule_pb.RogueEventStartRequest()
	slot3.activityId = slot1
	slot3.eventId = slot2

	slot0:sendMsg(slot3)
	V1a6_CachotEventController.instance:setPause(true, V1a6_CachotEnum.EventPauseType.Request)
end

function slot0.onReceiveRogueEventStartReply(slot0, slot1, slot2)
	V1a6_CachotEventController.instance:setPause(false, V1a6_CachotEnum.EventPauseType.Request)

	if slot1 ~= 0 then
		return
	end

	if not V1a6_CachotModel.instance:isInRogue() then
		V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.CheckOpenEnding)
	end
end

function slot0.sendRogueEventSelectRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = RogueModule_pb.RogueEventSelectRequest()
	slot6.activityId = slot1
	slot6.eventId = slot2
	slot6.option = slot3

	slot0:sendMsg(slot6, slot4, slot5)
end

function slot0.onReceiveRogueEventSelectReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end
end

function slot0.sendRogueEventEndRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = RogueModule_pb.RogueEventEndRequest()
	slot5.activityId = slot1
	slot5.eventId = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveRogueEventEndReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end
end

function slot0.sendRogueEventFightRewardRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = RogueModule_pb.RogueEventFightRewardRequest()
	slot5.activityId = slot1
	slot5.eventId = slot2
	slot5.idx = slot3

	if slot4 then
		slot5.colletionIdx = slot4
	end

	slot0:sendMsg(slot5)
end

function slot0.onReceiveRogueEventFightRewardReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnReceiveFightReward)
end

function slot0.sendRogueEventCollectionRequest(slot0, slot1, slot2, slot3)
	slot4 = RogueModule_pb.RogueEventCollectionRequest()
	slot4.activityId = slot1
	slot4.eventId = slot2
	slot4.idx = slot3

	slot0:sendMsg(slot4)
end

function slot0.onReceiveRogueEventCollectionReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end
end

function slot0.sendRogueGroupChangeRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = RogueModule_pb.RogueGroupChangeRequest()
	slot6.activityId = slot1
	slot6.idx = slot2

	slot0:_packGroup(slot6.group, slot3.id, slot3.heroList, slot3.equips, slot3.groupName, slot3.clothId)
	slot0:sendMsg(slot6, slot4, slot5)
end

function slot0.onReceiveRogueGroupChangeReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.activityId

	V1a6_CachotModel.instance:updateTeamInfo(slot2.teamInfo)
end

function slot0.sendRogueGroupIdxChangeRequest(slot0, slot1, slot2)
	slot3 = RogueModule_pb.RogueGroupIdxChangeRequest()
	slot3.activityId = slot1
	slot3.idx = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveRogueGroupIdxChangeReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.activityId

	V1a6_CachotModel.instance:updateTeamInfo(slot2.teamInfo)
end

function slot0.sendRogueCollectionEnchantRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = RogueModule_pb.RogueCollectionEnchantRequest()
	slot5.activityId = slot1
	slot5.uid = slot2
	slot5.leftUid = slot3 or V1a6_CachotEnum.EmptyEnchantId
	slot5.rightUid = slot4 or V1a6_CachotEnum.EmptyEnchantId

	slot0:sendMsg(slot5)
end

function slot0.onReceiveRogueCollectionEnchantReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end
end

function slot0.onReceiveRogueGoodsInfoPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.activityId

	V1a6_CachotModel.instance:updateGoodsInfos(slot2.goodsInfos)
end

function slot0.sendBuyRogueGoodsRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = RogueModule_pb.BuyRogueGoodsRequest()
	slot6.activityId = slot1
	slot6.id = slot2
	slot6.num = slot3

	slot0:sendMsg(slot6, slot4, slot5)
end

function slot0.onReceiveBuyRogueGoodsReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.activityId
	slot4 = slot2.goodsInfo
	slot5 = slot2.num

	for slot10, slot11 in pairs(V1a6_CachotModel.instance:getGoodsInfos()) do
		if slot11.id == slot4.id then
			slot11:init(slot4)

			break
		end
	end

	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnUpdateGoodsInfos)
end

function slot0.onReceiveRogueStatePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	V1a6_CachotModel.instance:updateRogueStateInfo(slot2.state)
end

function slot0.onReceiveRogueInfoPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.info

	V1a6_CachotModel.instance:updateRogueInfo(slot3)
	V1a6_CachotRoomModel.instance:setLayerAndRoom(slot3.layer, slot3.room)
end

function slot0.onReceiveRogueEventUpdatePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	if not V1a6_CachotModel.instance:isInRogue() then
		return
	end

	if slot2.event.status == V1a6_CachotEnum.EventStatus.Start then
		V1a6_CachotStatController.instance:statStartEvent(slot3)

		if V1a6_CachotRoomModel.instance:tryAddSelectEvent(slot3) then
			V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.PlayerTriggerInteract, slot4)
		end
	elseif slot3.status == V1a6_CachotEnum.EventStatus.Finish then
		V1a6_CachotStatController.instance:statFinishEvent(slot3)
		V1a6_CachotRoomModel.instance:tryRemoveSelectEvent(slot3)
		V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnEventFinish, slot3)
	end
end

function slot0.onReceiveRogueFightResultPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot4 = slot2.score
	slot5 = slot2.useWeekDouble
	slot6 = slot2.roomNum
	slot7 = slot2.difficulty
	slot8 = slot2.bonus
	slot9 = slot2.collections

	V1a6_CachotModel.instance:updateTeamInfo(slot2.teamInfo)
end

function slot0.onReceiveRogueCollectionsPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	V1a6_CachotModel.instance:updateCollectionsInfos(slot2.collections)
end

function slot0.onReceiveRogueTeamInfoPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	V1a6_CachotModel.instance:updateTeamInfo(slot2.teamInfo)
end

function slot0.onReceiveRogueCoinPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	V1a6_CachotModel.instance:getRogueInfo():updateCoin(slot2.coin)
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnUpdateCoin)
end

function slot0.onReceiveRogueCurrencyPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot5 = V1a6_CachotModel.instance:getRogueInfo()

	slot5:updateCurrency(slot2.currency)
	slot5:updateCurrencyTotal(slot2.currencyTotal)
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnUpdateCurrency)
end

function slot0.onReceiveRogueHeartPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.heart

	if not V1a6_CachotModel.instance:getRogueInfo() then
		return
	end

	if slot4.heart ~= slot3 then
		if V1a6_CachotConfig.instance:getHeartConfig(slot3).id < V1a6_CachotConfig.instance:getHeartConfig(slot4.heart).id then
			GameFacade.showToast(ToastEnum.V1a6Cachot_HeartSub)
		elseif slot5.id < slot6.id then
			GameFacade.showToast(ToastEnum.V1a6Cachot_HeartAdd)
		end
	end

	slot4:updateHeart(slot3)
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnUpdateHeart)
end

function slot0.onReceiveRogueEndPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	V1a6_CachotModel.instance:updateRogueEndingInfo(slot2)
	V1a6_CachotStatController.instance:bakeRogueInfoMo()
	V1a6_CachotStatController.instance:statEnd()
	V1a6_CachotModel.instance:clearRogueInfo()
end

function slot0.onReceiveRogueCollectionGetPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	V1a6_CachotEventController.instance:setPause(true, V1a6_CachotEnum.EventPauseType.GetCollecttions)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CollectionGet, ViewName.V1a6_CachotCollectionGetView, slot2)
end

function slot0.onReceiveRogueLifeChangePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.heroLife

	V1a6_CachotModel.instance:setChangeLifes(slot3)
	V1a6_CachotStatController.instance:setChangeLife(slot3)
end

function slot0.sendRogueCollectionNewRequest(slot0, slot1, slot2)
	RogueModule_pb.RogueCollectionNewRequest().activityId = slot1

	for slot7, slot8 in pairs(slot2) do
		slot3.collecions:append(slot8)
	end

	slot0:sendMsg(slot3)
end

function slot0.onReceiveRogueCollectionNewReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	if V1a6_CachotModel.instance:getRogueStateInfo() then
		slot4:updateUnlockCollectionsNew(slot2.newColletions)
	end
end

function slot0.onReceiveRogueCollectionUnlockPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	V1a6_CachotCollectionUnlockController.instance:onReceiveUnlockCollections(slot2.unlockCollections)
	V1a6_CachotStatController.instance:statUnlockCollection(slot2.unlockCollections)
end

function slot0.sendRogueReadEndingRequest(slot0, slot1)
	slot2 = RogueModule_pb.RogueReadEndingRequest()
	slot2.activityId = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveRogueReadEndingReply(slot0, slot1, slot2)
end

function slot0.sendRogueReturnRequest(slot0, slot1, slot2, slot3)
	slot4 = RogueModule_pb.RogueReturnRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveRogueReturnReply(slot0, slot1, slot2)
end

slot0.instance = slot0.New()

return slot0
