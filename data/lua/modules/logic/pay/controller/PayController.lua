module("modules.logic.pay.controller.PayController", package.seeall)

local var_0_0 = class("PayController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.onInitFinish(arg_3_0)
	return
end

function var_0_0.addConstEvents(arg_4_0)
	SDKMgr.instance:setPayCallBack(arg_4_0._onPayCallback, arg_4_0)
	SDKMgr.instance:setQueryProductDetailsCallBack(arg_4_0._onQueryProductDetailsCallBack, arg_4_0)
	arg_4_0:registerCallback(PayEvent.GetSignSuccess, arg_4_0._onGetSignSuccess, arg_4_0)
	arg_4_0:registerCallback(PayEvent.GetSignFailed, arg_4_0._onGetSignFailed, arg_4_0)
	arg_4_0:registerCallback(PayEvent.PayFinished, arg_4_0._onPayFinished, arg_4_0)
	arg_4_0:registerCallback(PayEvent.PayFailed, arg_4_0._onPayFailed, arg_4_0)
end

function var_0_0.startPay(arg_5_0, arg_5_1, arg_5_2)
	if MinorsController.instance:isPayLimit() then
		ViewMgr.instance:openView(ViewName.DateOfBirthSelectionView)

		return
	end

	if SLFramework.FrameworkSettings.IsEditor and PayModel.instance:getSandboxEnable() ~= true then
		return
	end

	UIBlockMgr.instance:startBlock("charging")
	ChargeRpc.instance:sendNewOrderRequest(arg_5_1, arg_5_2)
end

function var_0_0._onGetSignSuccess(arg_6_0)
	UIBlockMgr.instance:endBlock("charging")

	local var_6_0 = StatModel.instance:getPayInfo()

	if PayModel.instance:getSandboxEnable() then
		ViewMgr.instance:openView(ViewName.SDKSandboxPayView, {
			payInfo = PayModel.instance:getGamePayInfo()
		})
	else
		SDKMgr.instance:payGoods(var_6_0)
	end
end

function var_0_0._onGetSignFailed(arg_7_0)
	UIBlockMgr.instance:endBlock("charging")
	PayModel.instance:clearOrderInfo()
end

function var_0_0._onPayFinished(arg_8_0, arg_8_1)
	TaskDispatcher.cancelTask(arg_8_0._payFinishedPushTimeout, arg_8_0)
	arg_8_0:_hidePayFinishBlock()
	PayModel.instance:clearOrderInfo()
	SDKChannelEventModel.instance:purchase(arg_8_1)

	local var_8_0 = StoreConfig.instance:getChargeGoodsConfig(arg_8_1)

	if var_8_0 then
		local var_8_1 = {
			amount = StoreConfig.instance:getChargeGoodsPrice(arg_8_1),
			currency = StoreConfig.instance:getChargeGoodsCurrencyCode(arg_8_1)
		}

		if SLFramework.FrameworkSettings.IsEditor then
			var_8_1.productId = ""
		else
			var_8_1.productId = StoreConfig.instance:getStoreChargeConfig(arg_8_1, BootNativeUtil.getPackageName()).appStoreProductID
		end

		var_8_1.goodsName = var_8_0.name
		var_8_1.goodsId = arg_8_1

		if SDKMediaEventEnum.PurchaseIdMediaEvent[arg_8_1] then
			SDKDataTrackMgr.instance:trackMediaPayEvent(SDKMediaEventEnum.PurchaseIdMediaEvent[arg_8_1], var_8_1)
		elseif var_8_0 and var_8_0.storeId == StoreEnum.StoreId.Skin then
			SDKDataTrackMgr.instance:trackMediaPayEvent(SDKDataTrackMgr.MediaEvent.purchase_skin, var_8_1)
		end

		SDKDataTrackMgr.instance:trackMediaPayEvent(SDKDataTrackMgr.MediaEvent.purchase, var_8_1)
	end
end

function var_0_0._onPayFailed(arg_9_0)
	PayModel.instance:clearOrderInfo()
end

function var_0_0.getAllQueryProductDetails(arg_10_0, arg_10_1, arg_10_2)
	if PayModel.instance:hasInitProductInfo() then
		if arg_10_1 then
			arg_10_1(arg_10_2)
		end

		arg_10_0:clearAllQueryProductDetailsCallBack()

		return
	end

	local var_10_0 = StoreConfig.instance:getAllChargeGoodsConfig()
	local var_10_1 = {}

	for iter_10_0, iter_10_1 in pairs(var_10_0) do
		local var_10_2 = StoreConfig.instance:getStoreChargeConfig(iter_10_1.id, BootNativeUtil.getPackageName(), true)

		if var_10_2 then
			local var_10_3 = var_10_2.appStoreProductID

			table.insert(var_10_1, var_10_3)
		end
	end

	arg_10_0._queryProductDetailsCallBack = arg_10_1
	arg_10_0._queryProductDetailsCallBackObj = arg_10_2

	SDKMgr.instance:queryProductDetailEntity("inapp", var_10_1)
end

function var_0_0._onQueryProductDetailsCallBack(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 == PayEnum.PayResultCode.PayFinish then
		local var_11_0

		if BootNativeUtil.isIOS() then
			var_11_0 = arg_11_2
		else
			var_11_0 = SDKMgr.instance:getProductList()
		end

		logNormal("查询商品列表结果: " .. var_11_0)
		PayModel.instance:setProductInfo(var_11_0)
		var_0_0.instance:dispatchEvent(PayEvent.UpdateProductDetails)
	else
		logNormal("查询商品列表出错 : " .. arg_11_1 .. ":" .. arg_11_2)
	end

	if arg_11_0._queryProductDetailsCallBack then
		arg_11_0._queryProductDetailsCallBack(arg_11_0._queryProductDetailsCallBackObj)
	end

	arg_11_0:clearAllQueryProductDetailsCallBack()
end

function var_0_0.clearAllQueryProductDetailsCallBack(arg_12_0)
	arg_12_0._queryProductDetailsCallBack = nil
	arg_12_0._queryProductDetailsCallBackObj = nil
end

function var_0_0._onPayCallback(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 == PayEnum.PayResultCode.PayFinish then
		if PayModel.instance:getOrderInfo().gameOrderId then
			TaskDispatcher.runDelay(arg_13_0._payFinishedPushTimeout, arg_13_0, 10)
			UIBlockMgr.instance:startBlock(UIBlockKey.PayFinish)
		end
	elseif arg_13_1 == PayEnum.PayResultCode.PayCancel then
		-- block empty
	elseif arg_13_1 == PayEnum.PayResultCode.PayInfoFail then
		-- block empty
	elseif arg_13_1 == PayEnum.PayResultCode.PayError then
		-- block empty
	elseif arg_13_1 == PayEnum.PayResultCode.PayOrderCancel then
		-- block empty
	elseif arg_13_1 == PayEnum.PayResultCode.PayChannelFail then
		-- block empty
	else
		logNormal("支付异常 : " .. arg_13_1 .. ":" .. arg_13_2)
		GameFacade.showToast(ToastEnum.PayError, arg_13_2, arg_13_1)
		var_0_0.instance:dispatchEvent(PayEvent.PayFailed)
	end

	if arg_13_1 ~= PayEnum.PayResultCode.PayFinish then
		arg_13_0:_hidePayFinishBlock()
	end
end

function var_0_0._payFinishedPushTimeout(arg_14_0)
	ToastController.instance:showToast(ToastEnum.PayFinishedPushTimeout)
	arg_14_0:_hidePayFinishBlock()
end

function var_0_0._hidePayFinishBlock(arg_15_0)
	UIBlockMgr.instance:endBlock(UIBlockKey.PayFinish)
end

function var_0_0.onReceiveMaterialChangePush(arg_16_0, arg_16_1)
	if not arg_16_1 or #arg_16_1 == 0 then
		return
	end

	local var_16_0 = PayModel.instance:getQuickUseInfo()

	if not var_16_0 then
		return
	end

	local var_16_1 = {}

	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		local var_16_2 = iter_16_1.materilType
		local var_16_3 = iter_16_1.materilId
		local var_16_4 = iter_16_1.quantity or 0

		var_16_1[var_16_2] = var_16_1[var_16_2] or {}

		local var_16_5 = var_16_1[var_16_2][var_16_3] or 0

		var_16_1[var_16_2][var_16_3] = var_16_5 + var_16_4
	end

	local var_16_6 = {}

	for iter_16_2, iter_16_3 in ipairs(var_16_0.itemList) do
		local var_16_7 = iter_16_3[1]
		local var_16_8 = iter_16_3[2]
		local var_16_9 = iter_16_3[3]

		if var_16_1[var_16_7] and var_16_1[var_16_7][var_16_8] then
			var_16_6[var_16_7] = var_16_6[var_16_7] or {}

			local var_16_10 = var_16_6[var_16_7][var_16_8]

			if not var_16_10 then
				local var_16_11 = var_16_1[var_16_7][var_16_8]

				var_16_10 = math.min(ItemModel.instance:getItemQuantity(var_16_7, var_16_8) or 0, var_16_11)
				var_16_6[var_16_7][var_16_8] = var_16_10
			end

			if var_16_10 - var_16_9 < 0 then
				var_16_9 = var_16_10
				var_16_10 = 0
			end

			if var_16_9 > 0 then
				local var_16_12 = var_16_9 == 1
				local var_16_13 = var_16_12 and MessageBoxIdDefine.ChargeStoreQuickUseTip or MessageBoxIdDefine.ChargeStoreQuickUseTipWithNum
				local var_16_14 = ItemModel.instance:getItemConfig(var_16_7, var_16_8)
				local var_16_15 = {
					var_16_14.name,
					not var_16_12 and var_16_9 or nil
				}
				local var_16_16 = {
					messageBoxId = var_16_13,
					msg = MessageBoxConfig.instance:getMessage(var_16_13),
					msgBoxType = MsgBoxEnum.BoxType.Yes_No,
					yesCallback = function()
						local var_17_0 = {
							{
								materialId = var_16_8,
								quantity = var_16_9
							}
						}

						CharacterModel.instance:setGainHeroViewShowState(false)
						CharacterModel.instance:setGainHeroViewNewShowState(false)
						ItemRpc.instance:sendUseItemRequest(var_17_0, 0)
					end,
					extra = var_16_15
				}

				PopupController.instance:addPopupView(PopupEnum.PriorityType.ChargeStoreQuickUseTip, ViewName.MessageBoxView, var_16_16)
			end

			var_16_6[var_16_7][var_16_8] = var_16_10
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
