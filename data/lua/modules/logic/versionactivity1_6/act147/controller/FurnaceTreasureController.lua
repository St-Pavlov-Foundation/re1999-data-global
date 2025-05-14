module("modules.logic.versionactivity1_6.act147.controller.FurnaceTreasureController", package.seeall)

local var_0_0 = class("FurnaceTreasureController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.addConstEvents(arg_2_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_2_0.refreshActivityInfo, arg_2_0)
	arg_2_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_2_0.refreshActivityInfo, arg_2_0)
end

function var_0_0.reInit(arg_3_0)
	return
end

function var_0_0.refreshActivityInfo(arg_4_0, arg_4_1)
	local var_4_0 = FurnaceTreasureModel.instance:getActId()
	local var_4_1 = not string.nilorempty(arg_4_1) and arg_4_1 ~= 0

	if var_4_1 and arg_4_1 ~= var_4_0 then
		return
	end

	if FurnaceTreasureModel.instance:isActivityOpen() then
		FurnaceTreasureRpc.instance:sendGetAct147InfosRequest(var_4_0)
	elseif var_4_1 then
		FurnaceTreasureModel.instance:resetData(true)
	end
end

function var_0_0.BuyFurnaceTreasureGoods(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = false

	if arg_5_1 and arg_5_2 then
		var_5_0 = FurnaceTreasureModel.instance:getGoodsRemainCount(arg_5_1, arg_5_2) >= FurnaceTreasureEnum.DEFAULT_BUY_COUNT
	end

	if not var_5_0 then
		if arg_5_3 then
			arg_5_3(arg_5_4)
		end

		GameFacade.showToast(ToastEnum.CurrencyChanged)

		return
	end

	local var_5_1 = FurnaceTreasureModel.instance:getActId()

	FurnaceTreasureRpc.instance:sendBuyAct147GoodsRequest(var_5_1, arg_5_1, arg_5_2, FurnaceTreasureEnum.DEFAULT_BUY_COUNT, arg_5_3, arg_5_4)
end

var_0_0.instance = var_0_0.New()

return var_0_0
