module("modules.logic.pay.model.PayModelBase", package.seeall)

local var_0_0 = LuaUtil.class("PayModelBase", BaseModel)

function var_0_0.ctor(arg_1_0)
	assert(false, "PayModelBase is an abstract class, please use PayModel instead.")
end

function var_0_0.onInit(arg_2_0)
	arg_2_0._chargeInfos = {}
	arg_2_0._orderInfo = {}
	arg_2_0._sandboxEnable = false
	arg_2_0._sandboxBalance = 0
end

function var_0_0.reInit(arg_3_0)
	arg_3_0._chargeInfos = {}
	arg_3_0._orderInfo = {}
	arg_3_0._sandboxEnable = false
	arg_3_0._sandboxBalance = 0
end

function var_0_0.setSandboxInfo(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._sandboxEnable = arg_4_1
	arg_4_0._sandboxBalance = arg_4_2
end

function var_0_0.updateSandboxBalance(arg_5_0, arg_5_1)
	arg_5_0._sandboxBalance = arg_5_1
end

function var_0_0.setChargeInfo(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		arg_6_0._chargeInfos[iter_6_1.id] = iter_6_1
	end
end

function var_0_0.setOrderInfo(arg_7_0, arg_7_1)
	arg_7_0._orderInfo = {}
	arg_7_0._orderInfo.id = arg_7_1.id

	if arg_7_1.passBackParam then
		arg_7_0._orderInfo.passBackParam = arg_7_1.passBackParam
	end

	arg_7_0._orderInfo.notifyUrl = arg_7_1.notifyUrl and arg_7_1.notifyUrl or ""
	arg_7_0._orderInfo.gameOrderId = arg_7_1.gameOrderId
	arg_7_0._orderInfo.timestamp = arg_7_1.timestamp
	arg_7_0._orderInfo.sign = arg_7_1.sign
	arg_7_0._orderInfo.serverId = arg_7_1.serverId
end

function var_0_0.clearOrderInfo(arg_8_0)
	arg_8_0._orderInfo = {}
end

function var_0_0.getSandboxEnable(arg_9_0)
	return arg_9_0._sandboxEnable
end

function var_0_0.getSandboxBalance(arg_10_0)
	return arg_10_0._sandboxBalance
end

function var_0_0.getOrderInfo(arg_11_0)
	return arg_11_0._orderInfo
end

function var_0_0.getGamePayInfo(arg_12_0)
	if not arg_12_0._orderInfo.id then
		return {}
	end

	local var_12_0 = StoreConfig.instance:getChargeGoodsConfig(arg_12_0._orderInfo.id)
	local var_12_1 = PlayerModel.instance:getPlayinfo()
	local var_12_2 = {
		gameRoleInfo = arg_12_0:getGameRoleInfo(true)
	}

	var_12_2.gameRoleInfo.roleEstablishTime = tonumber(var_12_1.registerTime)
	var_12_2.amount = math.ceil(100 * var_12_0.price)
	var_12_2.goodsId = arg_12_0._orderInfo.id
	var_12_2.goodsName = var_12_0.name
	var_12_2.goodsDesc = var_12_0.desc
	var_12_2.gameOrderId = arg_12_0._orderInfo.gameOrderId
	var_12_2.passBackParam = arg_12_0._orderInfo.passBackParam and arg_12_0._orderInfo.passBackParam or ""
	var_12_2.notifyUrl = arg_12_0._orderInfo.notifyUrl
	var_12_2.timestamp = arg_12_0._orderInfo.timestamp
	var_12_2.sign = arg_12_0._orderInfo.sign
	var_12_2.productId = BootNativeUtil.isIOS() and StoreConfig.instance:getStoreChargeConfig(arg_12_0._orderInfo.id, BootNativeUtil.getPackageName()).appStoreProductID or ""

	return var_12_2
end

function var_0_0.getGameRoleInfo(arg_13_0, arg_13_1)
	local var_13_0 = PlayerModel.instance:getPlayinfo()
	local var_13_1 = CurrencyModel.instance:getFreeDiamond()
	local var_13_2 = CurrencyModel.instance:getDiamond()
	local var_13_3 = {
		roleId = tostring(var_13_0.userId),
		roleName = tostring(var_13_0.name),
		currentLevel = tonumber(var_13_0.level)
	}

	var_13_3.vipLevel = 0

	local var_13_4 = tostring(LoginModel.instance.serverId)

	if arg_13_1 and arg_13_0._orderInfo.serverId > 0 then
		var_13_4 = arg_13_0._orderInfo.serverId
	end

	local var_13_5 = DungeonConfig.instance:getEpisodeCO(var_13_0.lastEpisodeId)
	local var_13_6 = var_13_5 and tostring(var_13_5.name .. var_13_5.id) or ""

	var_13_3.serverId = var_13_4
	var_13_3.serverName = tostring(LoginModel.instance.serverName)
	var_13_3.roleCTime = tonumber(var_13_0.registerTime)
	var_13_3.loginTime = tonumber(var_13_0.lastLoginTime)
	var_13_3.logoutTime = tonumber(var_13_0.lastLogoutTime)
	var_13_3.accountRegisterTime = tonumber(var_13_0.registerTime)
	var_13_3.giveCurrencyNum = var_13_1
	var_13_3.paidCurrencyNum = var_13_2
	var_13_3.currencyNum = var_13_1 + var_13_2
	var_13_3.currentProgress = var_13_6
	var_13_3.roleEstablishTime = tonumber(var_13_0.registerTime)
	var_13_3.guildLevel = tonumber(var_13_0.level)
	var_13_3.roleType = StatModel.instance:getRoleType()
	var_13_3.gameEnv = VersionValidator.instance:isInReviewing() and 1 or 0

	return var_13_3
end

function var_0_0.getQuickUseInfo(arg_14_0)
	if not arg_14_0._orderInfo then
		return
	end

	local var_14_0 = arg_14_0._orderInfo.id
	local var_14_1 = StoreConfig.instance:getChargeGoodsConfig(var_14_0)

	if not var_14_1 then
		return
	end

	local var_14_2 = var_14_1.quickUseItemList

	if string.nilorempty(var_14_2) then
		return
	end

	local var_14_3 = GameUtil.splitString2(var_14_2, true, "|", "#")

	if not var_14_3 or #var_14_3 == 0 then
		return
	end

	return {
		goodsId = var_14_0,
		chargeGoodsConfig = var_14_1,
		itemList = var_14_3
	}
end

function var_0_0.isNoDecimalsCurrency(arg_15_0, arg_15_1)
	return PayEnum.NoDecimalsCurrency[arg_15_1] ~= nil
end

function var_0_0.getProductPrice(arg_16_0, arg_16_1)
	assert(false, "please override this function!!")
end

function var_0_0.getProductOriginPriceNum(arg_17_0, arg_17_1)
	assert(false, "please override this function!!")
end

function var_0_0.getProductOriginCurrency(arg_18_0, arg_18_1)
	assert(false, "please override this function!!")
end

function var_0_0.getProductOriginPriceSymbol(arg_19_0, arg_19_1)
	assert(false, "please override this function!!")
end

return var_0_0
