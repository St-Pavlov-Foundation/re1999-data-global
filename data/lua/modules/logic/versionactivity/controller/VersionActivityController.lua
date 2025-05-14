module("modules.logic.versionactivity.controller.VersionActivityController", package.seeall)

local var_0_0 = class("VersionActivityController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.openVersionActivityEnterViewIfNotOpened(arg_3_0, arg_3_1, arg_3_2)
	if ViewMgr.instance:isOpen(ViewName.VersionActivityEnterView) then
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

	arg_4_0:_enterVersionActivityView(ViewName.VersionActivityEnterView, VersionActivityEnum.ActivityId.Act105, arg_4_0._openVersionActivityEnterView, arg_4_0)
end

function var_0_0._onFinishStory(arg_5_0)
	if ActivityHelper.getActivityStatus(VersionActivityEnum.ActivityId.Act105) ~= ActivityEnum.ActivityStatus.Normal then
		return
	end

	for iter_5_0, iter_5_1 in ipairs(VersionActivityEnum.EnterViewActIdList) do
		if ActivityHelper.getActivityStatus(iter_5_1) == ActivityEnum.ActivityStatus.Normal then
			ActivityEnterMgr.instance:enterActivity(iter_5_1)
		end
	end

	ActivityRpc.instance:sendActivityNewStageReadRequest(VersionActivityEnum.EnterViewActIdList, function()
		arg_5_0:_openVersionActivityEnterView()
	end, arg_5_0)
end

function var_0_0._openVersionActivityEnterView(arg_7_0)
	if not VersionActivityBaseController.instance:isPlayedActivityVideo(VersionActivityEnum.ActivityId.Act105) then
		local var_7_0 = ActivityModel.instance:getActMO(VersionActivityEnum.ActivityId.Act105)
		local var_7_1 = var_7_0 and var_7_0.config and var_7_0.config.storyId

		if not var_7_1 then
			logError(string.format("act id %s dot config story id", var_7_1))

			var_7_1 = 100010
		end

		local var_7_2 = {}

		var_7_2.isVersionActivityPV = true

		StoryController.instance:playStory(var_7_1, var_7_2, arg_7_0._onFinishStory, arg_7_0)

		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivityEnterView, {
		actId = VersionActivityEnum.ActivityId.Act105,
		activityIdList = VersionActivityEnum.EnterViewActIdList
	})

	if arg_7_0.openedCallback then
		arg_7_0.openedCallback(arg_7_0.openedCallbackObj)

		arg_7_0.openedCallback = nil
		arg_7_0.openedCallbackObj = nil
	end
end

function var_0_0.directOpenVersionActivityEnterView(arg_8_0)
	arg_8_0:_enterVersionActivityView(ViewName.VersionActivityEnterView, VersionActivityEnum.ActivityId.Act105, function()
		ViewMgr.instance:openView(ViewName.VersionActivityEnterView, {
			skipOpenAnim = true,
			actId = VersionActivityEnum.ActivityId.Act105,
			activityIdList = VersionActivityEnum.EnterViewActIdList
		})
	end, arg_8_0)
end

function var_0_0.openLeiMiTeBeiStoreView(arg_10_0, arg_10_1)
	if ReactivityModel.instance:isReactivity(arg_10_1) then
		ReactivityController.instance:openReactivityStoreView(arg_10_1)

		return
	end

	arg_10_0:_enterVersionActivityView(ViewName.VersionActivityStoreView, VersionActivityEnum.ActivityId.Act107, arg_10_0._openStoreView, arg_10_0)
end

function var_0_0._openStoreView(arg_11_0, arg_11_1, arg_11_2)
	Activity107Rpc.instance:sendGet107GoodsInfoRequest(arg_11_2, function()
		ViewMgr.instance:openView(arg_11_1, {
			actId = arg_11_2
		})
	end)
end

function var_0_0.openSeasonStoreView(arg_13_0)
	local var_13_0 = Activity104Model.instance:getCurSeasonId()
	local var_13_1 = SeasonViewHelper.getViewName(var_13_0, Activity104Enum.ViewName.StoreView)
	local var_13_2 = Activity104Enum.SeasonStore[var_13_0]

	arg_13_0:_enterVersionActivityView(var_13_1, var_13_2, arg_13_0._openStoreView, arg_13_0)
end

function var_0_0.openLeiMiTeBeiTaskView(arg_14_0)
	local var_14_0 = VersionActivityEnum.ActivityId.Act113

	if ReactivityModel.instance:isReactivity(var_14_0) then
		ReactivityController.instance:openReactivityTaskView(var_14_0)

		return
	end

	arg_14_0:_enterVersionActivityView(ViewName.VersionActivityTaskView, var_14_0, arg_14_0._openLeiMiTeBeiTaskView, arg_14_0)
end

function var_0_0._openLeiMiTeBeiTaskView(arg_15_0)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.ActivityDungeon
	}, function()
		ViewMgr.instance:openView(ViewName.VersionActivityTaskView)
	end)
end

function var_0_0._enterVersionActivityView(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	local var_17_0, var_17_1, var_17_2 = ActivityHelper.getActivityStatusAndToast(arg_17_2)

	if var_17_0 ~= ActivityEnum.ActivityStatus.Normal then
		if var_17_1 then
			GameFacade.showToastWithTableParam(var_17_1, var_17_2)
		end

		return
	end

	if arg_17_3 then
		arg_17_3(arg_17_4, arg_17_1, arg_17_2)

		return
	end

	ViewMgr.instance:openView(arg_17_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
