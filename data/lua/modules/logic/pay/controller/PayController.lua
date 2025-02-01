module("modules.logic.pay.controller.PayController", package.seeall)

slot0 = class("PayController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
	SDKMgr.instance:setPayCallBack(slot0._onPayCallback, slot0)
	SDKMgr.instance:setQueryProductDetailsCallBack(slot0._onQueryProductDetailsCallBack, slot0)
	slot0:registerCallback(PayEvent.GetSignSuccess, slot0._onGetSignSuccess, slot0)
	slot0:registerCallback(PayEvent.GetSignFailed, slot0._onGetSignFailed, slot0)
	slot0:registerCallback(PayEvent.PayFinished, slot0._onPayFinished, slot0)
	slot0:registerCallback(PayEvent.PayFailed, slot0._onPayFailed, slot0)
end

function slot0.startPay(slot0, slot1, slot2)
	if MinorsController.instance:isPayLimit() then
		ViewMgr.instance:openView(ViewName.DateOfBirthSelectionView)

		return
	end

	if SLFramework.FrameworkSettings.IsEditor and PayModel.instance:getSandboxEnable() ~= true then
		return
	end

	UIBlockMgr.instance:startBlock("charging")
	ChargeRpc.instance:sendNewOrderRequest(slot1, slot2)
end

function slot0._onGetSignSuccess(slot0)
	UIBlockMgr.instance:endBlock("charging")

	slot1 = StatModel.instance:getPayInfo()

	if PayModel.instance:getSandboxEnable() then
		ViewMgr.instance:openView(ViewName.SDKSandboxPayView, {
			payInfo = PayModel.instance:getGamePayInfo()
		})
	else
		SDKMgr.instance:payGoods(slot1)
	end
end

function slot0._onGetSignFailed(slot0)
	UIBlockMgr.instance:endBlock("charging")
	PayModel.instance:clearOrderInfo()
end

function slot0._onPayFinished(slot0, slot1)
	TaskDispatcher.cancelTask(slot0._payFinishedPushTimeout, slot0)
	slot0:_hidePayFinishBlock()
	PayModel.instance:clearOrderInfo()
	SDKChannelEventModel.instance:purchase(slot1)

	if StoreConfig.instance:getChargeGoodsConfig(slot1) then
		if SLFramework.FrameworkSettings.IsEditor then
			-- Nothing
		else
			slot3.productId = StoreConfig.instance:getStoreChargeConfig(slot1, BootNativeUtil.getPackageName()).appStoreProductID
		end

		if SDKMediaEventEnum.PurchaseIdMediaEvent[slot1] then
			SDKDataTrackMgr.instance:trackMediaPayEvent(SDKMediaEventEnum.PurchaseIdMediaEvent[slot1], slot3)
		elseif slot2 and slot2.storeId == StoreEnum.StoreId.Skin then
			SDKDataTrackMgr.instance:trackMediaPayEvent(SDKDataTrackMgr.MediaEvent.purchase_skin, slot3)
		end

		SDKDataTrackMgr.instance:trackMediaPayEvent(SDKDataTrackMgr.MediaEvent.purchase, {
			amount = StoreConfig.instance:getChargeGoodsPrice(slot1),
			currency = StoreConfig.instance:getChargeGoodsCurrencyCode(slot1),
			productId = "",
			goodsName = slot2.name,
			goodsId = slot1
		})
	end
end

function slot0._onPayFailed(slot0)
	PayModel.instance:clearOrderInfo()
end

function slot0.getAllQueryProductDetails(slot0, slot1, slot2)
	if PayModel.instance:hasInitProductInfo() then
		if slot1 then
			slot1(slot2)
		end

		slot0:clearAllQueryProductDetailsCallBack()

		return
	end

	slot4 = {}

	for slot8, slot9 in pairs(StoreConfig.instance:getAllChargeGoodsConfig()) do
		if StoreConfig.instance:getStoreChargeConfig(slot9.id, BootNativeUtil.getPackageName(), true) then
			table.insert(slot4, slot10.appStoreProductID)
		end
	end

	slot0._queryProductDetailsCallBack = slot1
	slot0._queryProductDetailsCallBackObj = slot2

	SDKMgr.instance:queryProductDetailEntity("inapp", slot4)
end

function slot0._onQueryProductDetailsCallBack(slot0, slot1, slot2)
	if slot1 == PayEnum.PayResultCode.PayFinish then
		slot3 = nil
		slot3 = BootNativeUtil.isIOS() and slot2 or SDKMgr.instance:getProductList()

		logNormal("查询商品列表结果: " .. slot3)
		PayModel.instance:setProductInfo(slot3)
		uv0.instance:dispatchEvent(PayEvent.UpdateProductDetails)
	else
		logNormal("查询商品列表出错 : " .. slot1 .. ":" .. slot2)
	end

	if slot0._queryProductDetailsCallBack then
		slot0._queryProductDetailsCallBack(slot0._queryProductDetailsCallBackObj)
	end

	slot0:clearAllQueryProductDetailsCallBack()
end

function slot0.clearAllQueryProductDetailsCallBack(slot0)
	slot0._queryProductDetailsCallBack = nil
	slot0._queryProductDetailsCallBackObj = nil
end

function slot0._onPayCallback(slot0, slot1, slot2)
	if slot1 == PayEnum.PayResultCode.PayFinish then
		if PayModel.instance:getOrderInfo().gameOrderId then
			TaskDispatcher.runDelay(slot0._payFinishedPushTimeout, slot0, 10)
			UIBlockMgr.instance:startBlock(UIBlockKey.PayFinish)
		end
	elseif slot1 == PayEnum.PayResultCode.PayCancel then
		-- Nothing
	elseif slot1 == PayEnum.PayResultCode.PayInfoFail then
		-- Nothing
	elseif slot1 == PayEnum.PayResultCode.PayError then
		-- Nothing
	elseif slot1 == PayEnum.PayResultCode.PayOrderCancel then
		-- Nothing
	elseif slot1 ~= PayEnum.PayResultCode.PayChannelFail then
		logNormal("支付异常 : " .. slot1 .. ":" .. slot2)
		GameFacade.showToast(ToastEnum.PayError, slot2, slot1)
		uv0.instance:dispatchEvent(PayEvent.PayFailed)
	end

	if slot1 ~= PayEnum.PayResultCode.PayFinish then
		slot0:_hidePayFinishBlock()
	end
end

function slot0._payFinishedPushTimeout(slot0)
	ToastController.instance:showToast(ToastEnum.PayFinishedPushTimeout)
	slot0:_hidePayFinishBlock()
end

function slot0._hidePayFinishBlock(slot0)
	UIBlockMgr.instance:endBlock(UIBlockKey.PayFinish)
end

slot0.instance = slot0.New()

return slot0
