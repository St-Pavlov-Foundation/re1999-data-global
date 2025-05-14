module("modules.logic.versionactivity1_6.v1a6_cachot.rpc.RogueRpc", package.seeall)

local var_0_0 = class("RogueRpc", BaseRpc)

function var_0_0.sendGetRogueStateRequest(arg_1_0)
	local var_1_0 = RogueModule_pb.GetRogueStateRequest()

	arg_1_0:sendMsg(var_1_0)
end

function var_0_0.onReceiveGetRogueStateReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	local var_2_0 = arg_2_2.state

	V1a6_CachotModel.instance:updateRogueStateInfo(var_2_0)
	V1a6_CachotProgressListModel.instance:initDatas()
end

function var_0_0.sendGetRogueInfoRequest(arg_3_0, arg_3_1)
	local var_3_0 = RogueModule_pb.GetRogueInfoRequest()

	var_3_0.activityId = arg_3_1

	arg_3_0:sendMsg(var_3_0)
end

function var_0_0.onReceiveGetRogueInfoReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	local var_4_0 = arg_4_2.info

	V1a6_CachotModel.instance:updateRogueInfo(var_4_0)
	V1a6_CachotRoomModel.instance:setLayerAndRoom(var_4_0.layer, var_4_0.room)
	V1a6_CachotController.instance:enterMap(false)
end

