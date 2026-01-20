-- chunkname: @modules/logic/pay/model/PayModel.lua

module("modules.logic.pay.model.PayModel", package.seeall)

local PayModel = class("PayModel", BaseModel)

function PayModel:onInit()
	self._chargeInfos = {}
	self._productInfos = {}
	self._orderInfo = {}
	self._sandboxEnable = false
	self._sandboxBalance = 0
	self._hasInitProductInfo = false
end

function PayModel:reInit()
	self._productInfos = {}
	self._chargeInfos = {}
	self._orderInfo = {}
	self._sandboxEnable = false
	self._sandboxBalance = 0
	self._hasInitProductInfo = false
end

function PayModel:setSandboxInfo(sandboxEnable, sandboxBalance)
	self._sandboxEnable = sandboxEnable
	self._sandboxBalance = sandboxBalance
end

function PayModel:updateSandboxBalance(sandboxBalance)
	self._sandboxBalance = sandboxBalance
end

function PayModel:setChargeInfo(info)
	for _, v in ipairs(info) do
		self._chargeInfos[v.id] = v
	end
end

function PayModel:hasInitProductInfo()
	if BootNativeUtil.isWindows() and GameChannelConfig.isGpGlobal() == false then
		return true
	end

	return self._hasInitProductInfo
end

function PayModel:setProductInfo(infoStr)
	if string.nilorempty(infoStr) == false and infoStr ~= "null" then
		local allJson = cjson.decode(infoStr)

		for _, v in pairs(allJson) do
			if BootNativeUtil.isWindows() then
				local goodsId = tonumber(v.productId)

				if goodsId and GameChannelConfig.isLongCheng() == false and GameChannelConfig.isGpJapan() == false then
					self._productInfos[goodsId] = v
				end

				self._hasInitProductInfo = true
			else
				local configList = StoreConfig.instance:getStoreChargeConfigByProductID(v.productId)

				for i, config in ipairs(configList) do
					self._hasInitProductInfo = true

					if GameChannelConfig.isLongCheng() == false and GameChannelConfig.isGpJapan() == false then
						self._productInfos[config.id] = v
					end
				end

				if #configList == 0 then
					logError("找不到对应充值商品：" .. v.productId)
				end
			end
		end
	end
end

function PayModel:setOrderInfo(info)
	self._orderInfo = {}
	self._orderInfo.id = info.id

	if info.passBackParam then
		self._orderInfo.passBackParam = info.passBackParam
	end

	self._orderInfo.notifyUrl = info.notifyUrl and info.notifyUrl or ""
	self._orderInfo.gameOrderId = info.gameOrderId
	self._orderInfo.timestamp = info.timestamp
	self._orderInfo.sign = info.sign
	self._orderInfo.serverId = info.serverId
	self._orderInfo.currency = info.currency
end

function PayModel:clearOrderInfo()
	self._orderInfo = {}
end

function PayModel:getSandboxEnable()
	return self._sandboxEnable
end

function PayModel:getSandboxBalance()
	return self._sandboxBalance
end

function PayModel:getOrderInfo()
	return self._orderInfo
end

function PayModel:getGamePayInfo()
	if not self._orderInfo.id then
		return ""
	end

	local chargeConfig = StoreConfig.instance:getChargeGoodsConfig(self._orderInfo.id)
	local playerinfo = PlayerModel.instance:getPlayinfo()
	local payInfo = {}

	payInfo.gameRoleInfo = self:getGameRoleInfo(true)
	payInfo.gameRoleInfo.roleEstablishTime = tonumber(playerinfo.registerTime)
	payInfo.currency = self._orderInfo.currency
	payInfo.amount = math.ceil(100 * StoreConfig.instance:getBaseChargeGoodsPrice(chargeConfig.id))
	payInfo.goodsId = self._orderInfo.id
	payInfo.goodsName = chargeConfig.name
	payInfo.goodsDesc = chargeConfig.desc
	payInfo.gameOrderId = self._orderInfo.gameOrderId
	payInfo.passBackParam = self._orderInfo.passBackParam and self._orderInfo.passBackParam or ""
	payInfo.notifyUrl = self._orderInfo.notifyUrl
	payInfo.timestamp = self._orderInfo.timestamp
	payInfo.sign = self._orderInfo.sign

	if SLFramework.FrameworkSettings.IsEditor then
		payInfo.productId = ""
	else
		local channelId = SDKMgr.instance:getChannelId()
		local channelIdChargeConfig = StoreConfig.instance:getStoreChargeConfig(self._orderInfo.id, BootNativeUtil.getPackageName() .. "_" .. channelId, true)

		if channelIdChargeConfig then
			payInfo.productId = channelIdChargeConfig.appStoreProductID
		else
			payInfo.productId = StoreConfig.instance:getStoreChargeConfig(self._orderInfo.id, BootNativeUtil.getPackageName()).appStoreProductID
		end
	end

	payInfo.originCurrency = self:getProductOriginCurrency(self._orderInfo.id)
	payInfo.originAmount = self:getProductOriginAmount(self._orderInfo.id)

	return payInfo
