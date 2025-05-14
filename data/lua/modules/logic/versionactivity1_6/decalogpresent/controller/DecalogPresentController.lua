module("modules.logic.versionactivity1_6.decalogpresent.controller.DecalogPresentController", package.seeall)

local var_0_0 = class("DecalogPresentController", BaseController)

function var_0_0.addConstEvents(arg_1_0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, arg_1_0._checkActivityInfo, arg_1_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_1_0._checkActivityInfo, arg_1_0)
end

function var_0_0.reInit(arg_2_0)
	TaskDispatcher.cancelTask(arg_2_0._delayGetInfo, arg_2_0)
end

function var_0_0._checkActivityInfo(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._delayGetInfo, arg_3_0)
	TaskDispatcher.runDelay(arg_3_0._delayGetInfo, arg_3_0, 0.2)
end

function var_0_0._delayGetInfo(arg_4_0)
	arg_4_0:getDecalogActivityInfo()
end

function var_0_0.getDecalogActivityInfo(arg_5_0, arg_5_1, arg_5_2)
	if not DecalogPresentModel.instance:isDecalogPresentOpen() then
		return
	end

	local var_5_0 = DecalogPresentModel.instance:getDecalogPresentActId()

	Activity101Rpc.instance:sendGet101InfosRequest(var_5_0, arg_5_1, arg_5_2)
end

function var_0_0.openDecalogPresentView(arg_6_0, arg_6_1)
	arg_6_0._viewName = arg_6_1

	arg_6_0:getDecalogActivityInfo(arg_6_0._realOpenDecalogPresentView, arg_6_0)
end

function var_0_0._realOpenDecalogPresentView(arg_7_0)
	local var_7_0 = arg_7_0._viewName or ViewName.DecalogPresentView

	ViewMgr.instance:openView(var_7_0)
end

function var_0_0.receiveDecalogPresent(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = DecalogPresentModel.instance:getDecalogPresentActId()

	if not ActivityType101Model.instance:isOpen(var_8_0) then
		GameFacade.showToast(ToastEnum.BattlePass)

		return
	end

	local var_8_1 = DecalogPresentModel.REWARD_INDEX

	if not ActivityType101Model.instance:isType101RewardCouldGet(var_8_0, var_8_1) then
		GameFacade.showToast(ToastEnum.ActivityRewardHasReceive)

		return
	end

	Activity101Rpc.instance:sendGet101BonusRequest(var_8_0, var_8_1, arg_8_1, arg_8_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
