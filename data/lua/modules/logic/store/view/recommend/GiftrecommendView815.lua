module("modules.logic.store.view.recommend.GiftrecommendView815", package.seeall)

slot0 = class("GiftrecommendView815", StoreRecommendBaseSubView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "view/#simage_bg")
	slot0._txtduration = gohelper.findChildText(slot0.viewGO, "view/txt_tips/#txt_duration")
	slot0._txtprice3 = gohelper.findChildText(slot0.viewGO, "view/right/#txt_price3")
	slot0._btnbuy3 = gohelper.findChildButtonWithAudio(slot0.viewGO, "view/right/#btn_buy3")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnbuy3:AddClickListener(slot0._btnbuy3OnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnbuy3:RemoveClickListener()
end

function slot0._btnbuy3OnClick(slot0)
	if slot0._isBought3 then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)

		return
	end

	if slot0._systemJumpCode3 then
		GameFacade.jumpByAdditionParam(slot0._systemJumpCode3)
	end
end

function slot0._getIsBought(slot0, slot1)
	if not slot1 then
		return false
	end

	slot3 = slot1[2]

	if not slot1[1] or not slot3 then
		return false
	end

	if StoreModel.instance:getGoodsMO(slot3) == nil or slot4:isSoldOut() then
		return true
	end

	return false
end

function slot0.onOpen(slot0)
	uv0.super.onOpen(slot0)
	slot0:_refreshUI()
	slot0:addEventCb(StoreController.instance, StoreEvent.UpdatePackageStore, slot0._refreshUI, slot0)
	slot0:addEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, slot0._refreshUI, slot0)
end

function slot0._refreshUI(slot0)
	slot0._txtprice3.text = ""

	if slot0.config == nil then
		return
	end

	slot0._systemJumpCode3 = slot0.config.systemJumpCode

	if slot0._systemJumpCode3 and slot0:_getCostSymbolAndPrice(slot0._systemJumpCode3) then
		slot0._txtprice3.text = slot1
	end

	if not string.nilorempty(slot0.config.relations) and type(GameUtil.splitString2(slot0.config.relations, true)) == "table" then
		slot0._isBought3 = slot0:_getIsBought(slot1[3])
	end

	slot0._txtduration.text = StoreController.instance:getRecommendStoreTime(slot0.config)
end

function slot0._getCostSymbolAndPrice(slot0, slot1)
	if not slot1 or slot1 == "" then
		return
	end

	if type(string.splitToNumber(slot1, "#")) ~= "table" and #slot2 < 2 then
		return
	end

	slot3 = slot2[2]
	slot5, slot6 = PayModel.instance:getProductOriginPriceNum(slot3)
	slot7 = ""

	if string.nilorempty(PayModel.instance:getProductOriginPriceSymbol(slot3)) then
		slot8 = string.reverse(slot6)
		slot9 = string.len(slot8) - string.find(slot8, "%d") + 1

		return string.format("%s<size=50>%s</size>", string.sub(slot6, 1, slot9), string.sub(slot6, slot9 + 1, string.len(slot6)))
	else
		return string.format("<size=50>%s</size>%s", slot4, slot6)
	end
end

function slot0.onClose(slot0)
	uv0.super.onClose(slot0)
	slot0:removeEventCb(StoreController.instance, StoreEvent.UpdatePackageStore, slot0._refreshUI, slot0)
	slot0:removeEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, slot0._refreshUI, slot0)
end

return slot0
