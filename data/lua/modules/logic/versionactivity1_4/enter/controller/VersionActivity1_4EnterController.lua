module("modules.logic.versionactivity1_4.enter.controller.VersionActivity1_4EnterController", package.seeall)

local var_0_0 = class("VersionActivity1_4EnterController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0.actId = VersionActivity1_4Enum.ActivityId.EnterView
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.openVersionActivityEnterViewIfNotOpened(arg_3_0, arg_3_1, arg_3_2)
	if ViewMgr.instance:isOpen(ViewName.VersionActivity1_4EnterView) then
		if arg_3_1 then
			arg_3_1(arg_3_2)
		end

		return
	end

	arg_3_0:openVersionActivityEnterView(arg_3_1, arg_3_2)
end

function var_0_0.openVersionActivityEnterView(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.openedCallback = arg_4_1
	arg_4_0.openedCallbackObj = arg_4_2

	VersionActivityBaseController.instance:enterVersionActivityView(ViewName.VersionActivity1_4EnterView, arg_4_0.actId, arg_4_0._openVersionActivityEnterView, arg_4_0)
end

function var_0_0._onFinishStory(arg_5_0)
	if ActivityHelper.getActivityStatus(arg_5_0.actId) ~= ActivityEnum.ActivityStatus.Normal then
		return
	end

	arg_5_0:_openVersionActivityEnterView()
end

function var_0_0._openVersionActivityEnterView(arg_6_0)
	local var_6_0 = ActivityConfig.instance:getActivityCo(arg_6_0.actId)
	local var_6_1 = var_6_0 and var_6_0.storyId

	if var_6_1 and var_6_1 > 0 and not StoryModel.instance:isStoryFinished(var_6_0.storyId) then
		StoryController.instance:playStory(var_6_1, {
			isVersionActivityPV = true
		}, arg_6_0._onFinishStory, arg_6_0)

		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_4EnterView, {
		actId = arg_6_0.actId,
		activityIdList = VersionActivity1_4Enum.EnterViewActIdList
	})

	if arg_6_0.openedCallback then
		arg_6_0.openedCallback(arg_6_0.openedCallbackObj)

		arg_6_0.openedCallback = nil
		arg_6_0.openedCallbackObj = nil
	end
end

function var_0_0.directOpenVersionActivityEnterView(arg_7_0)
	VersionActivityBaseController.instance:enterVersionActivityView(ViewName.VersionActivity1_4EnterView, arg_7_0.actId, function()
		ViewMgr.instance:openView(ViewName.VersionActivity1_4EnterView, {
			skipOpenAnim = true,
			actId = arg_7_0.actId,
			activityIdList = VersionActivity1_4Enum.EnterViewActIdList
		})
	end, arg_7_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