function var_0_0.sendGetRogueScoreRewardRequest(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = RogueModule_pb.GetRogueScoreRewardRequest()

	var_5_0.activityId = arg_5_1

	for iter_5_0, iter_5_1 in ipairs(arg_5_2) do
		var_5_0.rewards:append(iter_5_1)
	end

	arg_5_0:sendMsg(var_5_0)
end

function var_0_0.onReceiveGetRogueScoreRewardReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 ~= 0 then
		return
	end
end

function var_0_0.sendAbortRogueRequest(arg_7_0, arg_7_1)
	local var_7_0 = RogueModule_pb.AbortRogueRequest()

	var_7_0.activityId = arg_7_1

	arg_7_0:sendMsg(var_7_0)
end

function var_0_0.onReceiveAbortRogueReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 ~= 0 then
		return
	end

	local var_8_0 = arg_8_2.state
	local var_8_1 = arg_8_2.score

	V1a6_CachotModel.instance:clearRogueInfo()
	V1a6_CachotModel.instance:updateRogueStateInfo(var_8_0)

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		return
	end

	if V1a6_CachotModel.instance:getRogueEndingInfo() then
		V1a6_CachotController.instance:openV1a6_CachotFinishView()
	end
end

function var_0_0._packGroup(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6)
	arg_9_1.id = arg_9_2
	arg_9_1.name = arg_9_5 or ""
	arg_9_1.clothId = arg_9_6 or 0

	if arg_9_3 then
		for iter_9_0, iter_9_1 in ipairs(arg_9_3) do
			table.insert(arg_9_1.heroList, iter_9_1)
		end
	end

	if arg_9_4 then
		for iter_9_2, iter_9_3 in ipairs(arg_9_4) do
			local var_9_0 = HeroDef_pb.HeroGroupEquip()

			var_9_0.index = iter_9_2 - 1

			for iter_9_4, iter_9_5 in ipairs(iter_9_3.equipUid) do
				table.insert(var_9_0.equipUid, iter_9_5)
			end

			table.insert(arg_9_1.equips, var_9_0)
		end
	end
end

function var_0_0.sendEnterRogueRequest(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
	local var_10_0 = RogueModule_pb.EnterRogueRequest()

	var_10_0.activityId = arg_10_1
	var_10_0.difficulty = arg_10_2

	arg_10_0:_packGroup(var_10_0.group, arg_10_3.id, arg_10_3.heroList, arg_10_3.equips, arg_10_3.groupName, arg_10_3.clothId)
	arg_10_0:_packGroup(var_10_0.backupGroup, arg_10_4.id, arg_10_4.heroList, arg_10_4.equips, arg_10_4.groupName, arg_10_3.clothId)

	for iter_10_0, iter_10_1 in ipairs(arg_10_5) do
		table.insert(var_10_0.equipUids, iter_10_1)
	end

	arg_10_0:sendMsg(var_10_0)
end

function var_0_0.onReceiveEnterRogueReply(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 ~= 0 then
		return
	end

	local var_11_0 = arg_11_2.activityId
	local var_11_1 = arg_11_2.info

	V1a6_CachotModel.instance:updateRogueInfo(var_11_1)
	V1a6_CachotRoomModel.instance:setLayerAndRoom(var_11_1.layer, var_11_1.room)
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnReceiveEnterRogueReply)
	V1a6_CachotStatController.instance:recordInitHeroGroupByEnterRogue()
end

function var_0_0.sendRogueEventStartRequest(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = RogueModule_pb.RogueEventStartRequest()

	var_12_0.activityId = arg_12_1
	var_12_0.eventId = arg_12_2

	arg_12_0:sendMsg(var_12_0)
	V1a6_CachotEventController.instance:setPause(true, V1a6_CachotEnum.EventPauseType.Request)
end

function var_0_0.onReceiveRogueEventStartReply(arg_13_0, arg_13_1, arg_13_2)
	V1a6_CachotEventController.instance:setPause(false, V1a6_CachotEnum.EventPauseType.Request)

	if arg_13_1 ~= 0 then
		return
	end

	if not V1a6_CachotModel.instance:isInRogue() then
		V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.CheckOpenEnding)
	end
end

function var_0_0.sendRogueEventSelectRequest(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5)
	local var_14_0 = RogueModule_pb.RogueEventSelectRequest()

	var_14_0.activityId = arg_14_1
	var_14_0.eventId = arg_14_2
	var_14_0.option = arg_14_3

	arg_14_0:sendMsg(var_14_0, arg_14_4, arg_14_5)
end

function var_0_0.onReceiveRogueEventSelectReply(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 ~= 0 then
		return
	end
end

function var_0_0.sendRogueEventEndRequest(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	local var_16_0 = RogueModule_pb.RogueEventEndRequest()

	var_16_0.activityId = arg_16_1
	var_16_0.eventId = arg_16_2

	arg_16_0:sendMsg(var_16_0, arg_16_3, arg_16_4)
end

function var_0_0.onReceiveRogueEventEndReply(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_1 ~= 0 then
		return
	end
end

function var_0_0.sendRogueEventFightRewardRequest(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	local var_18_0 = RogueModule_pb.RogueEventFightRewardRequest()

	var_18_0.activityId = arg_18_1
	var_18_0.eventId = arg_18_2
	var_18_0.idx = arg_18_3

	if arg_18_4 then
		var_18_0.colletionIdx = arg_18_4
	end

	arg_18_0:sendMsg(var_18_0)
end

function var_0_0.onReceiveRogueEventFightRewardReply(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_1 ~= 0 then
		return
	end

	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnReceiveFightReward)
end

function var_0_0.sendRogueEventCollectionRequest(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = RogueModule_pb.RogueEventCollectionRequest()

	var_20_0.activityId = arg_20_1
	var_20_0.eventId = arg_20_2
	var_20_0.idx = arg_20_3

	arg_20_0:sendMsg(var_20_0)
end

function var_0_0.onReceiveRogueEventCollectionReply(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_1 ~= 0 then
		return
	end
end

function var_0_0.sendRogueGroupChangeRequest(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5)
	local var_22_0 = RogueModule_pb.RogueGroupChangeRequest()

	var_22_0.activityId = arg_22_1
	var_22_0.idx = arg_22_2

	arg_22_0:_packGroup(var_22_0.group, arg_22_3.id, arg_22_3.heroList, arg_22_3.equips, arg_22_3.groupName, arg_22_3.clothId)
	arg_22_0:sendMsg(var_22_0, arg_22_4, arg_22_5)
end

function var_0_0.onReceiveRogueGroupChangeReply(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_1 ~= 0 then
		return
	end

	local var_23_0 = arg_23_2.activityId
	local var_23_1 = arg_23_2.teamInfo

	V1a6_CachotModel.instance:updateTeamInfo(var_23_1)
end

function var_0_0.sendRogueGroupIdxChangeRequest(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = RogueModule_pb.RogueGroupIdxChangeRequest()

	var_24_0.activityId = arg_24_1
	var_24_0.idx = arg_24_2

	arg_24_0:sendMsg(var_24_0)
end

function var_0_0.onReceiveRogueGroupIdxChangeReply(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_1 ~= 0 then
		return
	end

	local var_25_0 = arg_25_2.activityId
	local var_25_1 = arg_25_2.teamInfo

	V1a6_CachotModel.instance:updateTeamInfo(var_25_1)
end

function var_0_0.sendRogueCollectionEnchantRequest(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	local var_26_0 = RogueModule_pb.RogueCollectionEnchantRequest()

	var_26_0.activityId = arg_26_1
	var_26_0.uid = arg_26_2
	var_26_0.leftUid = arg_26_3 or V1a6_CachotEnum.EmptyEnchantId
	var_26_0.rightUid = arg_26_4 or V1a6_CachotEnum.EmptyEnchantId

	arg_26_0:sendMsg(var_26_0)
end

function var_0_0.onReceiveRogueCollectionEnchantReply(arg_27_0, arg_27_1, arg_27_2)
	if arg_27_1 ~= 0 then
		return
	end
end

function var_0_0.onReceiveRogueGoodsInfoPush(arg_28_0, arg_28_1, arg_28_2)
	if arg_28_1 ~= 0 then
		return
	end

	local var_28_0 = arg_28_2.activityId
	local var_28_1 = arg_28_2.goodsInfos

	V1a6_CachotModel.instance:updateGoodsInfos(var_28_1)
end

function var_0_0.sendBuyRogueGoodsRequest(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4, arg_29_5)
	local var_29_0 = RogueModule_pb.BuyRogueGoodsRequest()

	var_29_0.activityId = arg_29_1
	var_29_0.id = arg_29_2
	var_29_0.num = arg_29_3

	arg_29_0:sendMsg(var_29_0, arg_29_4, arg_29_5)
end

function var_0_0.onReceiveBuyRogueGoodsReply(arg_30_0, arg_30_1, arg_30_2)
	if arg_30_1 ~= 0 then
		return
	end

	local var_30_0 = arg_30_2.activityId
	local var_30_1 = arg_30_2.goodsInfo
	local var_30_2 = arg_30_2.num
	local var_30_3 = V1a6_CachotModel.instance:getGoodsInfos()

	for iter_30_0, iter_30_1 in pairs(var_30_3) do
		if iter_30_1.id == var_30_1.id then
			iter_30_1:init(var_30_1)

			break
		end
	end

	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnUpdateGoodsInfos)
end

function var_0_0.onReceiveRogueStatePush(arg_31_0, arg_31_1, arg_31_2)
	if arg_31_1 ~= 0 then
		return
	end

	local var_31_0 = arg_31_2.state

	V1a6_CachotModel.instance:updateRogueStateInfo(var_31_0)
end

function var_0_0.onReceiveRogueInfoPush(arg_32_0, arg_32_1, arg_32_2)
	if arg_32_1 ~= 0 then
		return
	end

	local var_32_0 = arg_32_2.info

	V1a6_CachotModel.instance:updateRogueInfo(var_32_0)
	V1a6_CachotRoomModel.instance:setLayerAndRoom(var_32_0.layer, var_32_0.room)
end

function var_0_0.onReceiveRogueEventUpdatePush(arg_33_0, arg_33_1, arg_33_2)
	if arg_33_1 ~= 0 then
		return
	end

	if not V1a6_CachotModel.instance:isInRogue() then
		return
	end

	local var_33_0 = arg_33_2.event

	if var_33_0.status == V1a6_CachotEnum.EventStatus.Start then
		V1a6_CachotStatController.instance:statStartEvent(var_33_0)

		local var_33_1 = V1a6_CachotRoomModel.instance:tryAddSelectEvent(var_33_0)

		if var_33_1 then
			V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.PlayerTriggerInteract, var_33_1)
		end
	elseif var_33_0.status == V1a6_CachotEnum.EventStatus.Finish then
		V1a6_CachotStatController.instance:statFinishEvent(var_33_0)
		V1a6_CachotRoomModel.instance:tryRemoveSelectEvent(var_33_0)
		V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnEventFinish, var_33_0)
	end
end

function var_0_0.onReceiveRogueFightResultPush(arg_34_0, arg_34_1, arg_34_2)
	if arg_34_1 ~= 0 then
		return
	end

	local var_34_0 = arg_34_2.teamInfo
	local var_34_1 = arg_34_2.score
	local var_34_2 = arg_34_2.useWeekDouble
	local var_34_3 = arg_34_2.roomNum
	local var_34_4 = arg_34_2.difficulty
	local var_34_5 = arg_34_2.bonus
	local var_34_6 = arg_34_2.collections

	V1a6_CachotModel.instance:updateTeamInfo(var_34_0)
end

function var_0_0.onReceiveRogueCollectionsPush(arg_35_0, arg_35_1, arg_35_2)
	if arg_35_1 ~= 0 then
		return
	end

	local var_35_0 = arg_35_2.collections

	V1a6_CachotModel.instance:updateCollectionsInfos(var_35_0)
end

function var_0_0.onReceiveRogueTeamInfoPush(arg_36_0, arg_36_1, arg_36_2)
	if arg_36_1 ~= 0 then
		return
	end

	local var_36_0 = arg_36_2.teamInfo

	V1a6_CachotModel.instance:updateTeamInfo(var_36_0)
end

function var_0_0.onReceiveRogueCoinPush(arg_37_0, arg_37_1, arg_37_2)
	if arg_37_1 ~= 0 then
		return
	end

	local var_37_0 = arg_37_2.coin

	V1a6_CachotModel.instance:getRogueInfo():updateCoin(var_37_0)
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnUpdateCoin)
end

function var_0_0.onReceiveRogueCurrencyPush(arg_38_0, arg_38_1, arg_38_2)
	if arg_38_1 ~= 0 then
		return
	end

	local var_38_0 = arg_38_2.currency
	local var_38_1 = arg_38_2.currencyTotal
	local var_38_2 = V1a6_CachotModel.instance:getRogueInfo()

	var_38_2:updateCurrency(var_38_0)
	var_38_2:updateCurrencyTotal(var_38_1)
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnUpdateCurrency)
end

function var_0_0.onReceiveRogueHeartPush(arg_39_0, arg_39_1, arg_39_2)
	if arg_39_1 ~= 0 then
		return
	end

	local var_39_0 = arg_39_2.heart
	local var_39_1 = V1a6_CachotModel.instance:getRogueInfo()

	if not var_39_1 then
		return
	end

	if var_39_1.heart ~= var_39_0 then
		local var_39_2 = V1a6_CachotConfig.instance:getHeartConfig(var_39_1.heart)
		local var_39_3 = V1a6_CachotConfig.instance:getHeartConfig(var_39_0)

		if var_39_2.id > var_39_3.id then
			GameFacade.showToast(ToastEnum.V1a6Cachot_HeartSub)
		elseif var_39_2.id < var_39_3.id then
			GameFacade.showToast(ToastEnum.V1a6Cachot_HeartAdd)
		end
	end

	var_39_1:updateHeart(var_39_0)
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnUpdateHeart)
end

function var_0_0.onReceiveRogueEndPush(arg_40_0, arg_40_1, arg_40_2)
	if arg_40_1 ~= 0 then
		return
	end

	V1a6_CachotModel.instance:updateRogueEndingInfo(arg_40_2)
	V1a6_CachotStatController.instance:bakeRogueInfoMo()
	V1a6_CachotStatController.instance:statEnd()
	V1a6_CachotModel.instance:clearRogueInfo()
end

function var_0_0.onReceiveRogueCollectionGetPush(arg_41_0, arg_41_1, arg_41_2)
	if arg_41_1 ~= 0 then
		return
	end

	V1a6_CachotEventController.instance:setPause(true, V1a6_CachotEnum.EventPauseType.GetCollecttions)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CollectionGet, ViewName.V1a6_CachotCollectionGetView, arg_41_2)
end

function var_0_0.onReceiveRogueLifeChangePush(arg_42_0, arg_42_1, arg_42_2)
	if arg_42_1 ~= 0 then
		return
	end

	local var_42_0 = arg_42_2.heroLife

	V1a6_CachotModel.instance:setChangeLifes(var_42_0)
	V1a6_CachotStatController.instance:setChangeLife(var_42_0)
end

function var_0_0.sendRogueCollectionNewRequest(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = RogueModule_pb.RogueCollectionNewRequest()

	var_43_0.activityId = arg_43_1

	for iter_43_0, iter_43_1 in pairs(arg_43_2) do
		var_43_0.collecions:append(iter_43_1)
	end

	arg_43_0:sendMsg(var_43_0)
end

function var_0_0.onReceiveRogueCollectionNewReply(arg_44_0, arg_44_1, arg_44_2)
	if arg_44_1 ~= 0 then
		return
	end

	local var_44_0 = arg_44_2.newColletions
	local var_44_1 = V1a6_CachotModel.instance:getRogueStateInfo()

	if var_44_1 then
		var_44_1:updateUnlockCollectionsNew(var_44_0)
	end
end

function var_0_0.onReceiveRogueCollectionUnlockPush(arg_45_0, arg_45_1, arg_45_2)
	if arg_45_1 ~= 0 then
		return
	end

	V1a6_CachotCollectionUnlockController.instance:onReceiveUnlockCollections(arg_45_2.unlockCollections)
	V1a6_CachotStatController.instance:statUnlockCollection(arg_45_2.unlockCollections)
end

function var_0_0.sendRogueReadEndingRequest(arg_46_0, arg_46_1)
	local var_46_0 = RogueModule_pb.RogueReadEndingRequest()

	var_46_0.activityId = arg_46_1

	arg_46_0:sendMsg(var_46_0)
end

function var_0_0.onReceiveRogueReadEndingReply(arg_47_0, arg_47_1, arg_47_2)
	return
end

function var_0_0.sendRogueReturnRequest(arg_48_0, arg_48_1, arg_48_2, arg_48_3)
	local var_48_0 = RogueModule_pb.RogueReturnRequest()

	var_48_0.activityId = arg_48_1

	arg_48_0:sendMsg(var_48_0, arg_48_2, arg_48_3)
end

function var_0_0.onReceiveRogueReturnReply(arg_49_0, arg_49_1, arg_49_2)
	return
end

var_0_0.instance = var_0_0.New()

return var_0_0
