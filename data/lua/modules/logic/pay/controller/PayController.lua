-- chunkname: @modules/logic/pay/controller/PayController.lua

module("modules.logic.pay.controller.PayController", package.seeall)

local PayController = class("PayController", BaseController)

function PayController:onInit()
	return
end

function PayController:reInit()
	return
end

function PayController:onInitFinish()
	return
end

function PayController:addConstEvents()
	SDKMgr.instance:setPayCallBack(self._onPayCallback, self)
	SDKMgr.instance:setQueryProductDetailsCallBack(self._onQueryProductDetailsCallBack, self)
	self:registerCallback(PayEvent.GetSignSuccess, self._onGetSignSuccess, self)
	self:registerCallback(PayEvent.GetSignFailed, self._onGetSignFailed, self)
	self:registerCallback(PayEvent.PayFinished, self._onPayFinished, self)
	self:registerCallback(PayEvent.PayFailed, self._onPayFailed, self)
end

function PayController:startPay(goodsId, selectInfos, isDict)
	if MinorsController.instance:isPayLimit() then
		ViewMgr.instance:openView(ViewName.DateOfBirthSelectionView)

		return
	end

	if SLFramework.FrameworkSettings.IsEditor and PayModel.instance:getSandboxEnable() ~= true then
		return
	end

	UIBlockMgr.instance:startBlock("charging")

	if isDict then
		ChargeRpc.instance:sendDictNewOrderRequest(goodsId, selectInfos)
	else
		ChargeRpc.instance:sendNewOrderRequest(goodsId, selectInfos)
	end
end

function PayController:_onGetSignSuccess()
	UIBlockMgr.instance:endBlock("charging")

	local payInfo = StatModel.instance:getPayInfo()

	if PayModel.instance:getSandboxEnable() then
		ViewMgr.instance:openView(ViewName.SDKSandboxPayView, {
			payInfo = PayModel.instance:getGamePayInfo()
		})
	else
		SDKMgr.instance:payGoods(payInfo)
	end
end

function PayController:_onGetSignFailed()
	UIBlockMgr.instance:endBlock("charging")
	PayModel.instance:clearOrderInfo()
end

function PayController:_onPayFinished(id)
	TaskDispatcher.cancelTask(self._payFinishedPushTimeout, self)
	self:_hidePayFinishBlock()
	PayModel.instance:clearOrderInfo()
	SDKChannelEventModel.instance:purchase(id)

	local config = StoreConfig.instance:getChargeGoodsConfig(id)

	if config then
		local payData = {}

		payData.amount = StoreConfig.instance:getChargeGoodsPrice(id)
		payData.currency = StoreConfig.instance:getChargeGoodsCurrencyCode(id)

		if SLFramework.FrameworkSettings.IsEditor then
			payData.productId = ""
		else
			payData.productId = StoreConfig.instance:getStoreChargeConfig(id, BootNativeUtil.getPackageName()).appStoreProductID
		end

		payData.goodsName = config.name
		payData.goodsId = id

		if SDKMediaEventEnum.PurchaseIdMediaEvent[id] then
			SDKDataTrackMgr.instance:trackMediaPayEvent(SDKMediaEventEnum.PurchaseIdMediaEvent[id], payData)
		elseif config and config.storeId == StoreEnum.StoreId.Skin then
			SDKDataTrackMgr.instance:trackMediaPayEvent(SDKDataTrackMgr.MediaEvent.purchase_skin, payData)
		end

		SDKDataTrackMgr.instance:trackMediaPayEvent(SDKDataTrackMgr.MediaEvent.purchase, payData)
	end
end

function PayController:_onPayFailed()
	PayModel.instance:clearOrderInfo()
end

function PayController:getAllQueryProductDetails(callback, callbackobj)
	if PayModel.instance:hasInitProductInfo() then
		if callback then
			callback(callbackobj)
		end

		self:clearAllQueryProductDetailsCallBack()

		return
	end

	local allConfig = StoreConfig.instance:getAllChargeGoodsConfig()
	local ids = {}

	for i, v in pairs(allConfig) do
		local config = StoreConfig.instance:getStoreChargeConfig(v.id, BootNativeUtil.getPackageName(), true)

		if config then
			local id = config.appStoreProductID

			table.insert(ids, id)
		end
	end

	self._queryProductDetailsCallBack = callback
	self._queryProductDetailsCallBackObj = callbackobj

	SDKMgr.instance:queryProductDetailEntity("inapp", ids)
end

