module("modules.logic.currency.controller.CurrencyController", package.seeall)

local var_0_0 = class("CurrencyController", BaseController)

function var_0_0.onInit(arg_1_0)
	CurrencyJumpHandler.clearHandlers()
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_3_0._OnDailyRefresh, arg_3_0)
	LoginController.instance:registerCallback(LoginEvent.OnBeginLogout, arg_3_0._onBeginLogout, arg_3_0)
end

function var_0_0.reInit(arg_4_0)
	CurrencyJumpHandler.clearHandlers()
end

function var_0_0._OnDailyRefresh(arg_5_0)
	CurrencyRpc.instance:sendGetBuyPowerInfoRequest()

	local var_5_0 = Activity104Model.instance:getCurSeasonId()
	local var_5_1 = SeasonConfig.instance:getRetailTicket(var_5_0)
	local var_5_2 = {}

	if var_5_1 then
		table.insert(var_5_2, var_5_1)
	end

	local var_5_3 = Season123Model.instance:getCurSeasonId()

	if var_5_3 then
		local var_5_4 = Season123Config.instance:getEquipItemCoin(var_5_3, Activity123Enum.Const.UttuTicketsCoin)

		if var_5_4 then
			table.insert(var_5_2, var_5_4)
		end
	end

	if #var_5_2 > 0 then
		CurrencyRpc.instance:sendGetCurrencyListRequest(var_5_2)
	end
end

function var_0_0.openPowerView(arg_6_0, arg_6_1, arg_6_2)
	ViewMgr.instance:openView(ViewName.PowerView, arg_6_1, arg_6_2)
end

function var_0_0._onBeginLogout(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0._checkPowerRecover, arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0._autoUseExpirePowerItem, arg_7_0)
end

function var_0_0.powerRecover(arg_8_0)
	local var_8_0 = PlayerModel.instance:getPlayinfo().level
	local var_8_1 = PlayerConfig.instance:getPlayerLevelCO(var_8_0)

	if not var_8_1 then
		return
	end

	local var_8_2 = var_8_1.maxAutoRecoverPower
	local var_8_3 = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Power)
	local var_8_4 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Power)

	if not var_8_4 then
		return
	end

	if var_8_2 <= var_8_4.quantity then
		return
	end

	arg_8_0._recoverEndTime = var_8_4.lastRecoverTime / 1000 + var_8_3.recoverTime

	TaskDispatcher.runRepeat(arg_8_0._checkPowerRecover, arg_8_0, 1)
end

function var_0_0._checkPowerRecover(arg_9_0)
	if arg_9_0._recoverEndTime <= ServerTime.now() then
		TaskDispatcher.cancelTask(arg_9_0._checkPowerRecover, arg_9_0)
		CurrencyRpc.instance:sendGetCurrencyListRequest({
			CurrencyEnum.CurrencyType.Power
		})
	end
end

function var_0_0.checkFreeDiamondEnough(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5, arg_10_6, arg_10_7)
	local var_10_0 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.FreeDiamondCoupon)

	if var_10_0 then
		if arg_10_1 <= var_10_0.quantity then
			return true
		else
			local var_10_1 = arg_10_1 - var_10_0.quantity
			local var_10_2 = {
				isExchangeStep = true,
				msg = MessageBoxConfig.instance:getMessage(MessageBoxIdDefine.FreeDiamondExchange),
				extra = {
					var_10_1
				},
				needDiamond = var_10_1,
				srcType = arg_10_2,
				callback = arg_10_4,
				callbackObj = arg_10_5,
				jumpCallBack = arg_10_6,
				jumpCallbackObj = arg_10_7
			}
			local var_10_3 = ViewMgr.instance:getSetting(ViewName.CurrencyExchangeView)

			if arg_10_3 then
				var_10_3.anim = nil
			else
				var_10_3.anim = ViewAnim.Default
			end

			ViewMgr.instance:openView(ViewName.CurrencyExchangeView, var_10_2)

			return false
		end
	else
		logError("can't find freeDiamond MO")

		return false
	end
end

function var_0_0.checkExchangeFreeDiamond(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6, arg_11_7, arg_11_8, arg_11_9, arg_11_10, arg_11_11)
	local var_11_0 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Diamond)

	if var_11_0 then
		if arg_11_1 <= var_11_0.quantity then
			CurrencyRpc.instance:sendExchangeDiamondRequest(arg_11_1, arg_11_2, arg_11_3, arg_11_4)

			return false
		elseif OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.BanDiamond) then
			GameFacade.showToast(ToastEnum.ExchangeFreeDiamond)

			return false
		else
			local var_11_1 = arg_11_1 - var_11_0.quantity
			local var_11_2 = {
				isExchangeStep = false,
				msg = arg_11_7 ~= nil and arg_11_7 or MessageBoxConfig.instance:getMessage(MessageBoxIdDefine.PayDiamondNotEnough),
				needDiamond = var_11_1,
				jumpCallBack = arg_11_5,
				jumpCallbackObj = arg_11_6,
				extra = arg_11_8,
				costData = arg_11_9,
				noCallback = arg_11_10,
				noCallbackObj = arg_11_11
			}

			ViewMgr.instance:openView(ViewName.CurrencyExchangeView, var_11_2)

			return true
		end
	else
		logError("can't find payDiamond MO")

		return false
	end
end

