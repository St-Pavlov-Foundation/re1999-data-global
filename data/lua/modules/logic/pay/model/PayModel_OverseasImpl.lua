module("modules.logic.pay.model.PayModel_OverseasImpl", package.seeall)

local var_0_0 = LuaUtil.class("PayModel_OverseasImpl", PayModelBase)

function var_0_0.ctor(arg_1_0)
	assert(false, "PayModel_OverseasImpl is an abstract class, please use PayModel instead.")
end

function var_0_0.onInit(arg_2_0)
	var_0_0.super.onInit(arg_2_0)

	arg_2_0._productInfos = {}
	arg_2_0._hasInitProductInfo = false
end

function var_0_0.reInit(arg_3_0)
	var_0_0.super.reInit(arg_3_0)

	arg_3_0._productInfos = {}
	arg_3_0._hasInitProductInfo = false
end

function var_0_0.hasInitProductInfo(arg_4_0)
	if BootNativeUtil.isWindows() and GameChannelConfig.isGpGlobal() == false then
		return true
	end

	return arg_4_0._hasInitProductInfo
end

function var_0_0.setProductInfo(arg_5_0, arg_5_1)
	if string.nilorempty(arg_5_1) == false and arg_5_1 ~= "null" then
		local var_5_0 = cjson.decode(arg_5_1)

		for iter_5_0, iter_5_1 in pairs(var_5_0) do
			if BootNativeUtil.isWindows() then
				local var_5_1 = tonumber(iter_5_1.productId)

				if var_5_1 and GameChannelConfig.isLongCheng() == false and GameChannelConfig.isGpJapan() == false then
					arg_5_0._productInfos[var_5_1] = iter_5_1
				end

				arg_5_0._hasInitProductInfo = true
			else
				local var_5_2 = StoreConfig.instance:getStoreChargeConfigByProductID(iter_5_1.productId)

				for iter_5_2, iter_5_3 in ipairs(var_5_2) do
					arg_5_0._hasInitProductInfo = true

					if GameChannelConfig.isLongCheng() == false and GameChannelConfig.isGpJapan() == false then
						arg_5_0._productInfos[iter_5_3.id] = iter_5_1
					end
				end

				if #var_5_2 == 0 then
					logError("找不到对应充值商品：" .. iter_5_1.productId)
				end
			end
		end
	end
end

function var_0_0.setOrderInfo(arg_6_0, arg_6_1)
	var_0_0.super.setOrderInfo(arg_6_0, arg_6_1)

	arg_6_0._orderInfo.currency = arg_6_1.currency
end

function var_0_0.getGamePayInfo(arg_7_0)
	local var_7_0 = var_0_0.super.getGamePayInfo(arg_7_0)

	var_7_0.currency = arg_7_0._orderInfo.currency
	var_7_0.amount = math.ceil(100 * StoreConfig.instance:getBaseChargeGoodsPrice(arg_7_0._orderInfo.id))

	if SLFramework.FrameworkSettings.IsEditor then
		var_7_0.productId = ""
	else
		local var_7_1 = SDKMgr.instance:getChannelId()
		local var_7_2 = StoreConfig.instance:getStoreChargeConfig(arg_7_0._orderInfo.id, BootNativeUtil.getPackageName() .. "_" .. var_7_1, true)

		if var_7_2 then
			var_7_0.productId = var_7_2.appStoreProductID
		else
			var_7_0.productId = StoreConfig.instance:getStoreChargeConfig(arg_7_0._orderInfo.id, BootNativeUtil.getPackageName()).appStoreProductID
		end
	end

	var_7_0.originCurrency = arg_7_0:getProductOriginCurrency(arg_7_0._orderInfo.id)
	var_7_0.originAmount = arg_7_0:getProductOriginAmount(arg_7_0._orderInfo.id)

	return var_7_0
end

function var_0_0.getProductInfo(arg_8_0, arg_8_1)
	return arg_8_0._productInfos[arg_8_1]
end

