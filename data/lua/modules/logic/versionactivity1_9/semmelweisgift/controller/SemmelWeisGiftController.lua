module("modules.logic.versionactivity1_9.semmelweisgift.controller.SemmelWeisGiftController", package.seeall)

local var_0_0 = class("SemmelWeisGiftController", BaseController)

function var_0_0.addConstEvents(arg_1_0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, arg_1_0._checkActivityInfo, arg_1_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_1_0._checkActivityInfo, arg_1_0)
end

function var_0_0._checkActivityInfo(arg_2_0)
	arg_2_0:getSemmelWeisGiftActivityInfo()
end

function var_0_0.getSemmelWeisGiftActivityInfo(arg_3_0, arg_3_1, arg_3_2)
	if not SemmelWeisGiftModel.instance:isSemmelWeisGiftOpen() then
		return
	end

	local var_3_0 = SemmelWeisGiftModel.instance:getSemmelWeisGiftActId()

	Activity101Rpc.instance:sendGet101InfosRequest(var_3_0, arg_3_1, arg_3_2)
end

function var_0_0.openSemmelWeisGiftView(arg_4_0)
	arg_4_0:getSemmelWeisGiftActivityInfo(arg_4_0._realOpenSemmelWeisGiftView, arg_4_0)
end

function var_0_0._realOpenSemmelWeisGiftView(arg_5_0)
	ViewMgr.instance:openView(ViewName.SemmelWeisGiftView)
end

function var_0_0.receiveSemmelWeisGift(arg_6_0, arg_6_1, arg_6_2)
	if not SemmelWeisGiftModel.instance:isSemmelWeisGiftOpen() then
		GameFacade.showToast(ToastEnum.BattlePass)

		return
	end

	local var_6_0 = SemmelWeisGiftModel.instance:getSemmelWeisGiftActId()
	local var_6_1 = SemmelWeisGiftModel.REWARD_INDEX

	if ActivityType101Model.instance:isType101RewardCouldGet(var_6_0, var_6_1) then
		Activity101Rpc.instance:sendGet101BonusRequest(var_6_0, var_6_1, arg_6_1, arg_6_2)
	else
		GameFacade.showToast(ToastEnum.ActivityRewardHasReceive)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
