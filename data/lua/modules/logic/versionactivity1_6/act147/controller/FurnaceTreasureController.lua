module("modules.logic.versionactivity1_6.act147.controller.FurnaceTreasureController", package.seeall)

slot0 = class("FurnaceTreasureController", BaseController)

function slot0.onInit(slot0)
end

function slot0.addConstEvents(slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0.refreshActivityInfo, slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0.refreshActivityInfo, slot0)
end

function slot0.reInit(slot0)
end

function slot0.refreshActivityInfo(slot0, slot1)
	if not string.nilorempty(slot1) and slot1 ~= 0 and slot1 ~= FurnaceTreasureModel.instance:getActId() then
		return
	end

	if FurnaceTreasureModel.instance:isActivityOpen() then
		FurnaceTreasureRpc.instance:sendGetAct147InfosRequest(slot2)
	elseif slot3 then
		FurnaceTreasureModel.instance:resetData(true)
	end
end

function slot0.BuyFurnaceTreasureGoods(slot0, slot1, slot2, slot3, slot4)
	slot5 = false

	if slot1 and slot2 then
		slot5 = FurnaceTreasureEnum.DEFAULT_BUY_COUNT <= FurnaceTreasureModel.instance:getGoodsRemainCount(slot1, slot2)
	end

	if not slot5 then
		if slot3 then
			slot3(slot4)
		end

		GameFacade.showToast(ToastEnum.CurrencyChanged)

		return
	end

	FurnaceTreasureRpc.instance:sendBuyAct147GoodsRequest(FurnaceTreasureModel.instance:getActId(), slot1, slot2, FurnaceTreasureEnum.DEFAULT_BUY_COUNT, slot3, slot4)
end

slot0.instance = slot0.New()

return slot0
