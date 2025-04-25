module("modules.logic.store.view.recommend.StoreSkinBagView", package.seeall)

slot0 = class("StoreSkinBagView", GiftrecommendViewBase)

function slot0._getCostSymbolAndPrice(slot0, slot1)
	if not slot1 or slot1 == "" then
		return
	end

	if type(string.splitToNumber(slot1, "#")) ~= "table" and #slot2 < 2 then
		return
	end

	slot3 = slot2[2]
	slot5, slot6, slot7 = PayModel.instance:getProductOriginPriceNum(slot3)

	return PayModel.instance:getProductOriginPriceSymbol(slot3), slot6
end

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "view/#simage_bg")
	slot0._txtdurationTime = gohelper.findChildText(slot0.viewGO, "view/time/#txt_durationTime")
	slot0._btnbuy = gohelper.findChildButtonWithAudio(slot0.viewGO, "view/#btn_buy")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnbuy:AddClickListener(slot0._btnbuyOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnbuy:RemoveClickListener()
end

function slot0._btnbuyOnClick(slot0)
	StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store,
		[StatEnum.EventProperties.RecommendPageId] = tostring(slot0.config and slot0.config.id or ""),
		[StatEnum.EventProperties.RecommendPageName] = slot0.config and slot0.config.name or "StoreSkinBagView"
	})
	GameFacade.jumpByAdditionParam(slot0.config.systemJumpCode)
end

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)

	slot0._pricetxtnum = gohelper.findChildText(slot0.viewGO, "view/pricetxt/pricetxtnum")
	slot0._pricetxticon = gohelper.findChildText(slot0.viewGO, "view/pricetxt/pricetxtnum/pricetxticon")
	slot1, slot2 = slot0:_getCostSymbolAndPrice(slot0.config.systemJumpCode)
	slot0._pricetxtnum.text = ""
	slot0._pricetxticon.text = ""

	if not string.nilorempty(slot1) then
		slot0._pricetxticon.text = slot1
	end

	if not string.nilorempty(slot2) then
		slot0._pricetxtnum.text = slot2
	end
end

function slot0.onOpen(slot0)
	slot0.config = slot0.config or StoreConfig.instance:getStoreRecommendConfig(StoreEnum.RecommendSubStoreId.StoreSkinBagView)

	uv0.super.onOpen(slot0)
end

function slot0.onClose(slot0)
	uv0.super.onClose(slot0)
end

function slot0.refreshUI(slot0)
	slot0._txtdurationTime.text = StoreController.instance:getRecommendStoreTime(slot0.config)
end

function slot0.onDestroyView(slot0)
	uv0.super.onDestroyView(slot0)
end

return slot0
