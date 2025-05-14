module("modules.logic.pay.model.PayModel", package.seeall)

local var_0_0 = class("PayModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._chargeInfos = {}
	arg_1_0._productInfos = {}
	arg_1_0._orderInfo = {}
	arg_1_0._sandboxEnable = false
	arg_1_0._sandboxBalance = 0
	arg_1_0._hasInitProductInfo = false
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._productInfos = {}
	arg_2_0._chargeInfos = {}
	arg_2_0._orderInfo = {}
	arg_2_0._sandboxEnable = false
	arg_2_0._sandboxBalance = 0
	arg_2_0._hasInitProductInfo = false
end

function var_0_0.setSandboxInfo(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._sandboxEnable = arg_3_1
	arg_3_0._sandboxBalance = arg_3_2
end

function var_0_0.updateSandboxBalance(arg_4_0, arg_4_1)
	arg_4_0._sandboxBalance = arg_4_1
end

function var_0_0.setChargeInfo(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		arg_5_0._chargeInfos[iter_5_1.id] = iter_5_1
	end
end

function var_0_0.hasInitProductInfo(arg_6_0)
	if BootNativeUtil.isWindows() and GameChannelConfig.isGpGlobal() == false then
		return true
	end

	return arg_6_0._hasInitProductInfo
end

function var_0_0.setProductInfo(arg_7_0, arg_7_1)
	if string.nilorempty(arg_7_1) == false and arg_7_1 ~= "null" then
		local var_7_0 = cjson.decode(arg_7_1)

		for iter_7_0, iter_7_1 in pairs(var_7_0) do
			if BootNativeUtil.isWindows() then
				local var_7_1 = tonumber(iter_7_1.productId)

				if var_7_1 and GameChannelConfig.isLongCheng() == false and GameChannelConfig.isGpJapan() == false then
					arg_7_0._productInfos[var_7_1] = iter_7_1
				end

				arg_7_0._hasInitProductInfo = true
			else
				local var_7_2 = StoreConfig.instance:getStoreChargeConfigByProductID(iter_7_1.productId)

				for iter_7_2, iter_7_3 in ipairs(var_7_2) do
					arg_7_0._hasInitProductInfo = true

					if GameChannelConfig.isLongCheng() == false and GameChannelConfig.isGpJapan() == false then
						arg_7_0._productInfos[iter_7_3.id] = iter_7_1
					end
				end

				if #var_7_2 == 0 then
					logError("找不到对应充值商品：" .. iter_7_1.productId)
				end
			end
		end
	end
end

function var_0_0.setOrderInfo(arg_8_0, arg_8_1)
	arg_8_0._orderInfo = {}
	arg_8_0._orderInfo.id = arg_8_1.id

	if arg_8_1.passBackParam then
		arg_8_0._orderInfo.passBackParam = arg_8_1.passBackParam
	end

	arg_8_0._orderInfo.notifyUrl = arg_8_1.notifyUrl and arg_8_1.notifyUrl or ""
	arg_8_0._orderInfo.gameOrderId = arg_8_1.gameOrderId
	arg_8_0._orderInfo.timestamp = arg_8_1.timestamp
	arg_8_0._orderInfo.sign = arg_8_1.sign
	arg_8_0._orderInfo.serverId = arg_8_1.serverId
	arg_8_0._orderInfo.currency = arg_8_1.currency
end

function var_0_0.clearOrderInfo(arg_9_0)
	arg_9_0._orderInfo = {}
end

function var_0_0.getSandboxEnable(arg_10_0)
	return arg_10_0._sandboxEnable
end

function var_0_0.getSandboxBalance(arg_11_0)
	return arg_11_0._sandboxBalance
end

function var_0_0.getOrderInfo(arg_12_0)
	return arg_12_0._orderInfo
end

function var_0_0.getGamePayInfo(arg_13_0)
	if not arg_13_0._orderInfo.id then
		return ""
	end

	local var_13_0 = StoreConfig.instance:getChargeGoodsConfig(arg_13_0._orderInfo.id)
	local var_13_1 = PlayerModel.instance:getPlayinfo()
	local var_13_2 = {
		gameRoleInfo = arg_13_0:getGameRoleInfo(true)
	}

	var_13_2.gameRoleInfo.roleEstablishTime = tonumber(var_13_1.registerTime)
	var_13_2.currency = arg_13_0._orderInfo.currency
	var_13_2.amount = math.ceil(100 * StoreConfig.instance:getBaseChargeGoodsPrice(var_13_0.id))
	var_13_2.goodsId = arg_13_0._orderInfo.id
	var_13_2.goodsName = var_13_0.name
	var_13_2.goodsDesc = var_13_0.desc
	var_13_2.gameOrderId = arg_13_0._orderInfo.gameOrderId
	var_13_2.passBackParam = arg_13_0._orderInfo.passBackParam and arg_13_0._orderInfo.passBackParam or ""
	var_13_2.notifyUrl = arg_13_0._orderInfo.notifyUrl
	var_13_2.timestamp = arg_13_0._orderInfo.timestamp
	var_13_2.sign = arg_13_0._orderInfo.sign

	if SLFramework.FrameworkSettings.IsEditor then
		var_13_2.productId = ""
	else
		local var_13_3 = SDKMgr.instance:getChannelId()
		local var_13_4 = StoreConfig.instance:getStoreChargeConfig(arg_13_0._orderInfo.id, BootNativeUtil.getPackageName() .. "_" .. var_13_3, true)

		if var_13_4 then
			var_13_2.productId = var_13_4.appStoreProductID
		else
			var_13_2.productId = StoreConfig.instance:getStoreChargeConfig(arg_13_0._orderInfo.id, BootNativeUtil.getPackageName()).appStoreProductID
		end
	end

	var_13_2.originCurrency = arg_13_0:getProductOriginCurrency(arg_13_0._orderInfo.id)
	var_13_2.originAmount = arg_13_0:getProductOriginAmount(arg_13_0._orderInfo.id)

	return var_13_2
end

function var_0_0.getProductInfo(arg_14_0, arg_14_1)
	return arg_14_0._productInfos[arg_14_1]
end

function var_0_0.getProductPrice(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:getProductOriginPriceSymbol(arg_15_1)
	local var_15_1, var_15_2 = arg_15_0:getProductOriginPriceNum(arg_15_1)

	return string.format("%s%s", var_15_0, var_15_2)
end

function var_0_0.getProductOriginCurrency(arg_16_0, arg_16_1)
	if arg_16_0._productInfos[arg_16_1] and arg_16_0._productInfos[arg_16_1].priceCurrencyCode then
		return arg_16_0._productInfos[arg_16_1].priceCurrencyCode
	else
		return StoreConfig.instance:getChargeGoodsCurrencyCode(arg_16_1)
	end
end

function var_0_0.getProductInfoPrice(arg_17_0, arg_17_1)
	if arg_17_0._productInfos[arg_17_1] and arg_17_0._productInfos[arg_17_1].price then
		return arg_17_0._productInfos[arg_17_1].price
	else
		local var_17_0 = StoreConfig.instance:getChargeGoodsConfig(arg_17_1)
		local var_17_1 = "$"
		local var_17_2 = StoreConfig.instance:getChargeGoodsCurrencyCode(arg_17_1)

		if PayEnum.CurrencySymbol[var_17_2] then
			var_17_1 = PayEnum.CurrencySymbol[var_17_2]
		end

		local var_17_3 = StoreConfig.instance:getChargeGoodsPrice(arg_17_1)

		if SDKModel.instance:isDmm() then
			return string.format("%spt", var_17_3)
		else
			return string.format("%s%s", var_17_1, var_17_3)
		end
	end
end

function var_0_0._getConfigProductInfoPrice(arg_18_0, arg_18_1)
	local var_18_0 = StoreConfig.instance:getChargeGoodsConfig(arg_18_1)
	local var_18_1 = "$"
	local var_18_2 = StoreConfig.instance:getChargeGoodsCurrencyCode(arg_18_1)

	if PayEnum.CurrencySymbol[var_18_2] then
		var_18_1 = PayEnum.CurrencySymbol[var_18_2]
	end

	local var_18_3 = StoreConfig.instance:getChargeGoodsPrice(arg_18_1)

	return string.format("%s%s", var_18_1, var_18_3)
end

function var_0_0.getProductOriginAmountMicro(arg_19_0, arg_19_1)
	return arg_19_0._productInfos[arg_19_1].priceAmountMicros
end

function var_0_0.getProductOriginPriceSymbol(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0:getProductInfoPrice(arg_20_1)
	local var_20_1 = string.find(var_20_0, "%d")

	if not var_20_1 then
		logError("getProductOriginPriceSymbol fail:" .. var_20_0)

		var_20_0 = arg_20_0:_getConfigProductInfoPrice(arg_20_1)
		var_20_1 = string.find(var_20_0, "%d")
	end

	return string.sub(var_20_0, 0, var_20_1 - 1)
end

function var_0_0.getProductOriginPriceNum(arg_21_0, arg_21_1)
	arg_21_0._tmpNum = 0
	arg_21_0._tmpNumStr = "0"
	arg_21_0._tmpIsNoDecimalsCurrency = false

	if not callWithCatch(arg_21_0._getProductOriginPriceNum, arg_21_0, arg_21_1) then
		local var_21_0 = arg_21_0:_getConfigProductInfoPrice(arg_21_1)
		local var_21_1 = arg_21_0:getProductOriginCurrency(arg_21_1)
		local var_21_2 = string.find(var_21_0, "%d")
		local var_21_3 = string.sub(var_21_0, var_21_2, string.len(var_21_0))
		local var_21_4 = string.reverse(var_21_3)
		local var_21_5 = string.find(var_21_4, "%d")
		local var_21_6 = string.len(var_21_4) - var_21_5
		local var_21_7 = string.sub(var_21_3, 1, var_21_6 + 1)

		arg_21_0._tmpNum = string.gsub(var_21_7, ",", "")
		arg_21_0._tmpNum = tonumber(arg_21_0._tmpNum)
		arg_21_0._tmpNumStr = var_21_3
		arg_21_0._tmpIsNoDecimalsCurrency = arg_21_0:isNoDecimalsCurrency(var_21_1)

		if arg_21_0._tmpIsNoDecimalsCurrency then
			arg_21_0._tmpNumStr = math.floor(arg_21_0._tmpNum)
		end
	end

	if string.nilorempty(arg_21_0._tmpNum) then
		arg_21_0._tmpNum = 0
	end

	return arg_21_0._tmpNum, arg_21_0._tmpNumStr, arg_21_0._tmpIsNoDecimalsCurrency
end

function var_0_0._getProductOriginPriceNum(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0:getProductInfoPrice(arg_22_1)
	local var_22_1 = arg_22_0:getProductOriginCurrency(arg_22_1)
	local var_22_2 = string.find(var_22_0, "%d")
	local var_22_3 = string.sub(var_22_0, var_22_2, string.len(var_22_0))
	local var_22_4 = string.reverse(var_22_3)
	local var_22_5 = string.find(var_22_4, "%d")
	local var_22_6 = string.len(var_22_4) - var_22_5
	local var_22_7 = string.sub(var_22_3, 1, var_22_6 + 1)
	local var_22_8 = string.gsub(var_22_7, ",", "")

	arg_22_0._tmpNum = tonumber(var_22_8)
	arg_22_0._tmpIsNoDecimalsCurrency = arg_22_0:isNoDecimalsCurrency(var_22_1)
	arg_22_0._tmpNumStr = var_22_3

	if arg_22_0._tmpIsNoDecimalsCurrency and SDKModel.instance:isDmm() == false then
		arg_22_0._tmpNumStr = math.floor(var_22_8)
	end
end

function var_0_0.isNoDecimalsCurrency(arg_23_0, arg_23_1)
	return PayEnum.NoDecimalsCurrency[arg_23_1] ~= nil
end

function var_0_0.getProductOriginAmount(arg_24_0, arg_24_1)
	arg_24_0._tmpAmount = 0

	if not callWithCatch(arg_24_0._getProductOriginAmount, arg_24_0, arg_24_1) then
		arg_24_0._tmpAmount = 0

		logError("getProductOriginAmount fail:" .. arg_24_0:getProductInfoPrice(arg_24_1))
	end

	if string.nilorempty(arg_24_0._tmpAmount) then
		arg_24_0._tmpAmount = 0

		logError("getProductOriginAmount fail:" .. arg_24_0:getProductInfoPrice(arg_24_1))
	end

	return arg_24_0._tmpAmount
end

function var_0_0._getProductOriginAmount(arg_25_0, arg_25_1)
	if BootNativeUtil.isWindows() and arg_25_0:getProductInfo(arg_25_1) then
		local var_25_0 = arg_25_0:getProductOriginAmountMicro(arg_25_1)

		if var_25_0 then
			arg_25_0._tmpAmount = var_25_0
		else
			arg_25_0._tmpAmount = 0
		end

		return
	end

	local var_25_1 = arg_25_0:getProductInfoPrice(arg_25_1)
	local var_25_2 = string.find(var_25_1, "%d")
	local var_25_3 = string.sub(var_25_1, var_25_2, string.len(var_25_1))
	local var_25_4 = string.reverse(var_25_3)
	local var_25_5 = string.find(var_25_4, "%d")
	local var_25_6 = string.len(var_25_4) - var_25_5
	local var_25_7 = string.sub(var_25_3, 1, var_25_6 + 1)
	local var_25_8 = string.gsub(var_25_7, ",", "")
	local var_25_9 = tonumber(var_25_8) * 100
	local var_25_10 = string.find(var_25_9, "%.")

	if var_25_10 then
		var_25_9 = string.sub(var_25_9, 0, var_25_10 - 1)
		var_25_9 = tonumber(var_25_9)
	else
		var_25_9 = string.sub(var_25_9, 0, string.len(var_25_9))
		var_25_9 = tonumber(var_25_9)
	end

	arg_25_0._tmpAmount = var_25_9
end

function var_0_0.getGameRoleInfo(arg_26_0, arg_26_1)
	local var_26_0 = PlayerModel.instance:getPlayinfo()
	local var_26_1 = CurrencyModel.instance:getFreeDiamond()
	local var_26_2 = CurrencyModel.instance:getDiamond()
	local var_26_3 = {
		roleId = tostring(var_26_0.userId),
		roleName = tostring(var_26_0.name),
		currentLevel = tonumber(var_26_0.level)
	}

	var_26_3.vipLevel = 0

	local var_26_4 = tostring(LoginModel.instance.serverId)

	if arg_26_1 and arg_26_0._orderInfo.serverId > 0 then
		var_26_4 = arg_26_0._orderInfo.serverId
	end

	local var_26_5 = DungeonConfig.instance:getEpisodeCO(var_26_0.lastEpisodeId)
	local var_26_6 = var_26_5 and tostring(var_26_5.name .. var_26_5.id) or ""

	var_26_3.serverId = var_26_4
	var_26_3.serverName = tostring(LoginModel.instance.serverName)
	var_26_3.roleCTime = tonumber(var_26_0.registerTime)
	var_26_3.loginTime = tonumber(var_26_0.lastLoginTime)
	var_26_3.logoutTime = tonumber(var_26_0.lastLogoutTime)
	var_26_3.accountRegisterTime = tonumber(var_26_0.registerTime)
	var_26_3.giveCurrencyNum = var_26_1
	var_26_3.paidCurrencyNum = var_26_2
	var_26_3.currencyNum = var_26_1 + var_26_2
	var_26_3.currentProgress = var_26_6
	var_26_3.roleEstablishTime = tonumber(var_26_0.registerTime)
	var_26_3.guildLevel = tonumber(var_26_0.level)
	var_26_3.roleType = StatModel.instance:getRoleType()
	var_26_3.gameEnv = VersionValidator.instance:isInReviewing() and 1 or 0

	return var_26_3
end

function var_0_0.getQuickUseInfo(arg_27_0)
	if not arg_27_0._orderInfo then
		return
	end

	local var_27_0 = arg_27_0._orderInfo.id
	local var_27_1 = StoreConfig.instance:getChargeGoodsConfig(var_27_0)

	if not var_27_1 then
		return
	end

	local var_27_2 = var_27_1.quickUseItemList

	if string.nilorempty(var_27_2) then
		return
	end

	local var_27_3 = GameUtil.splitString2(var_27_2, true, "|", "#")

	if not var_27_3 or #var_27_3 == 0 then
		return
	end

	return {
		goodsId = var_27_0,
		chargeGoodsConfig = var_27_1,
		itemList = var_27_3
	}
end

var_0_0.instance = var_0_0.New()

return var_0_0