end

function PayModel:getProductInfo(id)
	return self._productInfos[id]
end

function PayModel:getProductPrice(id)
	local symbol = self:getProductOriginPriceSymbol(id)
	local num, numStr = self:getProductOriginPriceNum(id)

	return string.format("%s%s", symbol, numStr)
end

function PayModel:getProductOriginCurrency(id)
	if self._productInfos[id] and self._productInfos[id].priceCurrencyCode then
		return self._productInfos[id].priceCurrencyCode
	else
		return StoreConfig.instance:getChargeGoodsCurrencyCode(id)
	end
end

function PayModel:getProductInfoPrice(id)
	if self._productInfos[id] and self._productInfos[id].price then
		return self._productInfos[id].price
	else
		local chargeConfig = StoreConfig.instance:getChargeGoodsConfig(id)
		local symbol = "$"
		local currencyCode = StoreConfig.instance:getChargeGoodsCurrencyCode(id)

		if PayEnum.CurrencySymbol[currencyCode] then
			symbol = PayEnum.CurrencySymbol[currencyCode]
		end

		local price = StoreConfig.instance:getChargeGoodsPrice(id)

		if SDKModel.instance:isDmm() then
			return string.format("%spt", price)
		else
			return string.format("%s%s", symbol, price)
		end
	end
end

function PayModel:_getConfigProductInfoPrice(id)
	local chargeConfig = StoreConfig.instance:getChargeGoodsConfig(id)
	local symbol = "$"
	local currencyCode = StoreConfig.instance:getChargeGoodsCurrencyCode(id)

	if PayEnum.CurrencySymbol[currencyCode] then
		symbol = PayEnum.CurrencySymbol[currencyCode]
	end

	local price = StoreConfig.instance:getChargeGoodsPrice(id)

	return string.format("%s%s", symbol, price)
end

function PayModel:getProductOriginAmountMicro(id)
	return self._productInfos[id].priceAmountMicros
end

function PayModel:getProductOriginPriceSymbol(id)
	local str = self:getProductInfoPrice(id)
	local index = string.find(str, "%d")

	if not index then
		logError("getProductOriginPriceSymbol fail:" .. str)

		str = self:_getConfigProductInfoPrice(id)
		index = string.find(str, "%d")
	end

	return string.sub(str, 0, index - 1)
end

function PayModel:getProductOriginPriceNum(id)
	self._tmpNum = 0
	self._tmpNumStr = "0"
	self._tmpIsNoDecimalsCurrency = false

	if not callWithCatch(self._getProductOriginPriceNum, self, id) then
		local str = self:_getConfigProductInfoPrice(id)
		local code = self:getProductOriginCurrency(id)
		local index = string.find(str, "%d")
		local numStr = string.sub(str, index, string.len(str))
		local reverseStr = string.reverse(numStr)
		local lastIndex = string.find(reverseStr, "%d")

		lastIndex = string.len(reverseStr) - lastIndex

		local numStr2 = string.sub(numStr, 1, lastIndex + 1)

		self._tmpNum = string.gsub(numStr2, ",", "")
		self._tmpNum = tonumber(self._tmpNum)
		self._tmpNumStr = numStr
		self._tmpIsNoDecimalsCurrency = self:isNoDecimalsCurrency(code)

		if self._tmpIsNoDecimalsCurrency then
			self._tmpNumStr = math.floor(self._tmpNum)
		end
	end

	if string.nilorempty(self._tmpNum) then
		self._tmpNum = 0
	end

	return self._tmpNum, self._tmpNumStr, self._tmpIsNoDecimalsCurrency
end

function PayModel:_getProductOriginPriceNum(id)
	local str = self:getProductInfoPrice(id)
	local code = self:getProductOriginCurrency(id)
	local index = string.find(str, "%d")
	local numStr = string.sub(str, index, string.len(str))
	local reverseStr = string.reverse(numStr)
	local lastIndex = string.find(reverseStr, "%d")

	lastIndex = string.len(reverseStr) - lastIndex

	local numStr2 = string.sub(numStr, 1, lastIndex + 1)
	local num = string.gsub(numStr2, ",", "")

	self._tmpNum = tonumber(num)
	self._tmpIsNoDecimalsCurrency = self:isNoDecimalsCurrency(code)
	self._tmpNumStr = numStr

	if self._tmpIsNoDecimalsCurrency and SDKModel.instance:isDmm() == false then
		self._tmpNumStr = math.floor(num)
	end
