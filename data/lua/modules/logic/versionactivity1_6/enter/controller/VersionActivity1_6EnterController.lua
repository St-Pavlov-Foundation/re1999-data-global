module("modules.logic.versionactivity1_6.enter.controller.VersionActivity1_6EnterController", package.seeall)

local var_0_0 = class("VersionActivity1_6EnterController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0.selectActId = nil
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.selectActId = nil
end

function var_0_0.setSelectActId(arg_3_0, arg_3_1)
	arg_3_0.selectActId = arg_3_1
end

function var_0_0.getSelectActId(arg_4_0)
	return arg_4_0.selectActId
end

function var_0_0.openVersionActivityEnterViewIfNotOpened(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	if ViewMgr.instance:isOpen(ViewName.VersionActivity2_5EnterView) then
		if arg_5_1 then
			arg_5_1(arg_5_2)
		end

		return
	end

	arg_5_0:openVersionActivityEnterView(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
end

function var_0_0.openVersionActivityEnterView(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	arg_6_0.openedCallback = arg_6_1
	arg_6_0.openedCallbackObj = arg_6_2
	arg_6_0.actId = arg_6_3

	local var_6_0 = {
		jumpActId = arg_6_3,
		enterVideo = arg_6_4
	}

	arg_6_0:_enterVersionActivityView(ViewName.VersionActivity1_6EnterView, VersionActivity1_6Enum.ActivityId.EnterView, arg_6_0._openVersionActivityEnterView, arg_6_0, var_6_0)
end

function var_0_0._onFinishStory(arg_7_0, arg_7_1)
	if ActivityHelper.getActivityStatus(VersionActivity1_6Enum.ActivityId.EnterView) ~= ActivityEnum.ActivityStatus.Normal then
		return
	end

	arg_7_0:_openVersionActivityEnterView(nil, nil, arg_7_1)
end

function var_0_0._openVersionActivityEnterView(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if not VersionActivityBaseController.instance:isPlayedActivityVideo(VersionActivity1_6Enum.ActivityId.EnterView) then
		local var_8_0 = ActivityModel.instance:getActMO(VersionActivity1_6Enum.ActivityId.EnterView)
		local var_8_1 = var_8_0 and var_8_0.config and var_8_0.config.storyId

		if not var_8_1 then
			logError(string.format("act id %s dot config story id", var_8_1))

			var_8_1 = 100010
		end

		local var_8_2 = {}

		var_8_2.isVersionActivityPV = true

		StoryController.instance:playStory(var_8_1, var_8_2, arg_8_0._onFinishStory, arg_8_0)

		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_6EnterView, {
		actId = VersionActivity1_6Enum.ActivityId.EnterView,
		activityIdListWithGroup = VersionActivity1_6Enum.EnterViewActIdListWithGroup,
		mainActIdList = VersionActivity1_6Enum.EnterViewMainActIdList,
		actId2AmbientDict = VersionActivity1_6Enum.ActId2Ambient,
		actId2OpenAudioDict = VersionActivity1_6Enum.ActId2OpenAudio
	})

	if arg_8_0.openedCallback then
		arg_8_0.openedCallback(arg_8_0.openedCallbackObj)

		arg_8_0.openedCallback = nil
		arg_8_0.openedCallbackObj = nil
	end
end

function var_0_0.directOpenVersionActivityEnterView(arg_9_0)
	arg_9_0:_enterVersionActivityView(ViewName.VersionActivity1_6EnterView, VersionActivity1_6Enum.ActivityId.EnterView, function()
		ViewMgr.instance:openView(ViewName.VersionActivity1_6EnterView, {
			skipOpenAnim = true,
			actId = VersionActivity1_6Enum.ActivityId.EnterView,
			activityIdList = VersionActivity1_6Enum.EnterViewActIdList
		})
	end, arg_9_0)
end

function var_0_0.openStoreView(arg_11_0)
	arg_11_0:_enterVersionActivityView(ViewName.VersionActivity1_6StoreView, VersionActivity1_6Enum.ActivityId.DungeonStore, arg_11_0._openStoreView, arg_11_0)
end

function var_0_0._openStoreView(arg_12_0, arg_12_1, arg_12_2)
	Activity107Rpc.instance:sendGet107GoodsInfoRequest(arg_12_2, function()
		ViewMgr.instance:openView(arg_12_1, {
			actId = arg_12_2
		})
	end)
end

function var_0_0.openSeasonStoreView(arg_14_0)
	local var_14_0 = Activity104Model.instance:getCurSeasonId()
	local var_14_1 = SeasonViewHelper.getViewName(var_14_0, Activity104Enum.ViewName.StoreView)
	local var_14_2 = Activity104Enum.SeasonStore[var_14_0]

	arg_14_0:_enterVersionActivityView(var_14_1, var_14_2, arg_14_0._openStoreView, arg_14_0)
end

function var_0_0.openTaskView(arg_15_0)
	arg_15_0:_enterVersionActivityView(ViewName.VersionActivityTaskView, VersionActivity1_6Enum.ActivityId.Act113, arg_15_0._openTaskView, arg_15_0)
end

function var_0_0._openTaskView(arg_16_0)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.ActivityDungeon
	}, function()
		ViewMgr.instance:openView(ViewName.VersionActivityTaskView)
	end)
end

function var_0_0.openCachotEnterView(arg_18_0)
	arg_18_0:_enterVersionActivityView(ViewName.V1a6_CachotEnterView, VersionActivity1_6Enum.ActivityId.Cachot, arg_18_0._openCachotEnterView, arg_18_0)
end

function var_0_0._openCachotEnterView(arg_19_0)
	ViewMgr.instance:openView(ViewName.V1a6_CachotEnterView)
end

function var_0_0._enterVersionActivityView(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5)
	local var_20_0, var_20_1, var_20_2 = ActivityHelper.getActivityStatusAndToast(arg_20_2)

	if var_20_0 ~= ActivityEnum.ActivityStatus.Normal then
		if var_20_1 then
			GameFacade.showToast(var_20_1, var_20_2)
		end

		return
	end

	if arg_20_3 then
		arg_20_3(arg_20_4, arg_20_1, arg_20_2, arg_20_5)

		return
	end

	ViewMgr.instance:openView(arg_20_1, arg_20_5)
end

function var_0_0.GetActivityPrefsKey(arg_21_0)
	return VersionActivity1_6Enum.ActivityId.EnterView .. arg_21_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
