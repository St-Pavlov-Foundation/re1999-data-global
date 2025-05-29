module("modules.logic.rouge.rpc.RougeRpc", package.seeall)

local var_0_0 = class("RougeRpc", BaseRpc)

function var_0_0.sendGetRougeInfoRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = RougeModule_pb.GetRougeInfoRequest()

	var_1_0.season = arg_1_1

	return arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGetRougeInfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	local var_2_0 = arg_2_2.rougeInfo

	RougeModel.instance:updateRougeInfo(var_2_0)
	RougeModel.instance:setTeamInitHeros(arg_2_2.initHeroIds)
end

function var_0_0.onReceiveRougeInfoPush(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 ~= 0 then
		return
	end

	local var_3_0 = arg_3_2.rougeInfo

	RougeModel.instance:updateRougeInfo(var_3_0)
end

function var_0_0.sendEnterRougeSelectDifficultyRequest(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6)
	local var_4_0 = RougeModule_pb.EnterRougeSelectDifficultyRequest()

	var_4_0.season = arg_4_1

	for iter_4_0, iter_4_1 in ipairs(arg_4_2) do
		var_4_0.version:append(iter_4_1)
	end

	var_4_0.difficulty = arg_4_3

	if arg_4_4 then
		local var_4_1 = arg_4_4:getLimitIds()

		for iter_4_2, iter_4_3 in ipairs(var_4_1) do
			var_4_0.limiterNO.limitIds:append(iter_4_3)
		end

		local var_4_2 = arg_4_4:getLimitBuffIds()

		for iter_4_4, iter_4_5 in ipairs(var_4_2) do
			var_4_0.limiterNO.limitBuffIds:append(iter_4_5)
		end
	end

	return arg_4_0:sendMsg(var_4_0, arg_4_5, arg_4_6)
end

function var_0_0.onReceiveEnterRougeSelectDifficultyReply(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 ~= 0 then
		return
	end

	local var_5_0 = arg_5_2.season
	local var_5_1 = arg_5_2.rougeInfo

	RougeModel.instance:updateRougeInfo(var_5_1)
end

function var_0_0.sendEnterRougeSelectRewardRequest(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	local var_6_0 = RougeModule_pb.EnterRougeSelectRewardRequest()

	var_6_0.season = arg_6_1

	for iter_6_0, iter_6_1 in ipairs(arg_6_2) do
		var_6_0.rewardId:append(iter_6_1)
	end

	return arg_6_0:sendMsg(var_6_0, arg_6_3, arg_6_4)
end

function var_0_0.onReceiveEnterRougeSelectRewardReply(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 ~= 0 then
		return
	end

	local var_7_0 = arg_7_2.season
	local var_7_1 = arg_7_2.rougeInfo

	RougeModel.instance:updateRougeInfo(var_7_1)
end

function var_0_0.sendEnterRougeSelectStyleRequest(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local var_8_0 = RougeModule_pb.EnterRougeSelectStyleRequest()

	var_8_0.season = arg_8_1
	var_8_0.style = arg_8_2

	return arg_8_0:sendMsg(var_8_0, arg_8_3, arg_8_4)
end

function var_0_0.onReceiveEnterRougeSelectStyleReply(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 ~= 0 then
		return
	end

	local var_9_0 = arg_9_2.season
	local var_9_1 = arg_9_2.rougeInfo

	RougeModel.instance:updateRougeInfo(var_9_1)
end

function var_0_0.sendEnterRougeSelectHeroesRequest(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
	local var_10_0 = RougeModule_pb.EnterRougeSelectHeroesRequest()

	var_10_0.season = arg_10_1

	for iter_10_0, iter_10_1 in ipairs(arg_10_2) do
		var_10_0.heroesList:append(iter_10_1)
	end

	if arg_10_3 then
		var_10_0.assistHeroUid = arg_10_3
	end

	return arg_10_0:sendMsg(var_10_0, arg_10_4, arg_10_5)
end

function var_0_0.onReceiveEnterRougeSelectHeroesReply(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 ~= 0 then
		return
	end

	local var_11_0 = arg_11_2.season
	local var_11_1 = arg_11_2.rougeInfo

	RougeModel.instance:updateRougeInfo(var_11_1)
end

function var_0_0.sendRougeGroupChangeRequest(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	local var_12_0 = RougeModule_pb.RougeGroupChangeRequest()

	var_12_0.season = arg_12_1

	for iter_12_0, iter_12_1 in ipairs(arg_12_2) do
		local var_12_1 = var_12_0.battleHeroList:add()

		var_12_1.index = iter_12_1.index
		var_12_1.heroId = iter_12_1.heroId
		var_12_1.equipUid = iter_12_1.equipUid
		var_12_1.supportHeroId = iter_12_1.supportHeroId
		var_12_1.supportHeroSkill = iter_12_1.supportHeroSkill
	end

	return arg_12_0:sendMsg(var_12_0, arg_12_3, arg_12_4)
end

function var_0_0.onReceiveRougeGroupChangeReply(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 ~= 0 then
		return
	end

	local var_13_0 = arg_13_2.teamInfo

	RougeModel.instance:updateTeamInfo(var_13_0)
end

function var_0_0.sendRougeRoundMoveRequest(arg_14_0, arg_14_1)
	local var_14_0 = RougeModule_pb.RougeRoundMoveRequest()

	var_14_0.season = RougeModel.instance:getSeason() or 1
	var_14_0.layer = RougeMapModel.instance:getLayerId()
	var_14_0.nodeId = arg_14_1

	return arg_14_0:sendMsg(var_14_0)
end

function var_0_0.onReceiveRougeRoundMoveReply(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 ~= 0 then
		return
	end

	RougeMapModel.instance:updateMapInfo(arg_15_2.map)

	if not RougeMapModel.instance:needPlayMoveToEndAnim() then
		RougeMapController.instance:startMove()
	end
end

function var_0_0.sendRougeChoiceEventRequest(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = RougeModule_pb.RougeChoiceEventRequest()

	var_16_0.season = RougeModel.instance:getSeason() or 1
	var_16_0.layer = RougeMapModel.instance:getLayerId()

	local var_16_1 = RougeMapModel.instance:getCurNode()

	var_16_0.nodeId = var_16_1.nodeId
	var_16_0.eventId = var_16_1.eventId
	var_16_0.choiceId = arg_16_1

	return arg_16_0:sendMsg(var_16_0, arg_16_2, arg_16_3)
end

function var_0_0.onReceiveRougeChoiceEventReply(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_1 ~= 0 then
		return
	end

	RougeMapModel.instance:updateMapInfo(arg_17_2.map)
	RougeStatController.instance:statRougeChoiceEvent()
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onReceiveChoiceEvent)
end

function var_0_0.sendRougeSelectDropRequest(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = RougeModule_pb.RougeSelectDropRequest()

	var_18_0.season = RougeModel.instance:getSeason() or 1

	for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
		var_18_0.collectionPos:append(iter_18_1 - 1)
	end

	return arg_18_0:sendMsg(var_18_0, arg_18_2, arg_18_3)
end

function var_0_0.onReceiveRougeSelectDropReply(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_1 ~= 0 then
		return
	end

	RougeMapModel.instance:updateMapInfo(arg_19_2.map)
end

function var_0_0.sendRougeSelectLostCollectionRequest(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = RougeModule_pb.RougeSelectLostCollectionRequest()

	var_20_0.season = RougeModel.instance:getSeason() or 1

	for iter_20_0, iter_20_1 in ipairs(arg_20_1) do
		var_20_0.collectionUid:append(iter_20_1.uid)
	end

	return arg_20_0:sendMsg(var_20_0, arg_20_2, arg_20_3)
end

function var_0_0.onReceiveRougeSelectLostCollectionReply(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_1 ~= 0 then
		return
	end

	RougeMapModel.instance:updateMapInfo(arg_21_2.map)
end

function var_0_0.sendRougeSelectHealRequest(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = RougeModule_pb.RougeSelectHealRequest()

	var_22_0.season = RougeModel.instance:getSeason() or 1

	for iter_22_0, iter_22_1 in ipairs(arg_22_1) do
		var_22_0.heroIds:append(iter_22_1)
	end

	return arg_22_0:sendMsg(var_22_0, arg_22_2, arg_22_3)
end

function var_0_0.onReceiveRougeSelectHealReply(arg_23_0, arg_23_1, arg_23_2)
	return
end

function var_0_0.sendRougeSelectReviveRequest(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = RougeModule_pb.RougeSelectReviveRequest()

	var_24_0.season = RougeModel.instance:getSeason() or 1

	for iter_24_0, iter_24_1 in ipairs(arg_24_1) do
		var_24_0.heroIds:append(iter_24_1)
	end

	return arg_24_0:sendMsg(var_24_0, arg_24_2, arg_24_3)
end

function var_0_0.onReceiveRougeSelectReviveReply(arg_25_0, arg_25_1, arg_25_2)
	return
end

function var_0_0.sendRougePieceMoveRequest(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = RougeModule_pb.RougePieceMoveRequest()

	var_26_0.season = RougeModel.instance:getSeason() or 1
	var_26_0.layer = RougeMapModel.instance:getLayerId()
	var_26_0.middleLayer = RougeMapModel.instance:getMiddleLayerId()
	var_26_0.index = arg_26_1

	return arg_26_0:sendMsg(var_26_0, arg_26_2, arg_26_3)
end

function var_0_0.onReceiveRougePieceMoveReply(arg_27_0, arg_27_1, arg_27_2)
	if arg_27_1 ~= 0 then
		return
	end

	RougeMapModel.instance:updateMapInfo(arg_27_2.map)
end

function var_0_0.sendRougePieceTalkSelectRequest(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	local var_28_0 = RougeModule_pb.RougePieceTalkSelectRequest()

	var_28_0.season = RougeModel.instance:getSeason() or 1
	var_28_0.layer = RougeMapModel.instance:getLayerId()
	var_28_0.middleLayer = RougeMapModel.instance:getMiddleLayerId()
	var_28_0.index = RougeMapModel.instance:getCurPosIndex()
	var_28_0.select = arg_28_1

	return arg_28_0:sendMsg(var_28_0, arg_28_2, arg_28_3)
end

function var_0_0.onReceiveRougePieceTalkSelectReply(arg_29_0, arg_29_1, arg_29_2)
	if arg_29_1 ~= 0 then
		return
	end

	RougeMapModel.instance:updateMapInfo(arg_29_2.map)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onReceivePieceChoiceEvent)
end

function var_0_0.sendRougeLeaveMiddleLayerRequest(arg_30_0, arg_30_1)
	local var_30_0 = RougeModule_pb.RougeLeaveMiddleLayerRequest()

	var_30_0.season = RougeModel.instance:getSeason() or 1
	var_30_0.layer = RougeMapModel.instance:getLayerId()
	var_30_0.middleLayer = RougeMapModel.instance:getMiddleLayerId()
	var_30_0.nextLayer = arg_30_1

	RougeMapModel.instance:setWaitLeaveMiddleLayerReply(true)

	return arg_30_0:sendMsg(var_30_0)
end

function var_0_0.onReceiveRougeLeaveMiddleLayerReply(arg_31_0, arg_31_1, arg_31_2)
	RougeMapModel.instance:setWaitLeaveMiddleLayerReply(nil)

	if arg_31_1 ~= 0 then
		return
	end

	RougeMapModel.instance:updateMapInfo(arg_31_2.createEventMap)
	RougeMapModel.instance:setFinalMapInfo(arg_31_2.finalMap)

	local var_31_0 = RougeMapModel.instance:getLayerId()

	ViewMgr.instance:openView(ViewName.RougeNextLayerView, var_31_0)
end

function var_0_0.sendRougeBuyGoodsRequest(arg_32_0, arg_32_1, arg_32_2, arg_32_3, arg_32_4)
	local var_32_0 = RougeModule_pb.RougeBuyGoodsRequest()

	var_32_0.season = RougeModel.instance:getSeason() or 1
	var_32_0.layer = RougeMapModel.instance:getLayerId()
	var_32_0.nodeId = RougeMapModel.instance:getCurNode().nodeId
	var_32_0.eventId = arg_32_1

	var_32_0.goodsPos:append(arg_32_2)

	return arg_32_0:sendMsg(var_32_0, arg_32_3, arg_32_4)
end

function var_0_0.onReceiveRougeBuyGoodsReply(arg_33_0, arg_33_1, arg_33_2)
	if arg_33_1 ~= 0 then
		return
	end

	RougeMapModel.instance:updateMapInfo(arg_33_2.map)
end

function var_0_0.sendRougeEndShopEventRequest(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	local var_34_0 = RougeMapModel.instance:getCurNode()

	if not var_34_0 then
		if arg_34_2 then
			arg_34_2(arg_34_3)
		end

		return
	end

	local var_34_1 = RougeModule_pb.RougeEndShopEventRequest()

	var_34_1.season = RougeModel.instance:getSeason() or 1
	var_34_1.layer = RougeMapModel.instance:getLayerId()
	var_34_1.nodeId = var_34_0.nodeId
	var_34_1.eventId = arg_34_1

	return arg_34_0:sendMsg(var_34_1, arg_34_2, arg_34_3)
end

function var_0_0.onReceiveRougeEndShopEventReply(arg_35_0, arg_35_1, arg_35_2)
	if arg_35_1 ~= 0 then
		return
	end

	RougeMapModel.instance:updateMapInfo(arg_35_2.map)
end

function var_0_0.sendRougeShopRefreshRequest(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	local var_36_0 = RougeModule_pb.RougeShopRefreshRequest()

	var_36_0.season = RougeModel.instance:getSeason() or 1
	var_36_0.layer = RougeMapModel.instance:getLayerId()
	var_36_0.nodeId = RougeMapModel.instance:getCurNode().nodeId
	var_36_0.eventId = arg_36_1

	return arg_36_0:sendMsg(var_36_0, arg_36_2, arg_36_3)
end

function var_0_0.onReceiveRougeShopRefreshReply(arg_37_0, arg_37_1, arg_37_2)
	if arg_37_1 ~= 0 then
		return
	end

	RougeMapModel.instance:updateMapInfo(arg_37_2.map)
end

function var_0_0.onReceiveRougeInMapItemUpdatePush(arg_38_0, arg_38_1, arg_38_2)
	if arg_38_1 ~= 0 then
		return
	end

	RougePopController.instance:addPopViewWithViewName(ViewName.RougeCollectionDropView, {
		collectionList = arg_38_2.collectionId,
		viewEnum = RougeMapEnum.CollectionDropViewEnum.OnlyShow
	})
end

function var_0_0.onReceiveRougeLayerMapInfoPush(arg_39_0, arg_39_1, arg_39_2)
	if arg_39_1 ~= 0 then
		return
	end

	RougeMapModel.instance:updateMapInfo(arg_39_2.map)
end

function var_0_0.onReceiveRougeLayerSimpleMapInfoPush(arg_40_0, arg_40_1, arg_40_2)
	if arg_40_1 ~= 0 then
		return
	end

	RougeMapModel.instance:updateSimpleMapInfo(arg_40_2.map)
end

function var_0_0.sendRougeRecruitHeroRequest(arg_41_0, arg_41_1)
	local var_41_0 = RougeModule_pb.RougeRecruitHeroRequest()

	var_41_0.season = RougeModel.instance:getSeason() or 1

	if arg_41_1 then
		for iter_41_0, iter_41_1 in ipairs(arg_41_1) do
			var_41_0.heroIds:append(iter_41_1)
		end
	end

	return arg_41_0:sendMsg(var_41_0)
end

function var_0_0.onReceiveRougeRecruitHeroReply(arg_42_0, arg_42_1, arg_42_2)
	if arg_42_1 ~= 0 then
		return
	end

	RougeModel.instance:updateTeamLife(arg_42_2.teamInfo.heroLifeList)
	RougeModel.instance:updateExtraHeroInfo(arg_42_2.teamInfo.heroInfoList)
end

function var_0_0.onReceiveRougeFightResultPush(arg_43_0, arg_43_1, arg_43_2)
	if arg_43_1 ~= 0 then
		return
	end

	RougeModel.instance:updateFightResultMo(arg_43_2)
end

function var_0_0.onReceiveRougeInteractiveTeamHpUpdatePush(arg_44_0, arg_44_1, arg_44_2)
	if arg_44_1 ~= 0 then
		return
	end

	RougeModel.instance:updateTeamLifeAndDispatchEvent(arg_44_2.heroLifeList)
	RougeMapTipPopController.instance:addPopTipByInteractId(arg_44_2.interactiveId)
end

function var_0_0.onReceiveRougeEntrustInfoPush(arg_45_0, arg_45_1, arg_45_2)
	if arg_45_1 ~= 0 then
		return
	end

	RougeMapModel.instance:updateEntrustInfo(arg_45_2.entrustInfo)
end

function var_0_0.sendRougeInlayRequest(arg_46_0, arg_46_1, arg_46_2, arg_46_3, arg_46_4, arg_46_5)
	local var_46_0 = RougeModule_pb.RougeInlayRequest()

	var_46_0.season = RougeModel.instance:getSeason()
	var_46_0.targetId = arg_46_1
	var_46_0.holdId = arg_46_3 - 1
	var_46_0.consumeId = arg_46_2

	return arg_46_0:sendMsg(var_46_0, arg_46_4, arg_46_5)
end

function var_0_0.onReceiveRougeInlayReply(arg_47_0, arg_47_1, arg_47_2)
	if arg_47_1 ~= 0 then
		return
	end

	local var_47_0 = arg_47_2.season
	local var_47_1 = arg_47_2.item
	local var_47_2 = arg_47_2.preItem
	local var_47_3 = arg_47_2.reason

	RougeCollectionModel.instance:rougeInlay(var_47_1, var_47_2, var_47_3)
	RougeController.instance:dispatchEvent(RougeEvent.AdjustBackPack)
end

function var_0_0.sendRougeDemountRequest(arg_48_0, arg_48_1, arg_48_2, arg_48_3, arg_48_4)
	local var_48_0 = RougeModule_pb.RougeDemountRequest()

	var_48_0.season = RougeModel.instance:getSeason()
	var_48_0.targetId = arg_48_1
	var_48_0.holdId = arg_48_2 - 1

	return arg_48_0:sendMsg(var_48_0, arg_48_3, arg_48_4)
end

function var_0_0.onReceiveRougeDemountReply(arg_49_0, arg_49_1, arg_49_2)
	if arg_49_1 ~= 0 then
		return
	end

	local var_49_0 = arg_49_2.season
	local var_49_1 = arg_49_2.item
	local var_49_2 = arg_49_2.reason

	RougeCollectionModel.instance:rougeDemount(var_49_1, var_49_2)
	RougeController.instance:dispatchEvent(RougeEvent.AdjustBackPack)
end

function var_0_0.sendRougeAddToBarRequest(arg_50_0, arg_50_1, arg_50_2, arg_50_3)
	local var_50_0 = RougeModule_pb.RougeAddToBarRequest()

	var_50_0.season = RougeModel.instance:getSeason() or 1
	var_50_0.targetId = arg_50_1
	var_50_0.rotation = arg_50_3
	var_50_0.pos.row = arg_50_2.y
	var_50_0.pos.col = arg_50_2.x

	arg_50_0:sendMsg(var_50_0)
end

function var_0_0.onReceiveRougeAddToBarReply(arg_51_0, arg_51_1, arg_51_2)
	if arg_51_1 ~= 0 then
		return
	end
end

function var_0_0.sendRougeRemoveFromBarRequest(arg_52_0, arg_52_1)
	local var_52_0 = RougeModule_pb.RougeRemoveFromBarRequest()

	var_52_0.season = RougeModel.instance:getSeason()
	var_52_0.id = arg_52_1

	arg_52_0:sendMsg(var_52_0)
end

function var_0_0.onReceiveRougeRemoveFromBarReply(arg_53_0, arg_53_1, arg_53_2)
	if arg_53_1 ~= 0 then
		return
	end

	RougeController.instance:dispatchEvent(RougeEvent.AdjustBackPack)
end

function var_0_0.onReceiveRougeAddItemWarehousePush(arg_54_0, arg_54_1, arg_54_2)
	if arg_54_1 ~= 0 then
		return
	end

	local var_54_0 = arg_54_2.season
	local var_54_1 = arg_54_2.items
	local var_54_2 = arg_54_2.reason

	RougeCollectionModel.instance:onReceiveNewInfo2Bag(var_54_1, var_54_2)
end

function var_0_0.onReceiveRougeRemoveItemWarehousePush(arg_55_0, arg_55_1, arg_55_2)
	if arg_55_1 ~= 0 then
		return
	end

	RougeCollectionModel.instance:deleteSomeCollectionFromWarehouse(arg_55_2.ids)
end

function var_0_0.onReceiveRougeItemBagPush(arg_56_0, arg_56_1, arg_56_2)
	if arg_56_1 ~= 0 then
		return
	end

	local var_56_0 = arg_56_2.season

	RougeCollectionModel.instance:onReceiveNewInfo2Slot(arg_56_2.bag)
end

function var_0_0.onReceiveRougeItemWarehousePush(arg_57_0, arg_57_1, arg_57_2)
	if arg_57_1 ~= 0 then
		return
	end

	RougeCollectionModel.instance:onReceiveNewInfo2Bag(arg_57_2.bag)
end

function var_0_0.onReceiveRougeAddItemBagPush(arg_58_0, arg_58_1, arg_58_2)
	if arg_58_1 ~= 0 then
		return
	end

	local var_58_0 = arg_58_2.reason

	RougeCollectionModel.instance:onReceiveNewInfo2Slot(arg_58_2.layouts, var_58_0)
end

function var_0_0.onReceiveRougeRemoveItemBagPush(arg_59_0, arg_59_1, arg_59_2)
	if arg_59_1 ~= 0 then
		return
	end

	local var_59_0 = arg_59_2.season
	local var_59_1 = arg_59_2.ids

	RougeCollectionModel.instance:deleteSomeCollectionFromSlot(var_59_1)
end

function var_0_0.onReceiveRougeItemUpdatePush(arg_60_0, arg_60_1, arg_60_2)
	if arg_60_1 ~= 0 then
		return
	end

	local var_60_0 = arg_60_2.season
	local var_60_1 = arg_60_2.items

	RougeCollectionModel.instance:updateCollectionItems(var_60_1)
end

function var_0_0.sendRougeOneKeyAddToBarRequest(arg_61_0, arg_61_1)
	local var_61_0 = RougeModule_pb.RougeOneKeyAddToBarRequest()

	var_61_0.season = arg_61_1

	arg_61_0:sendMsg(var_61_0)
end

function var_0_0.onReceiveRougeOneKeyAddToBarReply(arg_62_0, arg_62_1, arg_62_2)
	if arg_62_1 ~= 0 then
		return
	end

	RougeStatController.instance:operateCollection(RougeStatController.operateType.Auto)
	RougeController.instance:dispatchEvent(RougeEvent.AdjustBackPack)
end

function var_0_0.sendRougeOneKeyRemoveFromBarRequest(arg_63_0, arg_63_1)
	local var_63_0 = RougeModule_pb.RougeOneKeyRemoveFromBarRequest()

	var_63_0.season = arg_63_1

	arg_63_0:sendMsg(var_63_0)
end

function var_0_0.onReceiveRougeItemLayoutEffectUpdatePush(arg_64_0, arg_64_1, arg_64_2)
	if arg_64_1 ~= 0 then
		return
	end

	local var_64_0 = {}

	for iter_64_0, iter_64_1 in ipairs(arg_64_2.updates) do
		local var_64_1 = tonumber(iter_64_1.id)
		local var_64_2 = iter_64_1.baseEffects
		local var_64_3 = iter_64_1.relations
		local var_64_4 = iter_64_1.attr
		local var_64_5 = RougeCollectionModel.instance:getCollectionByUid(var_64_1)

		if not var_64_5 then
			return
		end

		if not RougeCollectionModel.instance:isCollectionPlaceInSlotArea(var_64_1) then
			return
		end

		var_64_5:updateBaseEffects(var_64_2)
		var_64_5:updateEffectRelations(var_64_3)
		var_64_5:updateAttrValues(var_64_4)
		table.insert(var_64_0, var_64_5)
	end

	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.UpdateSlotCollectionEffect, var_64_0)
end

function var_0_0.onReceiveRougeItemEffectChangeItemPush(arg_65_0, arg_65_1, arg_65_2)
	if arg_65_1 ~= 0 then
		return
	end

	if not arg_65_0:_checkIsTriggerEffectChangeItem(arg_65_2) then
		return
	end

	local var_65_0 = RougeCollectionHelper.buildNewCollectionSlotMO(arg_65_2.trigger)
	local var_65_1 = RougeCollectionHelper.buildCollectionSlotMOs(arg_65_2.rmLayouts)
	local var_65_2 = {}
	local var_65_3 = {}
	local var_65_4 = tonumber(arg_65_2.showType)

	if arg_65_2.addToBag then
		for iter_65_0, iter_65_1 in ipairs(arg_65_2.addToBag) do
			table.insert(var_65_2, tonumber(iter_65_1))
		end
	end

	if arg_65_2.addToWarehouse then
		for iter_65_2, iter_65_3 in ipairs(arg_65_2.addToWarehouse) do
			table.insert(var_65_3, tonumber(iter_65_3))
		end
	end

	RougeCollectionModel.instance:saveTmpCollectionTriggerEffectInfo(var_65_0, var_65_1, var_65_2, var_65_3, var_65_4)
end

function var_0_0._checkIsTriggerEffectChangeItem(arg_66_0, arg_66_1)
	if not arg_66_1 then
		return false
	end

	local var_66_0 = arg_66_1.showType
	local var_66_1 = arg_66_1.rmLayouts

	if var_66_0 == RougeEnum.EffectTriggerType.Engulf or var_66_0 == RougeEnum.EffectTriggerType.LevelUp then
		return var_66_1 and #var_66_1 > 0
	end

	return true
end

function var_0_0.onReceiveRougeOneKeyRemoveFromBarReply(arg_67_0, arg_67_1, arg_67_2)
	if arg_67_1 ~= 0 then
		return
	end

	RougeCollectionModel.instance:onKeyClearSlotArea()
	RougeStatController.instance:operateCollection(RougeStatController.operateType.Clear)
	RougeController.instance:dispatchEvent(RougeEvent.AdjustBackPack)
end

function var_0_0.sendRougeComposeRequest(arg_68_0, arg_68_1, arg_68_2, arg_68_3)
	local var_68_0 = RougeModule_pb.RougeComposeRequest()

	var_68_0.season = arg_68_1
	var_68_0.composeId = arg_68_2

	if arg_68_3 then
		for iter_68_0, iter_68_1 in ipairs(arg_68_3) do
			var_68_0.consumeIds:append(iter_68_1)
		end
	end

	arg_68_0:sendMsg(var_68_0)
end

function var_0_0.onReceiveRougeComposeReply(arg_69_0, arg_69_1, arg_69_2)
	if arg_69_1 ~= 0 then
		return
	end

	local var_69_0 = arg_69_2.season
	local var_69_1 = arg_69_2.item
	local var_69_2 = arg_69_2.composeId

	RougeController.instance:dispatchEvent(RougeEvent.CompositeCollectionSucc)
end

function var_0_0.onReceiveRougeUpdateCoinPush(arg_70_0, arg_70_1, arg_70_2)
	if arg_70_1 ~= 0 then
		return
	end

	local var_70_0 = arg_70_2.coin

	RougeModel.instance:getRougeInfo().coin = var_70_0

	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateRougeInfoCoin)
end

function var_0_0.onReceiveRougeUpdatePowerPush(arg_71_0, arg_71_1, arg_71_2)
	if arg_71_1 ~= 0 then
		return
	end

	RougeModel.instance:updatePower(arg_71_2.power, arg_71_2.powerLimit)
end

function var_0_0.onReceiveRougeUpdateTalentPointPush(arg_72_0, arg_72_1, arg_72_2)
	if arg_72_1 ~= 0 then
		return
	end

	local var_72_0 = arg_72_2.talentPoint

	RougeModel.instance:getRougeInfo().talentPoint = var_72_0

	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateRougeInfoTalentPoint)
end

function var_0_0.onReceiveRougeUpdateTeamExpAndLevelPush(arg_73_0, arg_73_1, arg_73_2)
	if arg_73_1 ~= 0 then
		return
	end

	local var_73_0 = arg_73_2.teamLevel
	local var_73_1 = arg_73_2.teamExp
	local var_73_2 = arg_73_2.teamSize
	local var_73_3 = RougeModel.instance:getRougeInfo()
	local var_73_4 = var_73_3.teamLevel
	local var_73_5 = var_73_3.teamSize

	var_73_3.teamLevel = var_73_0
	var_73_3.teamExp = var_73_1
	var_73_3.teamSize = var_73_2

	if var_73_4 ~= var_73_0 and var_73_4 > 0 then
		RougePopController.instance:addPopViewWithViewName(ViewName.RougeLevelUpView, {
			preLv = var_73_4,
			curLv = var_73_0,
			preTeamSize = var_73_5,
			curTeamSize = var_73_2
		})
	end

	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateRougeInfoTeamValues)
end

function var_0_0.sendRougeAbortRequest(arg_74_0, arg_74_1, arg_74_2, arg_74_3)
	local var_74_0 = RougeModule_pb.RougeAbortRequest()

	var_74_0.season = arg_74_1 or RougeOutsideModel.instance:season()

	return arg_74_0:sendMsg(var_74_0, arg_74_2, arg_74_3)
end

function var_0_0.onReceiveRougeAbortReply(arg_75_0, arg_75_1, arg_75_2)
	if RougeModel.instance:getState() < RougeEnum.State.Start then
		RougeOutsideRpc.instance:sendGetRougeOutSideInfoRequest(RougeOutsideModel.instance:season())
		RougeModel.instance:clear()

		return
	end

	if arg_75_1 ~= 0 then
		return
	end

	RougeModel.instance:updateRougeInfo(arg_75_2.rougeInfo)
	RougeModel.instance:onAbortRouge()
end

function var_0_0.sendRougeEndRequest(arg_76_0, arg_76_1, arg_76_2)
	local var_76_0 = RougeModule_pb.RougeEndRequest()

	var_76_0.season = RougeModel.instance:getSeason() or 1

	return arg_76_0:sendMsg(var_76_0, arg_76_1, arg_76_2)
end

function var_0_0.onReceiveRougeEndReply(arg_77_0, arg_77_1, arg_77_2)
	if arg_77_1 ~= 0 then
		return
	end

	RougeOutsideRpc.instance:sendGetRougeOutSideInfoRequest(RougeOutsideModel.instance:season())

	local var_77_0 = arg_77_2.rougeInfo
	local var_77_1 = arg_77_2.resultInfo

	RougeModel.instance:updateRougeInfo(var_77_0)
	RougeModel.instance:updateResultInfo(var_77_1)

	if not RougeStatController.instance:checkIsReset() then
		RougeStatController.instance:statEnd()
	else
		RougeStatController.instance:statEnd(RougeStatController.EndResult.Abort)
	end
end

function var_0_0.sendActiveTalentRequest(arg_78_0, arg_78_1, arg_78_2, arg_78_3, arg_78_4)
	local var_78_0 = RougeModule_pb.ActiveTalentRequest()

	var_78_0.season = arg_78_1
	var_78_0.index = arg_78_2

	return arg_78_0:sendMsg(var_78_0, arg_78_3, arg_78_4)
end

function var_0_0.onReceiveActiveTalentReply(arg_79_0, arg_79_1, arg_79_2)
	if arg_79_1 ~= 0 then
		return
	end

	local var_79_0 = arg_79_2.rougeTalentTree

	RougeModel.instance:updateTalentInfo(var_79_0.rougeTalent)
end

function var_0_0.onReceiveRougeTeamHpUpdatePush(arg_80_0, arg_80_1, arg_80_2)
	if arg_80_1 ~= 0 then
		return
	end

	RougeModel.instance:updateTeamLifeAndDispatchEvent(arg_80_2.heroLifeList)
end

function var_0_0.sendRougeRepairShopBuyRequest(arg_81_0, arg_81_1, arg_81_2, arg_81_3)
	local var_81_0 = RougeModule_pb.RougeRepairShopBuyRequest()

	var_81_0.season = RougeModel.instance:getSeason() or 1
	var_81_0.collectionId = arg_81_1

	return arg_81_0:sendMsg(var_81_0, arg_81_2, arg_81_3)
end

function var_0_0.onReceiveRougeRepairShopBuyReply(arg_82_0, arg_82_1, arg_82_2)
	if arg_82_1 ~= 0 then
		return
	end

	local var_82_0 = arg_82_2.pieceInfo
	local var_82_1 = RougeMapModel.instance:getPieceMo(var_82_0.index)

	if var_82_1 then
		var_82_1:update(var_82_0)
	end
end

function var_0_0.sendRougeRepairShopRandomRequest(arg_83_0, arg_83_1, arg_83_2)
	local var_83_0 = RougeModule_pb.RougeRepairShopRandomRequest()

	var_83_0.season = RougeModel.instance:getSeason() or 1

	return arg_83_0:sendMsg(var_83_0, arg_83_1, arg_83_2)
end

function var_0_0.onReceiveRougeRepairShopRandomReply(arg_84_0, arg_84_1, arg_84_2)
	if arg_84_1 ~= 0 then
		return
	end

	local var_84_0 = arg_84_2.pieceInfo
	local var_84_1 = RougeMapModel.instance:getPieceMo(var_84_0.index)

	if var_84_1 then
		var_84_1:update(var_84_0)
	end
end

function var_0_0.sendRougeDisplaceRequest(arg_85_0, arg_85_1, arg_85_2, arg_85_3)
	local var_85_0 = RougeModule_pb.RougeDisplaceRequest()

	var_85_0.season = RougeModel.instance:getSeason() or 1
	var_85_0.collectionId = arg_85_1

	return arg_85_0:sendMsg(var_85_0, arg_85_2, arg_85_3)
end

function var_0_0.onReceiveRougeDisplaceReply(arg_86_0, arg_86_1, arg_86_2)
	if arg_86_1 ~= 0 then
		return
	end

	local var_86_0 = arg_86_2.pieceInfo
	local var_86_1 = RougeMapModel.instance:getPieceMo(var_86_0.index)

	if var_86_1 then
		var_86_1:update(var_86_0)
	end
end

function var_0_0.onReceiveRougeTriggerEffectPush(arg_87_0, arg_87_1, arg_87_2)
	if arg_87_1 ~= 0 then
		return
	end

	RougeMapTipPopController.instance:addPopTipByEffect(arg_87_2.effect)
end

function var_0_0.sendRougeRandomDropRequest(arg_88_0, arg_88_1, arg_88_2)
	local var_88_0 = RougeModule_pb.RougeRandomDropRequest()

	var_88_0.season = RougeModel.instance:getSeason() or 1

	return arg_88_0:sendMsg(var_88_0, arg_88_1, arg_88_2)
end

function var_0_0.onReceiveRougeRandomDropReply(arg_89_0, arg_89_1, arg_89_2)
	if arg_89_1 ~= 0 then
		return
	end

	RougeMapModel.instance:updateMapInfo(arg_89_2.map)
end

function var_0_0.sendRougeMonsterFixAttrRequest(arg_90_0, arg_90_1, arg_90_2, arg_90_3)
	local var_90_0 = RougeModule_pb.RougeMonsterFixAttrRequest()

	var_90_0.season = arg_90_1

	return arg_90_0:sendMsg(var_90_0, arg_90_2, arg_90_3)
end

function var_0_0.onReceiveRougeMonsterFixAttrReply(arg_91_0, arg_91_1, arg_91_2)
	if arg_91_1 ~= 0 then
		return
	end

	local var_91_0 = arg_91_2.season
	local var_91_1 = arg_91_2.fixHpRate
end

function var_0_0.onReceiveRougeTeamInfoPush(arg_92_0, arg_92_1, arg_92_2)
	if arg_92_1 ~= 0 then
		return
	end

	local var_92_0 = arg_92_2.teamInfo

	RougeModel.instance:updateTeamInfo(var_92_0)
end

function var_0_0.sendRougeUseMapSkillRequest(arg_93_0, arg_93_1, arg_93_2, arg_93_3, arg_93_4)
	local var_93_0 = RougeModule_pb.RougeUseMapSkillRequest()

	var_93_0.season = arg_93_1
	var_93_0.mapSkillId = arg_93_2

	return arg_93_0:sendMsg(var_93_0, arg_93_3, arg_93_4)
end

function var_0_0.onReceiveRougeUseMapSkillReply(arg_94_0, arg_94_1, arg_94_2)
	if arg_94_1 ~= 0 then
		return
	end

	local var_94_0 = arg_94_2.season
	local var_94_1 = arg_94_2.mapSkill

	RougeMapModel.instance:onUpdateMapSkillInfo(var_94_1)
	RougeStatController.instance:trackUseMapSkill(var_94_1.id)
end

function var_0_0.sendRougeUnlockSkillRequest(arg_95_0, arg_95_1, arg_95_2, arg_95_3, arg_95_4)
	local var_95_0 = RougeModule_pb.RougeUnlockSkillRequest()

	var_95_0.season = arg_95_1
	var_95_0.skillId = arg_95_2

	return arg_95_0:sendMsg(var_95_0, arg_95_3, arg_95_4)
end

function var_0_0.onReceiveRougeUnlockSkillReply(arg_96_0, arg_96_1, arg_96_2)
	if arg_96_1 ~= 0 then
		return
	end

	local var_96_0 = arg_96_2.season
	local var_96_1 = arg_96_2.skillId
end

function var_0_0.sendRougeItemTrammelsRequest(arg_97_0, arg_97_1, arg_97_2, arg_97_3)
	local var_97_0 = RougeModule_pb.RougeItemTrammelsRequest()

	var_97_0.season = arg_97_1

	return arg_97_0:sendMsg(var_97_0, arg_97_2, arg_97_3)
end

function var_0_0.onReceiveRougeItemTrammelsReply(arg_98_0, arg_98_1, arg_98_2)
	if arg_98_1 ~= 0 then
		return
	end
end

function var_0_0.sendRougeSelectCollectionLevelUpRequest(arg_99_0, arg_99_1, arg_99_2, arg_99_3, arg_99_4)
	local var_99_0 = RougeModule_pb.RougeSelectCollectionLevelUpRequest()

	var_99_0.season = arg_99_1

	if arg_99_2 then
		for iter_99_0, iter_99_1 in ipairs(arg_99_2) do
			var_99_0.collectionUid:append(iter_99_1)
		end
	end

	return arg_99_0:sendMsg(var_99_0, arg_99_3, arg_99_4)
end

function var_0_0.onReceiveRougeSelectCollectionLevelUpReply(arg_100_0, arg_100_1, arg_100_2)
	if arg_100_1 ~= 0 then
		return
	end

	RougeMapModel.instance:updateMapInfo(arg_100_2.map)
end

function var_0_0.sendRougeRefreshMapRuleRequest(arg_101_0, arg_101_1, arg_101_2)
	local var_101_0 = RougeModule_pb.RougeRefreshMapRuleRequest()

	var_101_0.season = arg_101_1
	var_101_0.layer = arg_101_2

	arg_101_0:sendMsg(var_101_0)
end

function var_0_0.onReceiveRougeRefreshMapRuleReply(arg_102_0, arg_102_1, arg_102_2)
	if arg_102_1 ~= 0 then
		return
	end

	RougeMapModel.instance:updateMapInfo(arg_102_2.map)
end

function var_0_0.sendRougeRefreshMonsterRuleRequest(arg_103_0, arg_103_1, arg_103_2)
	local var_103_0 = RougeModule_pb.RougeRefreshMonsterRuleRequest()

	var_103_0.season = arg_103_1
	var_103_0.index = arg_103_2

	arg_103_0:sendMsg(var_103_0)
end

function var_0_0.onReceiveRougeRefreshMonsterRuleReply(arg_104_0, arg_104_1, arg_104_2)
	if arg_104_1 ~= 0 then
		return
	end

	RougeMapModel.instance:updateMapInfo(arg_104_2.map)
end

var_0_0.instance = var_0_0.New()

return var_0_0
