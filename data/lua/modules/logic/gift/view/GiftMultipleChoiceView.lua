module("modules.logic.gift.view.GiftMultipleChoiceView", package.seeall)

slot0 = class("GiftMultipleChoiceView", BaseView)

function slot0.onInitView(slot0)
	slot0._scrollitem = gohelper.findChildScrollRect(slot0.viewGO, "root/#scroll_item")
	slot0._btnok = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_ok")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_close")
	slot0._txtquantity = gohelper.findChildText(slot0.viewGO, "root/quantity/#txt_quantity")
	slot0._simagebg1 = gohelper.findChildSingleImage(slot0.viewGO, "root/bg/#simage_bg1")
	slot0._simagebg2 = gohelper.findChildSingleImage(slot0.viewGO, "root/bg/#simage_bg2")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnok:AddClickListener(slot0._btnokOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnok:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
end

function slot0._btnokOnClick(slot0)
	if GiftModel.instance:getMultipleChoiceIndex() == 0 then
		GameFacade.showToast(ToastEnum.GiftMultipleChoice)
	else
		slot0:closeThis()

		slot2 = {}

		table.insert(slot2, {
			materialId = slot0.viewParam.param.id,
			quantity = slot0.viewParam.quantity
		})
		ItemRpc.instance:sendUseItemRequest(slot2, slot1 - 1)
	end
end

function slot0._btncloseClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._contentGrid = gohelper.findChild(slot0.viewGO, "root/#scroll_item/itemcontent"):GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))

	slot0._simagebg1:LoadImage(ResUrl.getCommonIcon("bg_1"))
	slot0._simagebg2:LoadImage(ResUrl.getCommonIcon("bg_2"))
end

function slot0.onOpen(slot0)
	slot0:_setPropItems()

	slot0._txtquantity.text = slot0.viewParam.quantity
end

function slot0.onClose(slot0)
	GiftModel.instance:reset()
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0._setPropItems(slot0)
	slot1 = {}
	slot0._contentGrid.enabled = #string.split(ItemModel.instance:getItemConfig(slot0.viewParam.param.type, slot0.viewParam.param.id).effect, "|") < 6

	for slot6, slot7 in ipairs(slot2) do
		slot8 = MaterialDataMO.New()
		slot9 = string.split(slot7, "#")
		slot8.index = slot6
		slot8.materilType = tonumber(slot9[1])
		slot8.materilId = tonumber(slot9[2])
		slot8.quantity = slot0.viewParam.quantity * tonumber(slot9[3])

		if GiftModel.instance:isGiftNeed(slot8.materilId) then
			GiftModel.instance:setMultipleChoiceIndex(slot8.index)
		end

		table.insert(slot1, slot8)
	end

	GiftMultipleChoiceListModel.instance:setPropList(slot1)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg1:UnLoadImage()
	slot0._simagebg2:UnLoadImage()
end

return slot0
