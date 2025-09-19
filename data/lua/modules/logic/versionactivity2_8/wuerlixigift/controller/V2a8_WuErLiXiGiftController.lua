module("modules.logic.versionactivity2_8.wuerlixigift.controller.V2a8_WuErLiXiGiftController", package.seeall)

local var_0_0 = class("V2a8_WuErLiXiGiftController", BaseController)

function var_0_0.addConstEvents(arg_1_0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, arg_1_0._checkActivityInfo, arg_1_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_1_0._checkActivityInfo, arg_1_0)
end

function var_0_0._checkActivityInfo(arg_2_0)
	arg_2_0:getV2a8_WuErLiXiGiftActivityInfo()
end

function var_0_0.getV2a8_WuErLiXiGiftActivityInfo(arg_3_0, arg_3_1, arg_3_2)
	if not V2a8_WuErLiXiGiftModel.instance:isV2a8_WuErLiXiGiftOpen() then
		return
	end

	local var_3_0 = V2a8_WuErLiXiGiftModel.instance:getV2a8_WuErLiXiGiftActId()

	Activity101Rpc.instance:sendGet101InfosRequest(var_3_0, arg_3_1, arg_3_2)
end

function var_0_0.openV2a8_WuErLiXiGiftView(arg_4_0)
	arg_4_0:getV2a8_WuErLiXiGiftActivityInfo(arg_4_0._realOpenV2a8_WuErLiXiGiftView, arg_4_0)
end

function var_0_0._realOpenV2a8_WuErLiXiGiftView(arg_5_0)
	ViewMgr.instance:openView(ViewName.V2a8_WuErLiXiGiftView)
end

function var_0_0.receiveV2a8_WuErLiXiGift(arg_6_0, arg_6_1, arg_6_2)
	if not V2a8_WuErLiXiGiftModel.instance:isV2a8_WuErLiXiGiftOpen() then
		GameFacade.showToast(ToastEnum.BattlePass)

		return
	end

	local var_6_0 = V2a8_WuErLiXiGiftModel.instance:getV2a8_WuErLiXiGiftActId()
	local var_6_1 = V2a8_WuErLiXiGiftModel.REWARD_INDEX

	if ActivityType101Model.instance:isType101RewardCouldGet(var_6_0, var_6_1) then
		Activity101Rpc.instance:sendGet101BonusRequest(var_6_0, var_6_1, arg_6_1, arg_6_2)
	else
		GameFacade.showToast(ToastEnum.ActivityRewardHasReceive)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
