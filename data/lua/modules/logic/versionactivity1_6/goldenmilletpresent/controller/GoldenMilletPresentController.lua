module("modules.logic.versionactivity1_6.goldenmilletpresent.controller.GoldenMilletPresentController", package.seeall)

local var_0_0 = class("GoldenMilletPresentController", BaseController)

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
	arg_4_0:getGoldenMilletPresentActivityInfo()
end

function var_0_0.getGoldenMilletPresentActivityInfo(arg_5_0, arg_5_1, arg_5_2)
	if not GoldenMilletPresentModel.instance:isGoldenMilletPresentOpen() then
		return
	end

	local var_5_0 = GoldenMilletPresentModel.instance:getGoldenMilletPresentActId()

	Activity101Rpc.instance:sendGet101InfosRequest(var_5_0, arg_5_1, arg_5_2)
end

function var_0_0.openGoldenMilletPresentView(arg_6_0)
	if not GoldenMilletPresentModel.instance:isGoldenMilletPresentOpen(true) then
		return
	end

	local var_6_0 = GoldenMilletPresentModel.instance:getGoldenMilletPresentActId()

	Activity101Rpc.instance:sendGet101InfosRequest(var_6_0, arg_6_0._realOpenGoldenMilletPresentView, arg_6_0)
end

function var_0_0._realOpenGoldenMilletPresentView(arg_7_0)
	local var_7_0 = GoldenMilletPresentModel.instance:isShowRedDot()

	ViewMgr.instance:openView(ViewName.V2a5_GoldenMilletPresentView, {
		isDisplayView = not var_7_0
	})
end

function var_0_0.receiveGoldenMilletPresent(arg_8_0, arg_8_1, arg_8_2)
	if not GoldenMilletPresentModel.instance:isGoldenMilletPresentOpen(true) then
		return
	end

	local var_8_0 = GoldenMilletPresentModel.instance:getGoldenMilletPresentActId()
	local var_8_1 = GoldenMilletEnum.REWARD_INDEX

	if not ActivityType101Model.instance:isType101RewardCouldGet(var_8_0, var_8_1) then
		GameFacade.showToast(ToastEnum.ActivityRewardHasReceive)

		return
	end

	Activity101Rpc.instance:sendGet101BonusRequest(var_8_0, var_8_1, arg_8_1, arg_8_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