function PayController:_onQueryProductDetailsCallBack(code, msg)
	if code == PayEnum.PayResultCode.PayFinish then
		local productListStr

		if BootNativeUtil.isIOS() then
			productListStr = msg
		else
			productListStr = SDKMgr.instance:getProductList()
		end

		logNormal("查询商品列表结果: " .. productListStr)
		PayModel.instance:setProductInfo(productListStr)
		PayController.instance:dispatchEvent(PayEvent.UpdateProductDetails)
	else
		logNormal("查询商品列表出错 : " .. code .. ":" .. msg)
	end

	if self._queryProductDetailsCallBack then
		self._queryProductDetailsCallBack(self._queryProductDetailsCallBackObj)
	end

	self:clearAllQueryProductDetailsCallBack()
end

function PayController:clearAllQueryProductDetailsCallBack()
	self._queryProductDetailsCallBack = nil
	self._queryProductDetailsCallBackObj = nil
end

function PayController:_onPayCallback(code, msg)
	if code == PayEnum.PayResultCode.PayFinish then
		if PayModel.instance:getOrderInfo().gameOrderId then
			TaskDispatcher.runDelay(self._payFinishedPushTimeout, self, 10)
			UIBlockMgr.instance:startBlock(UIBlockKey.PayFinish)
		end
	elseif code == PayEnum.PayResultCode.PayCancel then
		-- block empty
	elseif code == PayEnum.PayResultCode.PayInfoFail then
		-- block empty
	elseif code == PayEnum.PayResultCode.PayError then
		-- block empty
	elseif code == PayEnum.PayResultCode.PayOrderCancel then
		-- block empty
	elseif code == PayEnum.PayResultCode.PayChannelFail then
		-- block empty
	else
		logNormal("支付异常 : " .. code .. ":" .. msg)
		GameFacade.showToast(ToastEnum.PayError, msg, code)
		PayController.instance:dispatchEvent(PayEvent.PayFailed)
	end

	if code ~= PayEnum.PayResultCode.PayFinish then
		self:_hidePayFinishBlock()
	end
end

function PayController:_payFinishedPushTimeout()
	ToastController.instance:showToast(ToastEnum.PayFinishedPushTimeout)
	self:_hidePayFinishBlock()
end

function PayController:_hidePayFinishBlock()
	UIBlockMgr.instance:endBlock(UIBlockKey.PayFinish)
end

function PayController:onReceiveMaterialChangePush(materialDataMOList)
	if not materialDataMOList or #materialDataMOList == 0 then
		return
	end

	local info = PayModel.instance:getQuickUseInfo()

	if not info then
		return
	end

	local itemId2GotCountDict = {}

	for i, mo in ipairs(materialDataMOList) do
		local materilType = mo.materilType
		local materilId = mo.materilId
		local quantity = mo.quantity or 0

		itemId2GotCountDict[materilType] = itemId2GotCountDict[materilType] or {}

		local cur = itemId2GotCountDict[materilType][materilId] or 0

		itemId2GotCountDict[materilType][materilId] = cur + quantity
	end

	local hasNumDict = {}

	for i, v in ipairs(info.itemList) do
		local itemType = v[1]
		local itemId = v[2]
		local useCount = v[3]

		if itemId2GotCountDict[itemType] and itemId2GotCountDict[itemType][itemId] then
			hasNumDict[itemType] = hasNumDict[itemType] or {}

			local has = hasNumDict[itemType][itemId]

			if not has then
				local maxUseCount = itemId2GotCountDict[itemType][itemId]

				has = math.min(ItemModel.instance:getItemQuantity(itemType, itemId) or 0, maxUseCount)
				hasNumDict[itemType][itemId] = has
			end

			local newHas = has - useCount

			if newHas < 0 then
				useCount = has
				has = 0
			end

			if useCount > 0 then
				local isOnlyOne = useCount == 1
				local messageBoxId = isOnlyOne and MessageBoxIdDefine.ChargeStoreQuickUseTip or MessageBoxIdDefine.ChargeStoreQuickUseTipWithNum
				local itemCo = ItemModel.instance:getItemConfig(itemType, itemId)
				local extra = {
					itemCo.name,
					not isOnlyOne and useCount or nil
				}
				local viewParam = {
					messageBoxId = messageBoxId,
					msg = MessageBoxConfig.instance:getMessage(messageBoxId),
					msgBoxType = MsgBoxEnum.BoxType.Yes_No,
					yesCallback = function()
						local list = {
							{
								materialId = itemId,
								quantity = useCount
							}
						}

						CharacterModel.instance:setGainHeroViewShowState(false)
						CharacterModel.instance:setGainHeroViewNewShowState(false)
						ItemRpc.instance:sendUseItemRequest(list, 0)
					end,
					extra = extra
				}

				PopupController.instance:addPopupView(PopupEnum.PriorityType.ChargeStoreQuickUseTip, ViewName.MessageBoxView, viewParam)
			end

			hasNumDict[itemType][itemId] = has
		end
	end
end

PayController.instance = PayController.New()

return PayController
