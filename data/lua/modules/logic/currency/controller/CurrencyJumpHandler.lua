module("modules.logic.currency.controller.CurrencyJumpHandler", package.seeall)

local var_0_0 = class("CurrencyJumpHandler")

function var_0_0.JumpByCurrency(arg_1_0)
	if not var_0_0._handlerMap then
		var_0_0._handlerMap = {
			[CurrencyEnum.CurrencyType.Power] = var_0_0.handlePower,
			[CurrencyEnum.CurrencyType.Diamond] = var_0_0.handlePayDiamond,
			[CurrencyEnum.CurrencyType.FreeDiamondCoupon] = var_0_0.handleFreeDiamond,
			[CurrencyEnum.CurrencyType.Gold] = var_0_0.handleGold,
			[CurrencyEnum.CurrencyType.DryForest] = var_0_0.handleDryForest,
			[CurrencyEnum.CurrencyType.RoomCritterTrain] = var_0_0.handleRoomCritterTrain
		}
	end

	local var_1_0 = var_0_0._handlerMap[arg_1_0]

	if var_1_0 then
		var_1_0()
	end
end

function var_0_0.handleGold()
	StoreController.instance:checkAndOpenStoreView(StoreEnum.StoreId.SummonExchange)
end

function var_0_0.handlePower()
	CurrencyController.instance:openPowerView()
end

function var_0_0.handleFreeDiamond()
	ViewMgr.instance:openView(ViewName.CurrencyDiamondExchangeView)
end

function var_0_0.handlePayDiamond()
	StoreController.instance:checkAndOpenStoreView(StoreEnum.ChargeStoreTabId)
end

function var_0_0.handleDryForest()
	MaterialTipController.instance:showMaterialInfo(2, CurrencyEnum.CurrencyType.DryForest)
end

function var_0_0.handleRoomCritterTrain()
	GameFacade.jump(JumpEnum.JumpId.RoomStoreTabFluff)
end

function var_0_0.clearHandlers()
	var_0_0._handlerMap = nil
end

return var_0_0