end

function PayModel:isNoDecimalsCurrency(code)
	return PayEnum.NoDecimalsCurrency[code] ~= nil
end

function PayModel:getProductOriginAmount(id)
	self._tmpAmount = 0

	if not callWithCatch(self._getProductOriginAmount, self, id) then
		self._tmpAmount = 0

		logError("getProductOriginAmount fail:" .. self:getProductInfoPrice(id))
	end

	if string.nilorempty(self._tmpAmount) then
		self._tmpAmount = 0

		logError("getProductOriginAmount fail:" .. self:getProductInfoPrice(id))
	end

	return self._tmpAmount
end

function PayModel:_getProductOriginAmount(id)
	if BootNativeUtil.isWindows() and self:getProductInfo(id) then
		local originAmountMicro = self:getProductOriginAmountMicro(id)

		if originAmountMicro then
			self._tmpAmount = originAmountMicro
		else
			self._tmpAmount = 0
		end

		return
	end

	local str = self:getProductInfoPrice(id)
	local index = string.find(str, "%d")
	local num = string.sub(str, index, string.len(str))
	local reverseStr = string.reverse(num)
	local lastIndex = string.find(reverseStr, "%d")

	lastIndex = string.len(reverseStr) - lastIndex

	local numStr2 = string.sub(num, 1, lastIndex + 1)

	num = string.gsub(numStr2, ",", "")
	num = tonumber(num)
	num = num * 100
	index = string.find(num, "%.")

	if index then
		num = string.sub(num, 0, index - 1)
		num = tonumber(num)
	else
		num = string.sub(num, 0, string.len(num))
		num = tonumber(num)
	end

	self._tmpAmount = num
end

function PayModel:getGameRoleInfo(pay)
	local playerinfo = PlayerModel.instance:getPlayinfo()
	local freeDiamond = CurrencyModel.instance:getFreeDiamond()
	local diamond = CurrencyModel.instance:getDiamond()
	local roleInfo = {}

	roleInfo.roleId = tostring(playerinfo.userId)
	roleInfo.roleName = tostring(playerinfo.name)
	roleInfo.currentLevel = tonumber(playerinfo.level)
	roleInfo.vipLevel = 0

	local serverId = tostring(LoginModel.instance.serverId)

	if pay and self._orderInfo.serverId > 0 then
		serverId = self._orderInfo.serverId
	end

	local lastEpisodeConfig = DungeonConfig.instance:getEpisodeCO(playerinfo.lastEpisodeId)
	local curProgress = lastEpisodeConfig and tostring(lastEpisodeConfig.name .. lastEpisodeConfig.id) or ""

	roleInfo.serverId = serverId
	roleInfo.serverName = tostring(LoginModel.instance.serverName)
	roleInfo.roleCTime = tonumber(playerinfo.registerTime)
	roleInfo.loginTime = tonumber(playerinfo.lastLoginTime)
	roleInfo.logoutTime = tonumber(playerinfo.lastLogoutTime)
	roleInfo.accountRegisterTime = tonumber(playerinfo.registerTime)
	roleInfo.giveCurrencyNum = freeDiamond
	roleInfo.paidCurrencyNum = diamond
	roleInfo.currencyNum = freeDiamond + diamond
	roleInfo.currentProgress = curProgress
	roleInfo.roleEstablishTime = tonumber(playerinfo.registerTime)
	roleInfo.guildLevel = tonumber(playerinfo.level)
	roleInfo.roleType = StatModel.instance:getRoleType()
	roleInfo.gameEnv = VersionValidator.instance:isInReviewing() and 1 or 0

	return roleInfo
end

function PayModel:getQuickUseInfo()
	if not self._orderInfo then
		return
	end

	local goodsId = self._orderInfo.id
	local chargeGoodsConfig = StoreConfig.instance:getChargeGoodsConfig(goodsId)

	if not chargeGoodsConfig then
		return
	end

	local quickUseItemList = chargeGoodsConfig.quickUseItemList

	if string.nilorempty(quickUseItemList) then
		return
	end

	local itemList = GameUtil.splitString2(quickUseItemList, true, "|", "#")

	if not itemList or #itemList == 0 then
		return
	end

	return {
		goodsId = goodsId,
		chargeGoodsConfig = chargeGoodsConfig,
		itemList = itemList
	}
end

PayModel.instance = PayModel.New()

return PayModel
