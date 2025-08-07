module("modules.logic.sp01.versionsummon.view.V2a9_VersionSummon_BaseViewContainer", package.seeall)

local var_0_0 = class("V2a9_VersionSummon_BaseViewContainer", Activity101SignViewBaseContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0.__mainView = arg_1_0:_createMainView()

	return arg_1_0:onBuildViews()
end

function var_0_0.onBuildViews(arg_2_0)
	return {
		arg_2_0.__mainView
	}
end

function var_0_0.onContainerInit(arg_3_0)
	arg_3_0.__onceGotRewardFetch101Infos = false

	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, arg_3_0._onRefreshNorSignActivity, arg_3_0)
end

function var_0_0.getActMO(arg_4_0)
	local var_4_0 = arg_4_0:actId()

	return ActivityModel.instance:getActMO(var_4_0)
end

function var_0_0.getActRemainTimeStr(arg_5_0)
	local var_5_0 = arg_5_0:getActMO()

	if not var_5_0 then
		return ""
	end

	return var_5_0:getRemainTimeStr3(false, true)
end

function var_0_0.sendGet101BonusRequest(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = 1
	local var_6_1 = arg_6_0:actId()

	if not ActivityType101Model.instance:isOpen(var_6_1) then
		GameFacade.showToast(ToastEnum.BattlePass)

		return
	end

	if not ActivityType101Model.instance:isType101RewardCouldGet(var_6_1, var_6_0) then
		GameFacade.showToast(ToastEnum.ActivityRewardHasReceive)

		return
	end

	Activity101Rpc.instance:sendGet101BonusRequest(var_6_1, var_6_0, arg_6_1, arg_6_2)
end

function var_0_0.isType101RewardCouldGetAnyOne(arg_7_0)
	local var_7_0 = false
	local var_7_1 = arg_7_0:actId()

	if ActivityType101Model.instance:isOpen(var_7_1) then
		var_7_0 = ActivityType101Model.instance:isType101RewardCouldGetAnyOne(var_7_1)
	end

	return var_7_0
end

return var_0_0
