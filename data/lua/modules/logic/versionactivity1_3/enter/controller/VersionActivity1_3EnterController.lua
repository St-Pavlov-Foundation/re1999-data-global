module("modules.logic.versionactivity1_3.enter.controller.VersionActivity1_3EnterController", package.seeall)

local var_0_0 = class("VersionActivity1_3EnterController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.openVersionActivityEnterViewIfNotOpened(arg_3_0, arg_3_1, arg_3_2)
	if ViewMgr.instance:isOpen(ViewName.VersionActivity1_3EnterView) then
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

	arg_4_0:_enterVersionActivityView(ViewName.VersionActivity1_3EnterView, VersionActivity1_3Enum.ActivityId.EnterView, arg_4_0._openVersionActivityEnterView, arg_4_0)
end

function var_0_0._onFinishStory(arg_5_0)
	if ActivityHelper.getActivityStatus(VersionActivity1_3Enum.ActivityId.EnterView) ~= ActivityEnum.ActivityStatus.Normal then
		return
	end

	arg_5_0:_openVersionActivityEnterView()
end

function var_0_0._openVersionActivityEnterView(arg_6_0)
	if not VersionActivityBaseController.instance:isPlayedActivityVideo(VersionActivity1_3Enum.ActivityId.EnterView) then
		local var_6_0 = ActivityModel.instance:getActMO(VersionActivity1_3Enum.ActivityId.EnterView)
		local var_6_1 = var_6_0 and var_6_0.config and var_6_0.config.storyId

		if not var_6_1 then
			logError(string.format("act id %s dot config story id", var_6_1))

			var_6_1 = 100010
		end

		local var_6_2 = {}

		var_6_2.isVersionActivityPV = true

		StoryController.instance:playStory(var_6_1, var_6_2, arg_6_0._onFinishStory, arg_6_0)

		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_3EnterView, {
		actId = VersionActivity1_3Enum.ActivityId.EnterView,
		activityIdList = VersionActivity1_3Enum.EnterViewActIdList
	})

	if arg_6_0.openedCallback then
		arg_6_0.openedCallback(arg_6_0.openedCallbackObj)

		arg_6_0.openedCallback = nil
		arg_6_0.openedCallbackObj = nil
	end
end

function var_0_0.directOpenVersionActivityEnterView(arg_7_0)
	arg_7_0:_enterVersionActivityView(ViewName.VersionActivity1_3EnterView, VersionActivity1_3Enum.ActivityId.EnterView, function()
		ViewMgr.instance:openView(ViewName.VersionActivity1_3EnterView, {
			skipOpenAnim = true,
			actId = VersionActivity1_3Enum.ActivityId.EnterView,
			activityIdList = VersionActivity1_3Enum.EnterViewActIdList
		})
	end, arg_7_0)
end

function var_0_0.openStoreView(arg_9_0)
	arg_9_0:_enterVersionActivityView(ViewName.VersionActivity1_3StoreView, VersionActivity1_3Enum.ActivityId.DungeonStore, arg_9_0._openStoreView, arg_9_0)
end

function var_0_0._openStoreView(arg_10_0, arg_10_1, arg_10_2)
	Activity107Rpc.instance:sendGet107GoodsInfoRequest(arg_10_2, function()
		ViewMgr.instance:openView(arg_10_1, {
			actId = arg_10_2
		})
	end)
end

function var_0_0.openSeasonStoreView(arg_12_0)
	local var_12_0 = Activity104Model.instance:getCurSeasonId()
	local var_12_1 = SeasonViewHelper.getViewName(var_12_0, Activity104Enum.ViewName.StoreView)
	local var_12_2 = Activity104Enum.SeasonStore[var_12_0]

	arg_12_0:_enterVersionActivityView(var_12_1, var_12_2, arg_12_0._openStoreView, arg_12_0)
end

function var_0_0.openTaskView(arg_13_0)
	arg_13_0:_enterVersionActivityView(ViewName.VersionActivityTaskView, VersionActivity1_3Enum.ActivityId.Act113, arg_13_0._openTaskView, arg_13_0)
end

function var_0_0._openTaskView(arg_14_0)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.ActivityDungeon
	}, function()
		ViewMgr.instance:openView(ViewName.VersionActivityTaskView)
	end)
end

function var_0_0._enterVersionActivityView(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	local var_16_0, var_16_1, var_16_2 = ActivityHelper.getActivityStatusAndToast(arg_16_2)

	if var_16_0 ~= ActivityEnum.ActivityStatus.Normal then
		if var_16_1 then
			GameFacade.showToast(var_16_1, var_16_2)
		end

		return
	end

	if arg_16_3 then
		arg_16_3(arg_16_4, arg_16_1, arg_16_2)

		return
	end

	ViewMgr.instance:openView(arg_16_1)
end

function var_0_0.GetActivityPrefsKey(arg_17_0)
	return VersionActivity1_3Enum.ActivityId.EnterView .. arg_17_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
