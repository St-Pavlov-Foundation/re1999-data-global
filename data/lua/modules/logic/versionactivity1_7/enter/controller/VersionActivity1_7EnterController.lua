module("modules.logic.versionactivity1_7.enter.controller.VersionActivity1_7EnterController", package.seeall)

local var_0_0 = class("VersionActivity1_7EnterController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.openVersionActivityEnterViewIfNotOpened(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if ViewMgr.instance:isOpen(VersionActivity1_7Enum.ActivityId.EnterView) then
		if arg_3_1 then
			arg_3_1(arg_3_2)
		end

		return
	end

	arg_3_0:openVersionActivityEnterView(arg_3_1, arg_3_2, arg_3_3)
end

function var_0_0.openVersionActivityEnterView(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if not arg_4_0:checkCanOpen(VersionActivity1_7Enum.ActivityId.EnterView) then
		return
	end

	arg_4_0:_openVersionActivityEnterView(arg_4_1, arg_4_2, arg_4_3)
end

function var_0_0._onFinishStory(arg_5_0)
	if not arg_5_0:checkCanOpen(VersionActivity1_7Enum.ActivityId.EnterView) then
		return
	end

	arg_5_0:_openVersionActivityEnterView(arg_5_0.openCallback, arg_5_0.openedCallbackObj, arg_5_0.jumpActId)
end

function var_0_0._openVersionActivityEnterView(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if not VersionActivityBaseController.instance:isPlayedActivityVideo(VersionActivity1_7Enum.ActivityId.EnterView) then
		local var_6_0 = ActivityModel.instance:getActMO(VersionActivity1_7Enum.ActivityId.EnterView)
		local var_6_1 = var_6_0 and var_6_0.config and var_6_0.config.storyId

		if not var_6_1 then
			logError(string.format("act id %s dot config story id", var_6_1))

			var_6_1 = 100010
		end

		local var_6_2 = {}

		var_6_2.isVersionActivityPV = true
		arg_6_0.openCallback = arg_6_1
		arg_6_0.openedCallbackObj = arg_6_2
		arg_6_0.jumpActId = arg_6_3

		StoryController.instance:playStory(var_6_1, var_6_2, arg_6_0._onFinishStory, arg_6_0)

		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_7EnterView, {
		actId = VersionActivity1_7Enum.ActivityId.EnterView,
		activityIdList = VersionActivity1_7Enum.EnterViewActIdList,
		jumpActId = arg_6_3
	})

	if arg_6_1 then
		arg_6_1(arg_6_2)
	end
end

function var_0_0.directOpenVersionActivityEnterView(arg_7_0, arg_7_1)
	if not arg_7_0:checkCanOpen(VersionActivity1_7Enum.ActivityId.EnterView) then
		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_7EnterView, {
		skipOpenAnim = true,
		actId = VersionActivity1_7Enum.ActivityId.EnterView,
		activityIdList = VersionActivity1_7Enum.EnterViewActIdList,
		jumpActId = arg_7_1
	})
end

function var_0_0.checkCanOpen(arg_8_0, arg_8_1)
	local var_8_0, var_8_1, var_8_2 = ActivityHelper.getActivityStatusAndToast(arg_8_1)

	if var_8_0 ~= ActivityEnum.ActivityStatus.Normal then
		if var_8_1 then
			GameFacade.showToast(var_8_1, var_8_2)
		end

		return false
	end

	return true
end

function var_0_0.GetActivityPrefsKey(arg_9_0)
	return VersionActivity1_7Enum.ActivityId.EnterView .. arg_9_0
end

function var_0_0.GetActivityPrefsKeyWithUser(arg_10_0)
	return PlayerModel.instance:getPlayerPrefsKey(var_0_0.GetActivityPrefsKey(arg_10_0))
end

var_0_0.instance = var_0_0.New()

return var_0_0
