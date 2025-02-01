module("modules.logic.gift.view.OptionalGiftMultipleChoiceView", package.seeall)

slot0 = class("OptionalGiftMultipleChoiceView", GiftMultipleChoiceView)

function slot0._btnokOnClick(slot0)
	if GiftModel.instance:getMultipleChoiceIndex() == 0 then
		GameFacade.showToast(ToastEnum.GiftMultipleChoice)
	else
		slot0:closeThis()

		slot3 = {}

		table.insert(slot3, {
			materialId = slot0.viewParam.param.id,
			quantity = slot0.viewParam.quantity
		})
		ItemRpc.instance:sendUseItemRequest(slot3, GiftModel.instance:getMultipleChoiceId())
	end
end

function slot0._setPropItems(slot0)
	slot1 = {}
	slot0.giftIds = GiftMultipleChoiceListModel.instance:getOptionalGiftIdList(slot0.viewParam.param.id)
	slot0._contentGrid.enabled = #slot0.giftIds < 6

	for slot5, slot6 in ipairs(slot0.giftIds) do
		slot7 = MaterialDataMO.New()
		slot7.index = slot5
		slot7.materilType = 1
		slot7.materilId = slot6
		slot7.quantity = slot0.viewParam.quantity * 1

		if GiftModel.instance:isGiftNeed(slot7.materilId) then
			GiftModel.instance:setMultipleChoiceIndex(slot5)
			GiftModel.instance:setMultipleChoiceId(slot6)
		end

		table.insert(slot1, slot7)
	end

	GiftMultipleChoiceListModel.instance:setPropList(slot1)
end

return slot0
