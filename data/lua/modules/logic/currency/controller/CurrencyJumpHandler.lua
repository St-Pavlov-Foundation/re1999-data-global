module("modules.logic.currency.controller.CurrencyJumpHandler", package.seeall)

slot0 = class("CurrencyJumpHandler")

function slot0.JumpByCurrency(slot0)
	if not uv0._handlerMap then
		uv0._handlerMap = {
			[CurrencyEnum.CurrencyType.Power] = uv0.handlePower,
			[CurrencyEnum.CurrencyType.Diamond] = uv0.handlePayDiamond,
			[CurrencyEnum.CurrencyType.FreeDiamondCoupon] = uv0.handleFreeDiamond,
			[CurrencyEnum.CurrencyType.Gold] = uv0.handleGold,
			[CurrencyEnum.CurrencyType.DryForest] = uv0.handleDryForest,
			[CurrencyEnum.CurrencyType.RoomCritterTrain] = uv0.handleRoomCritterTrain
		}
	end

	if uv0._handlerMap[slot0] then
		slot1()
	end
end

function slot0.handleGold()
	StoreController.instance:checkAndOpenStoreView(StoreEnum.SummonExchange)
end

function slot0.handlePower()
	CurrencyController.instance:openPowerView()
end

function slot0.handleFreeDiamond()
	ViewMgr.instance:openView(ViewName.CurrencyDiamondExchangeView)
end

function slot0.handlePayDiamond()
	StoreController.instance:checkAndOpenStoreView(StoreEnum.ChargeStoreTabId)
end

function slot0.handleDryForest()
	MaterialTipController.instance:showMaterialInfo(2, CurrencyEnum.CurrencyType.DryForest)
end

function slot0.handleRoomCritterTrain()
	GameFacade.jump(JumpEnum.JumpId.RoomStoreTabFluff)
end

function slot0.clearHandlers()
	uv0._handlerMap = nil
end

return slot0
