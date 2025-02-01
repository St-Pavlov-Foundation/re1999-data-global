module("modules.logic.currency.controller.CurrencyController", package.seeall)

slot0 = class("CurrencyController", BaseController)

function slot0.onInit(slot0)
	CurrencyJumpHandler.clearHandlers()
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0._OnDailyRefresh, slot0)
	LoginController.instance:registerCallback(LoginEvent.OnBeginLogout, slot0._onBeginLogout, slot0)
end

function slot0.reInit(slot0)
	CurrencyJumpHandler.clearHandlers()
end

function slot0._OnDailyRefresh(slot0)
	CurrencyRpc.instance:sendGetBuyPowerInfoRequest()

	if SeasonConfig.instance:getRetailTicket(Activity104Model.instance:getCurSeasonId()) then
		table.insert({}, slot2)
	end

	if Season123Model.instance:getCurSeasonId() and Season123Config.instance:getEquipItemCoin(slot4, Activity123Enum.Const.UttuTicketsCoin) then
		table.insert(slot3, slot5)
	end

	if #slot3 > 0 then
		CurrencyRpc.instance:sendGetCurrencyListRequest(slot3)
	end
end

function slot0.openPowerView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.PowerView, slot1, slot2)
end

function slot0._onBeginLogout(slot0)
	TaskDispatcher.cancelTask(slot0._checkPowerRecover, slot0)
	TaskDispatcher.cancelTask(slot0._autoUseExpirePowerItem, slot0)
end

function slot0.powerRecover(slot0)
	if not PlayerConfig.instance:getPlayerLevelCO(PlayerModel.instance:getPlayinfo().level) then
		return
	end

	slot3 = slot2.maxAutoRecoverPower
	slot4 = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Power)

	if not CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Power) then
		return
	end

	if slot3 <= slot5.quantity then
		return
	end

	slot0._recoverEndTime = slot5.lastRecoverTime / 1000 + slot4.recoverTime

	TaskDispatcher.runRepeat(slot0._checkPowerRecover, slot0, 1)
end

function slot0._checkPowerRecover(slot0)
	if slot0._recoverEndTime <= ServerTime.now() then
		TaskDispatcher.cancelTask(slot0._checkPowerRecover, slot0)
		CurrencyRpc.instance:sendGetCurrencyListRequest({
			CurrencyEnum.CurrencyType.Power
		})
	end
end

function slot0.checkFreeDiamondEnough(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	if CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.FreeDiamondCoupon) then
		if slot1 <= slot8.quantity then
			return true
		else
			slot9 = slot1 - slot8.quantity
			slot10 = {
				isExchangeStep = true,
				msg = slot11:getMessage(MessageBoxIdDefine.FreeDiamondExchange),
				extra = {
					slot9
				},
				needDiamond = slot9,
				srcType = slot2,
				callback = slot4,
				callbackObj = slot5,
				jumpCallBack = slot6,
				jumpCallbackObj = slot7
			}
			slot11 = MessageBoxConfig.instance

			if slot3 then
				ViewMgr.instance:getSetting(ViewName.CurrencyExchangeView).anim = nil
			else
				slot11.anim = ViewAnim.Default
			end

			ViewMgr.instance:openView(ViewName.CurrencyExchangeView, slot10)

			return false
		end
	else
		logError("can't find freeDiamond MO")

		return false
	end
end

function slot0.checkExchangeFreeDiamond(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	if CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Diamond) then
		if slot1 <= slot7.quantity then
			CurrencyRpc.instance:sendExchangeDiamondRequest(slot1, slot2, slot3, slot4)

			return false
		elseif OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.BanDiamond) then
			GameFacade.showToast(ToastEnum.ExchangeFreeDiamond)

			return false
		else
			ViewMgr.instance:openView(ViewName.CurrencyExchangeView, {
				isExchangeStep = false,
				msg = MessageBoxConfig.instance:getMessage(MessageBoxIdDefine.PayDiamondNotEnough),
				needDiamond = slot1 - slot7.quantity,
				jumpCallBack = slot5,
				jumpCallbackObj = slot6
			})

			return true
		end
	else
		logError("can't find payDiamond MO")

		return false
	end
end

function slot0.checkDiamondEnough(slot0, slot1, slot2, slot3)
	if CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Diamond) then
		if slot1 <= slot4.quantity then
			return true
		else
			if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.BanDiamond) then
				GameFacade.showToast(ToastEnum.ExchangeFreeDiamond)
			else
				ViewMgr.instance:openView(ViewName.CurrencyExchangeView, {
					isExchangeStep = false,
					msg = MessageBoxConfig.instance:getMessage(MessageBoxIdDefine.PayDiamondNotEnough),
					needDiamond = slot1 - slot4.quantity,
					jumpCallBack = slot2,
					jumpCallbackObj = slot3
				})
			end

			return false
		end
	else
		logError("can't find payDiamond MO")

		return false
	end
end

function slot0.getPowerItemDeadLineTime(slot0)
	slot1 = nil

	for slot6, slot7 in pairs(ItemPowerModel.instance:getPowerItemList() or {}) do
		if ItemConfig.instance:getPowerItemCo(slot7.id).expireType ~= 0 and ItemPowerModel.instance:getPowerItemCount(slot7.uid) > 0 then
			slot9 = ItemPowerModel.instance:getPowerItemDeadline(slot7.uid)

			if not slot1 or slot9 < slot1 then
				slot1 = slot9
			end
		end
	end

	return slot1
end

function slot0.checkToUseExpirePowerItem(slot0)
	TaskDispatcher.runRepeat(slot0._autoUseExpirePowerItem, slot0, 1)
end

function slot0._autoUseExpirePowerItem(slot0)
	if not slot0:getPowerItemDeadLineTime() then
		TaskDispatcher.cancelTask(slot0._autoUseExpirePowerItem, slot0)

		return
	end

	if slot1 and slot1 > 0 and slot1 - ServerTime.now() <= 0 then
		ItemRpc.instance:sendAutoUseExpirePowerItemRequest()
		TaskDispatcher.cancelTask(slot0._autoUseExpirePowerItem, slot0)
	end
end

slot0.instance = slot0.New()

return slot0
