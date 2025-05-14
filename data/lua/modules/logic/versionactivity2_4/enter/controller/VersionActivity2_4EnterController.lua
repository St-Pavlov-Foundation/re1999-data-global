module("modules.logic.versionactivity2_4.enter.controller.VersionActivity2_4EnterController", package.seeall)

local var_0_0 = class("VersionActivity2_4EnterController", BaseController)

function var_0_0._internalOpenView(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	if not VersionActivityEnterHelper.checkCanOpen(arg_1_2) then
		return
	end

	if arg_1_3 then
		arg_1_3(arg_1_4, arg_1_1, arg_1_2, arg_1_5)
	else
		ViewMgr.instance:openView(arg_1_1, arg_1_5)

		if arg_1_6 then
			arg_1_6(arg_1_7)
		end
	end
end

function var_0_0._internalOpenEnterView(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if VersionActivityBaseController.instance:isPlayedActivityVideo(arg_2_2) then
		ViewMgr.instance:openView(arg_2_1, arg_2_3)

		if arg_2_0.openEnterViewCb then
			arg_2_0.openEnterViewCb(arg_2_0.openEnterViewCbObj)

			arg_2_0.openEnterViewCb = nil
			arg_2_0.openEnterViewCbObj = nil
		end
	else
		local var_2_0 = ActivityModel.instance:getActMO(arg_2_2)
		local var_2_1 = var_2_0 and var_2_0.config and var_2_0.config.storyId

		if not var_2_1 then
			var_2_1 = 100010

			logError(string.format("act id %s dot config story id", var_2_1))
		end

		local var_2_2 = {
			isVersionActivityPV = true
		}
		local var_2_3 = {
			actId = arg_2_2,
			viewName = arg_2_1,
			viewParams = arg_2_3
		}

		StoryController.instance:playStory(var_2_1, var_2_2, arg_2_0._onFinishEnterStory, arg_2_0, var_2_3)
	end
end

function var_0_0._onFinishEnterStory(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1.actId

	if not VersionActivityEnterHelper.checkCanOpen(var_3_0) then
		return
	end

	arg_3_0:_internalOpenEnterView(arg_3_1.viewName, var_3_0, arg_3_1.viewParams)
end

function var_0_0.openVersionActivityEnterViewIfNotOpened(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	if ViewMgr.instance:isOpen(ViewName.VersionActivity2_4EnterView) then
		if arg_4_1 then
			arg_4_1(arg_4_2)
		end
	else
		arg_4_0:openVersionActivityEnterView(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	end
end

function var_0_0.directOpenVersionActivityEnterView(arg_5_0, arg_5_1)
	arg_5_0:openVersionActivityEnterView(nil, nil, arg_5_1, true)
end

function var_0_0.openVersionActivityEnterView(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	arg_6_0.openEnterViewCb = arg_6_1
	arg_6_0.openEnterViewCbObj = arg_6_2

	local var_6_0 = VersionActivity2_4Enum.ActivityId.EnterView
	local var_6_1 = VersionActivityEnterHelper.getActIdList(VersionActivity2_4Enum.EnterViewActSetting)
	local var_6_2 = {
		actId = var_6_0,
		jumpActId = arg_6_3,
		activityIdList = var_6_1,
		activitySettingList = VersionActivity2_4Enum.EnterViewActSetting
	}
	local var_6_3

	if arg_6_4 then
		var_6_2.isDirectOpen = true
	else
		var_6_3 = arg_6_0._internalOpenEnterView
	end

	local var_6_4 = ViewName.VersionActivity2_4EnterView

	arg_6_0:_internalOpenView(var_6_4, var_6_0, var_6_3, arg_6_0, var_6_2, arg_6_0.openEnterViewCb, arg_6_0.openEnterViewCbObj)
end

var_0_0.instance = var_0_0.New()

return var_0_0
