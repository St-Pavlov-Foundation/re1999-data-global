module("modules.logic.backpack.rpc.ItemRpc", package.seeall)

slot0 = class("ItemRpc", BaseRpc)

function slot0.sendUseItemRequest(slot0, slot1, slot2, slot3, slot4)
	logNormal("Send Use Item Request !")

	slot5 = ItemModule_pb.UseItemRequest()

	for slot9, slot10 in ipairs(slot1) do
		slot11 = MaterialModule_pb.M2QEntry()
		slot11.materialId = slot10.materialId
		slot11.quantity = slot10.quantity

		table.insert(slot5.entry, slot11)
	end

	slot5.targetId = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveUseItemReply(slot0, slot1, slot2)
	logNormal("Receive Use Item Reply Result Code : " .. slot1)
	StoreController.instance:onUseItemInStore(slot2)
end

function slot0.onReceiveItemChangePush(slot0, slot1, slot2)
	if slot1 == 0 then
		ItemModel.instance:changeItemList(slot2.items)
		ItemPowerModel.instance:changePowerItemList(slot2.powerItems)
		ItemInsightModel.instance:changeInsightItemList(slot2.insightItems)
		BackpackController.instance:dispatchEvent(BackpackEvent.UpdateItemList)
		RedDotController.instance:dispatchEvent(RedDotEvent.RefreshClientCharacterDot)
	end
end

function slot0.sendGetItemListRequest(slot0, slot1, slot2)
	return slot0:sendMsg(ItemModule_pb.GetItemListRequest(), slot1, slot2)
end

function slot0.onReceiveGetItemListReply(slot0, slot1, slot2)
	if slot1 == 0 then
		ItemModel.instance:setItemList(slot2.items)
		ItemModel.instance:setOptionalGift()
		ItemPowerModel.instance:setPowerItemList(slot2.powerItems)
		ItemInsightModel.instance:setInsightItemList(slot2.insightItems)
		BackpackController.instance:dispatchEvent(BackpackEvent.UpdateItemList)
	end
end

function slot0.sendUsePowerItemRequest(slot0, slot1)
	slot2 = ItemModule_pb.UsePowerItemRequest()
	slot2.uid = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveUsePowerItemReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	BackpackController.instance:dispatchEvent(BackpackEvent.UsePowerPotionFinish, slot2.uid)
end

function slot0.sendUsePowerItemListRequest(slot0, slot1)
	slot2 = ItemModule_pb.UsePowerItemListRequest()

	for slot6, slot7 in ipairs(slot1) do
		slot8 = ItemModule_pb.UsePowerItemInfo()
		slot8.uid = slot7.uid
		slot8.num = slot7.num

		table.insert(slot2.usePowerItemInfo, slot8)
	end

	slot0:sendMsg(slot2)
end

function slot0.onReceiveUsePowerItemListReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	BackpackController.instance:dispatchEvent(BackpackEvent.UsePowerPotionListFinish, slot2.usePowerItemInfo)
end

function slot0.sendAutoUseExpirePowerItemRequest(slot0, slot1)
	return slot0:sendMsg(ItemModule_pb.AutoUseExpirePowerItemRequest(), slot1)
end

function slot0.onReceiveAutoUseExpirePowerItemReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	if slot2.used then
		GameFacade.showToast(ToastEnum.AutoUsseExpirePowerItem)
	end
end

function slot0.sendMarkReadSubType21Request(slot0, slot1)
	slot2 = ItemModule_pb.MarkReadSubType21Request()
	slot2.itemId = slot1

	return slot0:sendMsg(slot2)
end

function slot0.onReceiveMarkReadSubType21Reply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end
end

function slot0.sendUseInsightItemRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = ItemModule_pb.UseInsightItemRequest()
	slot0._startRank = HeroModel.instance:getByHeroId(slot2).rank
	slot5.uid = slot1
	slot5.heroId = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveUseInsightItemReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	BackpackController.instance:dispatchEvent(BackpackEvent.UseInsightItemFinished, slot2.uid, slot2.heroId)
	CharacterController.instance:dispatchEvent(CharacterEvent.successHeroRankUp)
	RedDotController.instance:dispatchEvent(RedDotEvent.RefreshClientCharacterDot)

	slot3 = {
		heroId = slot2.heroId
	}
	slot3.newRank = HeroModel.instance:getByHeroId(slot3.heroId).rank
	slot3.startRank = slot0._startRank
	slot3.isRank = true

	PopupController.instance:addPopupView(PopupEnum.PriorityType.GainCharacterView, ViewName.CharacterGetView, slot3)
end

function slot0.simpleSendUseItemRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	if not slot2 or slot2 <= 0 then
		return
	end

	slot0:sendUseItemRequest({
		{
			materialId = slot1,
			quantity = slot2
		}
	}, slot3 or 0, slot4, slot5)
end

slot0.instance = slot0.New()

return slot0
