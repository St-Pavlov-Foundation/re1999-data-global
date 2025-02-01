module("modules.logic.store.view.recommend.GiftrecommendViewBase", package.seeall)

slot0 = class("GiftrecommendViewBase", StoreRecommendBaseSubView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "view/#simage_bg")
	slot0._txtduration = gohelper.findChildText(slot0.viewGO, "view/txt_tips/#txt_duration")
	slot0._txtprice1 = gohelper.findChildText(slot0.viewGO, "view/left/#txt_price1")
	slot0._btnbuy1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "view/left/#btn_buy1")
	slot0._txtprice2 = gohelper.findChildText(slot0.viewGO, "view/middle/#txt_price2")
	slot0._btnbuy2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "view/middle/#btn_buy2")
	slot0._txtprice3 = gohelper.findChildText(slot0.viewGO, "view/right/#txt_price3")
	slot0._btnbuy3 = gohelper.findChildButtonWithAudio(slot0.viewGO, "view/right/#btn_buy3")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnbuy1:AddClickListener(slot0._btnbuy1OnClick, slot0)
	slot0._btnbuy2:AddClickListener(slot0._btnbuy2OnClick, slot0)
	slot0._btnbuy3:AddClickListener(slot0._btnbuy3OnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnbuy1:RemoveClickListener()
	slot0._btnbuy2:RemoveClickListener()
	slot0._btnbuy3:RemoveClickListener()
end

function slot0._btnbuy1OnClick(slot0)
	if slot0._isBought1 then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)

		return
	end

	if slot0._systemJumpCode1 then
		slot0:statClick()

		if StoreConfig.instance:getChargeGoodsConfig(string.splitToNumber(slot0._systemJumpCode1, "#")[2]) and slot2.type == StoreEnum.StoreChargeType.Optional then
			module_views_preloader.OptionalChargeView(function ()
				GameFacade.jumpByAdditionParam(uv0._systemJumpCode1)
			end)
		else
			GameFacade.jumpByAdditionParam(slot0._systemJumpCode1)
		end
	end
end

function slot0._btnbuy2OnClick(slot0)
	if slot0._isBought2 then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)

		return
	end

	if slot0._systemJumpCode2 then
		slot0:statClick()
		GameFacade.jumpByAdditionParam(slot0._systemJumpCode2)
	end
end

function slot0._btnbuy3OnClick(slot0)
	if slot0._isBought3 then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)

		return
	end

	if slot0._systemJumpCode3 then
		slot0:statClick()
		GameFacade.jumpByAdditionParam(slot0._systemJumpCode3)
	end
end

function slot0.statClick(slot0)
	StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store,
		[StatEnum.EventProperties.RecommendPageId] = tostring(slot0.config and slot0.config.id or ""),
		[StatEnum.EventProperties.RecommendPageName] = slot0.config and slot0.config.name or slot0.__cname
	})
end

function slot0._getCostSymbolAndPrice(slot0, slot1)
	if not slot1 or slot1 == "" then
		return
	end

	if type(string.splitToNumber(slot1, "#")) ~= "table" and #slot2 < 2 then
		return
	end

	return PayModel.instance:getProductPrice(slot2[2]), ""
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

function slot0._editableInitView(slot0)
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._animatorPlayer = SLFramework.AnimatorPlayer.Get(slot0.viewGO)
end

function slot0.onOpen(slot0)
	uv0.super.onOpen(slot0)
	slot0:addEventCb(StoreController.instance, StoreEvent.UpdatePackageStore, slot0.refreshUI, slot0)
	slot0:addEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, slot0.refreshUI, slot0)
	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0._txtprice1.text = ""
	slot0._txtprice2.text = ""
	slot0._txtprice3.text = ""

	if slot0.config == nil then
		return
	end

	if string.split(slot0.config.systemJumpCode, " ") then
		slot0._systemJumpCode1 = slot1[1]
		slot0._systemJumpCode2 = slot1[2]
		slot0._systemJumpCode3 = slot1[3]
		slot2, slot3 = slot0:_getCostSymbolAndPrice(slot1[1])

		if slot2 then
			slot0._txtprice1.text = string.format("%s%s", slot2, slot3)
		end

		slot4, slot5 = slot0:_getCostSymbolAndPrice(slot1[2])

		if slot4 then
			slot0._txtprice2.text = string.format("%s%s", slot4, slot5)
		end

		slot6, slot7 = slot0:_getCostSymbolAndPrice(slot1[3])

		if slot6 then
			slot0._txtprice3.text = string.format("%s%s", slot6, slot7)
		end
	end

	if not string.nilorempty(slot0.config.relations) and type(GameUtil.splitString2(slot0.config.relations, true)) == "table" then
		slot0._isBought1 = slot0:_getIsBought(slot2[1])
		slot0._isBought2 = slot0:_getIsBought(slot2[2])
		slot0._isBought3 = slot0:_getIsBought(slot2[3])
	end

	slot0._txtduration.text = StoreController.instance:getRecommendStoreTime(slot0.config)
end

function slot0.onClose(slot0)
	slot0:removeEventCb(StoreController.instance, StoreEvent.UpdatePackageStore, slot0.refreshUI, slot0)
	slot0:removeEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, slot0.refreshUI, slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