function var_0_0.checkDiamondEnough(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Diamond)

	if var_12_0 then
		if arg_12_1 <= var_12_0.quantity then
			return true
		else
			if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.BanDiamond) then
				GameFacade.showToast(ToastEnum.ExchangeFreeDiamond)
			else
				local var_12_1 = arg_12_1 - var_12_0.quantity
				local var_12_2 = {
					isExchangeStep = false,
					msg = MessageBoxConfig.instance:getMessage(MessageBoxIdDefine.PayDiamondNotEnough),
					needDiamond = var_12_1,
					jumpCallBack = arg_12_2,
					jumpCallbackObj = arg_12_3
				}

				ViewMgr.instance:openView(ViewName.CurrencyExchangeView, var_12_2)
			end

			return false
		end
	else
		logError("can't find payDiamond MO")

		return false
	end
end

function var_0_0.getPowerItemDeadLineTime(arg_13_0)
	local var_13_0
	local var_13_1 = ItemPowerModel.instance:getPowerItemList() or {}

	for iter_13_0, iter_13_1 in pairs(var_13_1) do
		if ItemConfig.instance:getPowerItemCo(iter_13_1.id).expireType ~= 0 and ItemPowerModel.instance:getPowerItemCount(iter_13_1.uid) > 0 then
			local var_13_2 = ItemPowerModel.instance:getPowerItemDeadline(iter_13_1.uid)

			if not var_13_0 or var_13_2 < var_13_0 then
				var_13_0 = var_13_2
			end
		end
	end

	return var_13_0
end

function var_0_0.checkToUseExpirePowerItem(arg_14_0)
	TaskDispatcher.runRepeat(arg_14_0._autoUseExpirePowerItem, arg_14_0, 1)
end

function var_0_0._autoUseExpirePowerItem(arg_15_0)
	local var_15_0 = arg_15_0:getPowerItemDeadLineTime()

	if not var_15_0 then
		TaskDispatcher.cancelTask(arg_15_0._autoUseExpirePowerItem, arg_15_0)

		return
	end

	if var_15_0 and var_15_0 > 0 and var_15_0 - ServerTime.now() <= 0 then
		ItemRpc.instance:sendAutoUseExpirePowerItemRequest()
		TaskDispatcher.cancelTask(arg_15_0._autoUseExpirePowerItem, arg_15_0)
	end
end

function var_0_0.checkFreeDiamondEnoughDaily(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5, arg_16_6, arg_16_7, arg_16_8, arg_16_9, arg_16_10, arg_16_11)
	local var_16_0 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.FreeDiamondCoupon)

	if var_16_0 then
		if arg_16_1 <= var_16_0.quantity then
			return true
		else
			local var_16_1 = arg_16_1 - var_16_0.quantity
			local var_16_2 = MessageBoxConfig.instance:getMessage(MessageBoxIdDefine.FreeDiamondExchange)

			if CurrencyEnum.PayDiamondExchangeSource.Summon then
				var_16_2 = MessageBoxConfig.instance:getMessage(MessageBoxIdDefine.FreeDiamondNotEnough_Summon)
			end

			local var_16_3 = {
				isShowDailySure = true,
				isExchangeStep = true,
				msg = var_16_2,
				extra = {
					arg_16_8,
					var_16_1
				},
				needDiamond = var_16_1,
				srcType = arg_16_2,
				callback = arg_16_4,
				callbackObj = arg_16_5,
				jumpCallBack = arg_16_6,
				jumpCallbackObj = arg_16_7,
				costData = arg_16_9,
				noCallback = arg_16_10,
				noCallbackObj = arg_16_11
			}
			local var_16_4 = ViewMgr.instance:getSetting(ViewName.CurrencyExchangeView)

			if arg_16_3 then
				var_16_4.anim = nil
			else
				var_16_4.anim = ViewAnim.Default
			end

			arg_16_0:openCurrencyExchangeView(var_16_3)

			return false
		end
	else
		logError("can't find freeDiamond MO")

		return false
	end
end

function var_0_0.openCurrencyExchangeView(arg_17_0, arg_17_1)
	if not arg_17_0:canShowCurrencyExchangeView(arg_17_1) then
		arg_17_0:checkCurrencyExchange(arg_17_1)

		return
	end

	ViewMgr.instance:openView(ViewName.CurrencyExchangeView, arg_17_1)
end

function var_0_0.canShowCurrencyExchangeView(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0:getOptionLocalKey(arg_18_1.srcType)

	return (TimeUtil.getDayFirstLoginRed(var_18_0))
end

function var_0_0.getOptionLocalKey(arg_19_0, arg_19_1)
	return string.format("SummonConfirmView#%s%s", tostring(PlayerModel.instance:getPlayinfo().userId), tostring(arg_19_1))
end

function var_0_0.checkCurrencyExchange(arg_20_0, arg_20_1)
	local var_20_0 = false

	if arg_20_1.isExchangeStep then
		var_20_0 = var_0_0.instance:checkExchangeFreeDiamond(arg_20_1.needDiamond, arg_20_1.srcType, arg_20_1.callback, arg_20_1.callbackObj, arg_20_1.jumpCallBack, arg_20_1.jumpCallbackObj, MessageBoxConfig.instance:getMessage(MessageBoxIdDefine.PayDiamondNotEnough_Summon), {
			arg_20_1.extra[1]
		}, arg_20_1.costData, arg_20_1.noCallback, arg_20_1.noCallbackObj)
	else
		if arg_20_1.jumpCallBack then
			arg_20_1.jumpCallBack(arg_20_1.jumpCallbackObj)
		end

		StoreController.instance:checkAndOpenStoreView(StoreEnum.ChargeStoreTabId)
	end

	if arg_20_1.yesCallback then
		arg_20_1.yesCallback()
	end

	return var_20_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