function var_0_0.getProductPrice(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getProductOriginPriceSymbol(arg_9_1)
	local var_9_1, var_9_2 = arg_9_0:getProductOriginPriceNum(arg_9_1)

	return string.format("%s%s", var_9_0, var_9_2)
end

function var_0_0.getProductOriginCurrency(arg_10_0, arg_10_1)
	if arg_10_0._productInfos[arg_10_1] and arg_10_0._productInfos[arg_10_1].priceCurrencyCode then
		return arg_10_0._productInfos[arg_10_1].priceCurrencyCode
	else
		return StoreConfig.instance:getChargeGoodsCurrencyCode(arg_10_1)
	end
end

function var_0_0.getProductInfoPrice(arg_11_0, arg_11_1)
	if arg_11_0._productInfos[arg_11_1] and arg_11_0._productInfos[arg_11_1].price then
		return arg_11_0._productInfos[arg_11_1].price
	else
		local var_11_0 = StoreConfig.instance:getChargeGoodsConfig(arg_11_1)
		local var_11_1 = "$"
		local var_11_2 = StoreConfig.instance:getChargeGoodsCurrencyCode(arg_11_1)

		if PayEnum.CurrencySymbol[var_11_2] then
			var_11_1 = PayEnum.CurrencySymbol[var_11_2]
		end

		local var_11_3 = StoreConfig.instance:getChargeGoodsPrice(arg_11_1)

		if SDKModel.instance:isDmm() then
			return string.format("%spt", var_11_3)
		else
			return string.format("%s%s", var_11_1, var_11_3)
		end
	end
end

function var_0_0._getConfigProductInfoPrice(arg_12_0, arg_12_1)
	local var_12_0 = StoreConfig.instance:getChargeGoodsConfig(arg_12_1)
	local var_12_1 = "$"
	local var_12_2 = StoreConfig.instance:getChargeGoodsCurrencyCode(arg_12_1)

	if PayEnum.CurrencySymbol[var_12_2] then
		var_12_1 = PayEnum.CurrencySymbol[var_12_2]
	end

	local var_12_3 = StoreConfig.instance:getChargeGoodsPrice(arg_12_1)

	return string.format("%s%s", var_12_1, var_12_3)
end

function var_0_0.getProductOriginAmountMicro(arg_13_0, arg_13_1)
	return arg_13_0._productInfos[arg_13_1].priceAmountMicros
end

function var_0_0.getProductOriginPriceSymbol(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getProductInfoPrice(arg_14_1)
	local var_14_1 = string.find(var_14_0, "%d")

	if not var_14_1 then
		logError("getProductOriginPriceSymbol fail:" .. var_14_0)

		var_14_0 = arg_14_0:_getConfigProductInfoPrice(arg_14_1)
		var_14_1 = string.find(var_14_0, "%d")
	end

	return string.sub(var_14_0, 0, var_14_1 - 1)
end

function var_0_0.getProductOriginPriceNum(arg_15_0, arg_15_1)
	arg_15_0._tmpNum = 0
	arg_15_0._tmpNumStr = "0"
	arg_15_0._tmpIsNoDecimalsCurrency = false

	if not callWithCatch(arg_15_0._getProductOriginPriceNum, arg_15_0, arg_15_1) then
		local var_15_0 = arg_15_0:_getConfigProductInfoPrice(arg_15_1)
		local var_15_1 = arg_15_0:getProductOriginCurrency(arg_15_1)
		local var_15_2 = string.find(var_15_0, "%d")
		local var_15_3 = string.sub(var_15_0, var_15_2, string.len(var_15_0))
		local var_15_4 = string.reverse(var_15_3)
		local var_15_5 = string.find(var_15_4, "%d")
		local var_15_6 = string.len(var_15_4) - var_15_5
		local var_15_7 = string.sub(var_15_3, 1, var_15_6 + 1)

		arg_15_0._tmpNum = string.gsub(var_15_7, ",", "")
		arg_15_0._tmpNum = tonumber(arg_15_0._tmpNum)
		arg_15_0._tmpNumStr = var_15_3
		arg_15_0._tmpIsNoDecimalsCurrency = arg_15_0:isNoDecimalsCurrency(var_15_1)

		if arg_15_0._tmpIsNoDecimalsCurrency then
			arg_15_0._tmpNumStr = math.floor(arg_15_0._tmpNum)
		end
	end

	if string.nilorempty(arg_15_0._tmpNum) then
		arg_15_0._tmpNum = 0
	end

	return arg_15_0._tmpNum, arg_15_0._tmpNumStr, arg_15_0._tmpIsNoDecimalsCurrency
end

function var_0_0._getProductOriginPriceNum(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:getProductInfoPrice(arg_16_1)
	local var_16_1 = arg_16_0:getProductOriginCurrency(arg_16_1)
	local var_16_2 = string.find(var_16_0, "%d")
	local var_16_3 = string.sub(var_16_0, var_16_2, string.len(var_16_0))
	local var_16_4 = string.reverse(var_16_3)
	local var_16_5 = string.find(var_16_4, "%d")
	local var_16_6 = string.len(var_16_4) - var_16_5
	local var_16_7 = string.sub(var_16_3, 1, var_16_6 + 1)
	local var_16_8 = string.gsub(var_16_7, ",", "")

	arg_16_0._tmpNum = tonumber(var_16_8)
	arg_16_0._tmpIsNoDecimalsCurrency = arg_16_0:isNoDecimalsCurrency(var_16_1)
	arg_16_0._tmpNumStr = var_16_3

	if arg_16_0._tmpIsNoDecimalsCurrency and SDKModel.instance:isDmm() == false then
		arg_16_0._tmpNumStr = math.floor(var_16_8)
	end
end

function var_0_0.getProductOriginAmount(arg_17_0, arg_17_1)
	arg_17_0._tmpAmount = 0

	if not callWithCatch(arg_17_0._getProductOriginAmount, arg_17_0, arg_17_1) then
		arg_17_0._tmpAmount = 0

		logError("getProductOriginAmount fail:" .. arg_17_0:getProductInfoPrice(arg_17_1))
	end

	if string.nilorempty(arg_17_0._tmpAmount) then
		arg_17_0._tmpAmount = 0

		logError("getProductOriginAmount fail:" .. arg_17_0:getProductInfoPrice(arg_17_1))
	end

	return arg_17_0._tmpAmount
end

function var_0_0._getProductOriginAmount(arg_18_0, arg_18_1)
	if BootNativeUtil.isWindows() and arg_18_0:getProductInfo(arg_18_1) then
		local var_18_0 = arg_18_0:getProductOriginAmountMicro(arg_18_1)

		if var_18_0 then
			arg_18_0._tmpAmount = var_18_0
		else
			arg_18_0._tmpAmount = 0
		end

		return
	end

	local var_18_1 = arg_18_0:getProductInfoPrice(arg_18_1)
	local var_18_2 = string.find(var_18_1, "%d")
	local var_18_3 = string.sub(var_18_1, var_18_2, string.len(var_18_1))
	local var_18_4 = string.reverse(var_18_3)
	local var_18_5 = string.find(var_18_4, "%d")
	local var_18_6 = string.len(var_18_4) - var_18_5
	local var_18_7 = string.sub(var_18_3, 1, var_18_6 + 1)
	local var_18_8 = string.gsub(var_18_7, ",", "")
	local var_18_9 = tonumber(var_18_8) * 100
	local var_18_10 = string.find(var_18_9, "%.")

	if var_18_10 then
		var_18_9 = string.sub(var_18_9, 0, var_18_10 - 1)
		var_18_9 = tonumber(var_18_9)
	else
		var_18_9 = string.sub(var_18_9, 0, string.len(var_18_9))
		var_18_9 = tonumber(var_18_9)
	end

	arg_18_0._tmpAmount = var_18_9
end

return var_0_0
