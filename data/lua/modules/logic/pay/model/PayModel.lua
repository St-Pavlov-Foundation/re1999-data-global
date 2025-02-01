module("modules.logic.pay.model.PayModel", package.seeall)

slot0 = class("PayModel", BaseModel)

function slot0.onInit(slot0)
	slot0._chargeInfos = {}
	slot0._productInfos = {}
	slot0._orderInfo = {}
	slot0._sandboxEnable = false
	slot0._sandboxBalance = 0
	slot0._hasInitProductInfo = false
end

function slot0.reInit(slot0)
	slot0._productInfos = {}
	slot0._chargeInfos = {}
	slot0._orderInfo = {}
	slot0._sandboxEnable = false
	slot0._sandboxBalance = 0
	slot0._hasInitProductInfo = false
end

function slot0.setSandboxInfo(slot0, slot1, slot2)
	slot0._sandboxEnable = slot1
	slot0._sandboxBalance = slot2
end

function slot0.updateSandboxBalance(slot0, slot1)
	slot0._sandboxBalance = slot1
end

function slot0.setChargeInfo(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0._chargeInfos[slot6.id] = slot6
	end
end

function slot0.hasInitProductInfo(slot0)
	if BootNativeUtil.isWindows() and GameChannelConfig.isGpGlobal() == false then
		return true
	end

	return slot0._hasInitProductInfo
end

function slot0.setProductInfo(slot0, slot1)
	if string.nilorempty(slot1) == false and slot1 ~= "null" then
		for slot6, slot7 in pairs(cjson.decode(slot1)) do
			if BootNativeUtil.isWindows() then
				if tonumber(slot7.productId) and GameChannelConfig.isLongCheng() == false and GameChannelConfig.isGpJapan() == false then
					slot0._productInfos[slot8] = slot7
				end

				slot0._hasInitProductInfo = true
			else
				for slot12, slot13 in ipairs(StoreConfig.instance:getStoreChargeConfigByProductID(slot7.productId)) do
					slot0._hasInitProductInfo = true

					if GameChannelConfig.isLongCheng() == false and GameChannelConfig.isGpJapan() == false then
						slot0._productInfos[slot13.id] = slot7
					end
				end

				if #slot8 == 0 then
					logError("找不到对应充值商品：" .. slot7.productId)
				end
			end
		end
	end
end

function slot0.setOrderInfo(slot0, slot1)
	slot0._orderInfo = {
		id = slot1.id
	}

	if slot1.passBackParam then
		slot0._orderInfo.passBackParam = slot1.passBackParam
	end

	slot0._orderInfo.notifyUrl = slot1.notifyUrl and slot1.notifyUrl or ""
	slot0._orderInfo.gameOrderId = slot1.gameOrderId
	slot0._orderInfo.timestamp = slot1.timestamp
	slot0._orderInfo.sign = slot1.sign
	slot0._orderInfo.serverId = slot1.serverId
	slot0._orderInfo.currency = slot1.currency
end

function slot0.clearOrderInfo(slot0)
	slot0._orderInfo = {}
end

function slot0.getSandboxEnable(slot0)
	return slot0._sandboxEnable
end

function slot0.getSandboxBalance(slot0)
	return slot0._sandboxBalance
end

function slot0.getOrderInfo(slot0)
	return slot0._orderInfo
end

function slot0.getGamePayInfo(slot0)
	if not slot0._orderInfo.id then
		return ""
	end

	slot1 = StoreConfig.instance:getChargeGoodsConfig(slot0._orderInfo.id)
	slot3 = {
		gameRoleInfo = slot0:getGameRoleInfo(true)
	}
	slot3.gameRoleInfo.roleEstablishTime = tonumber(PlayerModel.instance:getPlayinfo().registerTime)
	slot3.currency = slot0._orderInfo.currency
	slot3.amount = math.ceil(100 * StoreConfig.instance:getBaseChargeGoodsPrice(slot1.id))
	slot3.goodsId = slot0._orderInfo.id
	slot3.goodsName = slot1.name
	slot3.goodsDesc = slot1.desc
	slot3.gameOrderId = slot0._orderInfo.gameOrderId
	slot3.passBackParam = slot0._orderInfo.passBackParam and slot0._orderInfo.passBackParam or ""
	slot3.notifyUrl = slot0._orderInfo.notifyUrl
	slot3.timestamp = slot0._orderInfo.timestamp
	slot3.sign = slot0._orderInfo.sign

	if SLFramework.FrameworkSettings.IsEditor then
		slot3.productId = ""
	elseif StoreConfig.instance:getStoreChargeConfig(slot0._orderInfo.id, BootNativeUtil.getPackageName() .. "_" .. SDKMgr.instance:getChannelId(), true) then
		slot3.productId = slot5.appStoreProductID
	else
		slot3.productId = StoreConfig.instance:getStoreChargeConfig(slot0._orderInfo.id, BootNativeUtil.getPackageName()).appStoreProductID
	end

	slot3.originCurrency = slot0:getProductOriginCurrency(slot0._orderInfo.id)
	slot3.originAmount = slot0:getProductOriginAmount(slot0._orderInfo.id)

	return slot3
end

function slot0.getProductInfo(slot0, slot1)
	return slot0._productInfos[slot1]
end

function slot0.getProductPrice(slot0, slot1)
	slot3, slot4 = slot0:getProductOriginPriceNum(slot1)

	return string.format("%s%s", slot0:getProductOriginPriceSymbol(slot1), slot4)
end

function slot0.getProductOriginCurrency(slot0, slot1)
	if slot0._productInfos[slot1] and slot0._productInfos[slot1].priceCurrencyCode then
		return slot0._productInfos[slot1].priceCurrencyCode
	else
		return StoreConfig.instance:getChargeGoodsCurrencyCode(slot1)
	end
end

function slot0.getProductInfoPrice(slot0, slot1)
	if slot0._productInfos[slot1] and slot0._productInfos[slot1].price then
		return slot0._productInfos[slot1].price
	else
		slot2 = StoreConfig.instance:getChargeGoodsConfig(slot1)
		slot3 = "$"

		if PayEnum.CurrencySymbol[StoreConfig.instance:getChargeGoodsCurrencyCode(slot1)] then
			slot3 = PayEnum.CurrencySymbol[slot4]
		end

		if SDKModel.instance:isDmm() then
			return string.format("%spt", StoreConfig.instance:getChargeGoodsPrice(slot1))
		else
			return string.format("%s%s", slot3, slot5)
		end
	end
end

function slot0._getConfigProductInfoPrice(slot0, slot1)
	slot2 = StoreConfig.instance:getChargeGoodsConfig(slot1)
	slot3 = "$"

	if PayEnum.CurrencySymbol[StoreConfig.instance:getChargeGoodsCurrencyCode(slot1)] then
		slot3 = PayEnum.CurrencySymbol[slot4]
	end

	return string.format("%s%s", slot3, StoreConfig.instance:getChargeGoodsPrice(slot1))
end

function slot0.getProductOriginAmountMicro(slot0, slot1)
	return slot0._productInfos[slot1].priceAmountMicros
end

function slot0.getProductOriginPriceSymbol(slot0, slot1)
	if not string.find(slot0:getProductInfoPrice(slot1), "%d") then
		logError("getProductOriginPriceSymbol fail:" .. slot2)

		slot3 = string.find(slot0:_getConfigProductInfoPrice(slot1), "%d")
	end

	return string.sub(slot2, 0, slot3 - 1)
end

function slot0.getProductOriginPriceNum(slot0, slot1)
	slot0._tmpNum = 0
	slot0._tmpNumStr = "0"
	slot0._tmpIsNoDecimalsCurrency = false

	if not callWithCatch(slot0._getProductOriginPriceNum, slot0, slot1) then
		slot2 = slot0:_getConfigProductInfoPrice(slot1)
		slot5 = string.sub(slot2, string.find(slot2, "%d"), string.len(slot2))
		slot6 = string.reverse(slot5)
		slot0._tmpNum = string.gsub(string.sub(slot5, 1, string.len(slot6) - string.find(slot6, "%d") + 1), ",", "")
		slot0._tmpNum = tonumber(slot0._tmpNum)
		slot0._tmpNumStr = slot5
		slot0._tmpIsNoDecimalsCurrency = slot0:isNoDecimalsCurrency(slot0:getProductOriginCurrency(slot1))

		if slot0._tmpIsNoDecimalsCurrency then
			slot0._tmpNumStr = math.floor(slot0._tmpNum)
		end
	end

	if string.nilorempty(slot0._tmpNum) then
		slot0._tmpNum = 0
	end

	return slot0._tmpNum, slot0._tmpNumStr, slot0._tmpIsNoDecimalsCurrency
end

function slot0._getProductOriginPriceNum(slot0, slot1)
	slot2 = slot0:getProductInfoPrice(slot1)
	slot5 = string.sub(slot2, string.find(slot2, "%d"), string.len(slot2))
	slot6 = string.reverse(slot5)
	slot0._tmpNum = tonumber(string.gsub(string.sub(slot5, 1, string.len(slot6) - string.find(slot6, "%d") + 1), ",", ""))
	slot0._tmpIsNoDecimalsCurrency = slot0:isNoDecimalsCurrency(slot0:getProductOriginCurrency(slot1))
	slot0._tmpNumStr = slot5

	if slot0._tmpIsNoDecimalsCurrency and SDKModel.instance:isDmm() == false then
		slot0._tmpNumStr = math.floor(slot9)
	end
end

function slot0.isNoDecimalsCurrency(slot0, slot1)
	return PayEnum.NoDecimalsCurrency[slot1] ~= nil
end

function slot0.getProductOriginAmount(slot0, slot1)
	slot0._tmpAmount = 0

	if not callWithCatch(slot0._getProductOriginAmount, slot0, slot1) then
		slot0._tmpAmount = 0

		logError("getProductOriginAmount fail:" .. slot0:getProductInfoPrice(slot1))
	end

	if string.nilorempty(slot0._tmpAmount) then
		slot0._tmpAmount = 0

		logError("getProductOriginAmount fail:" .. slot0:getProductInfoPrice(slot1))
	end

	return slot0._tmpAmount
end

function slot0._getProductOriginAmount(slot0, slot1)
	if BootNativeUtil.isWindows() and slot0:getProductInfo(slot1) then
		if slot0:getProductOriginAmountMicro(slot1) then
			slot0._tmpAmount = slot2
		else
			slot0._tmpAmount = 0
		end

		return
	end

	slot2 = slot0:getProductInfoPrice(slot1)
	slot4 = string.sub(slot2, string.find(slot2, "%d"), string.len(slot2))
	slot5 = string.reverse(slot4)
	slot0._tmpAmount = (not string.find(tonumber(string.gsub(string.sub(slot4, 1, string.len(slot5) - string.find(slot5, "%d") + 1), ",", "")) * 100, "%.") or tonumber(string.sub(slot4, 0, slot3 - 1))) and tonumber(string.sub(slot4, 0, string.len(slot4)))
end

function slot0.getGameRoleInfo(slot0, slot1)
	slot2 = PlayerModel.instance:getPlayinfo()
	slot3 = CurrencyModel.instance:getFreeDiamond()
	slot4 = CurrencyModel.instance:getDiamond()
	slot5 = {
		roleId = tostring(slot2.userId),
		roleName = tostring(slot2.name),
		currentLevel = tonumber(slot2.level),
		vipLevel = 0
	}
	slot6 = tostring(LoginModel.instance.serverId)

	if slot1 and slot0._orderInfo.serverId > 0 then
		slot6 = slot0._orderInfo.serverId
	end

	slot5.serverId = slot6
	slot5.serverName = tostring(LoginModel.instance.serverName)
	slot5.roleCTime = tonumber(slot2.registerTime)
	slot5.loginTime = tonumber(slot2.lastLoginTime)
	slot5.logoutTime = tonumber(slot2.lastLogoutTime)
	slot5.accountRegisterTime = tonumber(slot2.registerTime)
	slot5.giveCurrencyNum = slot3
	slot5.paidCurrencyNum = slot4
	slot5.currencyNum = slot3 + slot4
	slot5.currentProgress = DungeonConfig.instance:getEpisodeCO(slot2.lastEpisodeId) and tostring(slot7.name .. slot7.id) or ""
	slot5.roleEstablishTime = tonumber(slot2.registerTime)
	slot5.guildLevel = tonumber(slot2.level)
	slot5.roleType = StatModel.instance:getRoleType()
	slot5.gameEnv = VersionValidator.instance:isInReviewing() and 1 or 0

	return slot5
end

slot0.instance = slot0.New()

return slot0
