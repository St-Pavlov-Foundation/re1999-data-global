module("modules.logic.versionactivity1_2.enter.controller.VersionActivity1_2EnterController", package.seeall)

local var_0_0 = class("VersionActivity1_2EnterController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0._onFinishStory(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(VersionActivity1_2Enum.EnterViewActIdList) do
		if ActivityHelper.getActivityStatus(iter_3_1) == ActivityEnum.ActivityStatus.Normal then
			ActivityEnterMgr.instance:enterActivity(iter_3_1)
		end
	end

	ActivityRpc.instance:sendActivityNewStageReadRequest(VersionActivity1_2Enum.EnterViewActIdList, function()
		arg_3_0:_openVersionActivity1_2EnterView(arg_3_1 and arg_3_1.skipOpenAnim)
	end, arg_3_0)
end

function var_0_0._openVersionActivity1_2EnterView(arg_5_0, arg_5_1)
	local var_5_0 = VersionActivity1_2Enum.ActivityId.EnterView
	local var_5_1, var_5_2, var_5_3 = ActivityHelper.getActivityStatusAndToast(var_5_0)

	if var_5_1 ~= ActivityEnum.ActivityStatus.Normal then
		if var_5_2 then
			GameFacade.showToastWithTableParam(var_5_2, var_5_3)
		end

		return
	end

	if not VersionActivityBaseController.instance:isPlayedActivityVideo(var_5_0) then
		local var_5_4 = ActivityModel.instance:getActMO(var_5_0)
		local var_5_5 = var_5_4 and var_5_4.config and var_5_4.config.storyId

		if var_5_5 and var_5_5 ~= 0 then
			StoryController.instance:playStory(var_5_5, nil, arg_5_0._onFinishStory, arg_5_0, {
				skipOpenAnim = arg_5_1
			})
		else
			logWarn(string.format("act id %s dot config story id", var_5_5))
			arg_5_0:_onFinishStory({
				skipOpenAnim = arg_5_1
			})
		end

		return
	end

	local var_5_6 = {
		actId = var_5_0,
		skipOpenAnim = arg_5_1,
		activityIdList = VersionActivity1_2Enum.EnterViewActIdList
	}

	ViewMgr.instance:openView(ViewName.VersionActivity1_2EnterView, var_5_6)

	if arg_5_0.openedCallback then
		arg_5_0.openedCallback(arg_5_0.openedCallbackObj, arg_5_0.openedCallbackParam)

		arg_5_0.openedCallback = nil
		arg_5_0.openedCallbackObj = nil
		arg_5_0.openedCallbackParam = nil
	end
end

function var_0_0.openVersionActivity1_2EnterView(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.openedCallback = arg_6_1
	arg_6_0.openedCallbackObj = arg_6_2
	arg_6_0.openedCallbackParam = arg_6_3

	arg_6_0:_openVersionActivity1_2EnterView()
end

function var_0_0.directOpenVersionActivity1_2EnterView(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.openedCallback = arg_7_1
	arg_7_0.openedCallbackObj = arg_7_2
	arg_7_0.openedCallbackParam = arg_7_3

	arg_7_0:_openVersionActivity1_2EnterView(true)
end

function var_0_0.openActivityStoreView(arg_8_0)
	local var_8_0, var_8_1, var_8_2 = ActivityHelper.getActivityStatusAndToast(VersionActivity1_2Enum.ActivityId.DungeonStore)

	if var_8_0 ~= ActivityEnum.ActivityStatus.Normal then
		if var_8_1 then
			GameFacade.showToastWithTableParam(var_8_1, var_8_2)
		end

		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_2StoreView)
end

var_0_0.instance = var_0_0.New()

return var_0_0
