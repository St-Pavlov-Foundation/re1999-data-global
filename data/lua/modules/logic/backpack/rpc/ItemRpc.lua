module("modules.logic.backpack.rpc.ItemRpc", package.seeall)

local var_0_0 = class("ItemRpc", BaseRpc)

function var_0_0.sendUseItemRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	logNormal("Send Use Item Request !")

	local var_1_0 = ItemModule_pb.UseItemRequest()

	for iter_1_0, iter_1_1 in ipairs(arg_1_1) do
		local var_1_1 = MaterialModule_pb.M2QEntry()

		var_1_1.materialId = iter_1_1.materialId
		var_1_1.quantity = iter_1_1.quantity

		table.insert(var_1_0.entry, var_1_1)
	end

	var_1_0.targetId = arg_1_2

	arg_1_0:sendMsg(var_1_0, arg_1_3, arg_1_4)
end

function var_0_0.onReceiveUseItemReply(arg_2_0, arg_2_1, arg_2_2)
	logNormal("Receive Use Item Reply Result Code : " .. arg_2_1)
	StoreController.instance:onUseItemInStore(arg_2_2)
end

function var_0_0.onReceiveItemChangePush(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == 0 then
		ItemModel.instance:changeItemList(arg_3_2.items)
		ItemPowerModel.instance:changePowerItemList(arg_3_2.powerItems)
		ItemInsightModel.instance:changeInsightItemList(arg_3_2.insightItems)
		BackpackController.instance:dispatchEvent(BackpackEvent.UpdateItemList)
		RedDotController.instance:dispatchEvent(RedDotEvent.RefreshClientCharacterDot)
	end
end

function var_0_0.sendGetItemListRequest(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = ItemModule_pb.GetItemListRequest()

	return arg_4_0:sendMsg(var_4_0, arg_4_1, arg_4_2)
end

function var_0_0.onReceiveGetItemListReply(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 == 0 then
		ItemModel.instance:setItemList(arg_5_2.items)
		ItemModel.instance:setOptionalGift()
		ItemPowerModel.instance:setPowerItemList(arg_5_2.powerItems)
		ItemInsightModel.instance:setInsightItemList(arg_5_2.insightItems)
		BackpackController.instance:dispatchEvent(BackpackEvent.UpdateItemList)
	end
end

function var_0_0.sendUsePowerItemRequest(arg_6_0, arg_6_1)
	local var_6_0 = ItemModule_pb.UsePowerItemRequest()

	var_6_0.uid = arg_6_1

	arg_6_0:sendMsg(var_6_0)
end

function var_0_0.onReceiveUsePowerItemReply(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 ~= 0 then
		return
	end

	BackpackController.instance:dispatchEvent(BackpackEvent.UsePowerPotionFinish, arg_7_2.uid)
end

function var_0_0.sendUsePowerItemListRequest(arg_8_0, arg_8_1)
	local var_8_0 = ItemModule_pb.UsePowerItemListRequest()

	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		local var_8_1 = ItemModule_pb.UsePowerItemInfo()

		var_8_1.uid = iter_8_1.uid
		var_8_1.num = iter_8_1.num

		table.insert(var_8_0.usePowerItemInfo, var_8_1)
	end

	arg_8_0:sendMsg(var_8_0)
end

function var_0_0.onReceiveUsePowerItemListReply(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 ~= 0 then
		return
	end

	BackpackController.instance:dispatchEvent(BackpackEvent.UsePowerPotionListFinish, arg_9_2.usePowerItemInfo)
end

function var_0_0.sendAutoUseExpirePowerItemRequest(arg_10_0, arg_10_1)
	local var_10_0 = ItemModule_pb.AutoUseExpirePowerItemRequest()

	return arg_10_0:sendMsg(var_10_0, arg_10_1)
end

function var_0_0.onReceiveAutoUseExpirePowerItemReply(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 ~= 0 then
		return
	end

	if arg_11_2.used then
		GameFacade.showToast(ToastEnum.AutoUsseExpirePowerItem)
	end
end

function var_0_0.sendMarkReadSubType21Request(arg_12_0, arg_12_1)
	local var_12_0 = ItemModule_pb.MarkReadSubType21Request()

	var_12_0.itemId = arg_12_1

	return arg_12_0:sendMsg(var_12_0)
end

function var_0_0.onReceiveMarkReadSubType21Reply(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 ~= 0 then
		return
	end
end

function var_0_0.sendUseInsightItemRequest(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	local var_14_0 = ItemModule_pb.UseInsightItemRequest()

	arg_14_0._startRank = HeroModel.instance:getByHeroId(arg_14_2).rank
	var_14_0.uid = arg_14_1
	var_14_0.heroId = arg_14_2

	arg_14_0:sendMsg(var_14_0, arg_14_3, arg_14_4)
end

function var_0_0.onReceiveUseInsightItemReply(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 ~= 0 then
		return
	end

	BackpackController.instance:dispatchEvent(BackpackEvent.UseInsightItemFinished, arg_15_2.uid, arg_15_2.heroId)
	CharacterController.instance:dispatchEvent(CharacterEvent.successHeroRankUp)
	RedDotController.instance:dispatchEvent(RedDotEvent.RefreshClientCharacterDot)

	local var_15_0 = {
		heroId = arg_15_2.heroId
	}

	var_15_0.newRank = HeroModel.instance:getByHeroId(var_15_0.heroId).rank
	var_15_0.startRank = arg_15_0._startRank
	var_15_0.isRank = true

	PopupController.instance:addPopupView(PopupEnum.PriorityType.GainCharacterView, ViewName.CharacterGetView, var_15_0)
end

function var_0_0.simpleSendUseItemRequest(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5)
	if not arg_16_2 or arg_16_2 <= 0 then
		return
	end

	arg_16_0:sendUseItemRequest({
		{
			materialId = arg_16_1,
			quantity = arg_16_2
		}
	}, arg_16_3 or 0, arg_16_4, arg_16_5)
end

var_0_0.instance = var_0_0.New()

return var_0_0
