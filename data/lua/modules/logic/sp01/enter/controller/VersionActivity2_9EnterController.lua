module("modules.logic.sp01.enter.controller.VersionActivity2_9EnterController", package.seeall)

local var_0_0 = class("VersionActivity2_9EnterController", VersionActivityFixedEnterController)

function var_0_0.openVersionActivityEnterView(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0.openEnterViewCb = arg_1_1
	arg_1_0.openEnterViewCbObj = arg_1_2

	local var_1_0 = arg_1_0:getShowMainActId()

	arg_1_0:recordLastEnterMainActId(var_1_0)

	local var_1_1 = {
		actId = var_1_0,
		activityIdListWithGroup = VersionActivity2_9Enum.EnterViewActIdListWithGroup,
		mainActIdList = VersionActivity2_9Enum.EnterViewMainActIdList,
		actId2AmbientDict = VersionActivity2_9Enum.ActId2Ambient,
		actId2OpenAudioDict = VersionActivity2_9Enum.ActId2OpenAudio,
		jumpActId = arg_1_3,
		isExitFight = arg_1_5,
		skipOpenAnim = arg_1_4,
		isDirectOpen = arg_1_4
	}
	local var_1_2

	if not arg_1_4 then
		var_1_2 = arg_1_0._internalOpenEnterView
	end

	local function var_1_3()
		arg_1_0:_internalOpenView(ViewName.VersionActivity2_9EnterView, var_1_0, var_1_2, arg_1_0, var_1_1, arg_1_0.openEnterViewCb, arg_1_0.openEnterViewCbObj)
	end

	if ActivityHelper.isOpen(VersionActivity2_9Enum.ActivityId.Dungeon2) then
		TaskRpc.instance:sendGetTaskInfoRequest({
			TaskEnum.TaskType.Odyssey
		})
		OdysseyRpc.instance:sendOdysseyGetInfoRequest()
	end

	if ActivityHelper.isOpen(VersionActivity2_9Enum.ActivityId.Outside) then
		AssassinOutSideRpc.instance:sendGetAssassinLibraryInfoRequest(VersionActivity2_9Enum.ActivityId.Outside, var_1_3)

		return
	end

	var_1_3()
end

function var_0_0.getShowMainActId(arg_3_0)
	if arg_3_0._lastEnterMainActId then
		return arg_3_0._lastEnterMainActId
	end

	local var_3_0 = VersionActivity2_9Enum.EnterViewMainActIdList[1]

	for iter_3_0, iter_3_1 in ipairs(VersionActivity2_9Enum.EnterViewMainActIdList) do
		if ActivityHelper.getActivityStatus(iter_3_1) == ActivityEnum.ActivityStatus.Normal then
			local var_3_1 = VersionActivity2_9Enum.actId2GuideId[iter_3_1]

			if var_3_1 and not GuideModel.instance:isGuideFinish(var_3_1) then
				break
			end

			var_3_0 = iter_3_1
		end
	end

	return var_3_0
end

function var_0_0.openSeasonStoreView(arg_4_0)
	local var_4_0 = Activity104Model.instance:getCurSeasonId()
	local var_4_1 = SeasonViewHelper.getViewName(var_4_0, Activity104Enum.ViewName.StoreView)
	local var_4_2 = Activity104Enum.SeasonStore[var_4_0]

	arg_4_0:_enterVersionActivityView(var_4_1, var_4_2, arg_4_0._openStoreView, arg_4_0)
end

function var_0_0._openStoreView(arg_5_0, arg_5_1, arg_5_2)
	Activity107Rpc.instance:sendGet107GoodsInfoRequest(arg_5_2, function()
		ViewMgr.instance:openView(arg_5_1, {
			actId = arg_5_2
		})
	end)
end

function var_0_0.openTaskView(arg_7_0)
	arg_7_0:_enterVersionActivityView(ViewName.VersionActivityTaskView, VersionActivity1_5Enum.ActivityId.Act113, arg_7_0._openTaskView, arg_7_0)
end

function var_0_0._openTaskView(arg_8_0)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.ActivityDungeon
	}, function()
		ViewMgr.instance:openView(ViewName.VersionActivityTaskView)
	end)
end

function var_0_0._enterVersionActivityView(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	local var_10_0, var_10_1, var_10_2 = ActivityHelper.getActivityStatusAndToast(arg_10_2)

	if ActivityEnum.ActivityStatus.Normal ~= ActivityEnum.ActivityStatus.Normal then
		if var_10_1 then
			GameFacade.showToast(var_10_1, var_10_2)
		end

		return
	end

	if arg_10_3 then
		arg_10_3(arg_10_4, arg_10_1, arg_10_2)

		return
	end

	ViewMgr.instance:openView(arg_10_1)
end

function var_0_0.recordLastEnterMainActId(arg_11_0, arg_11_1)
	arg_11_0._lastEnterMainActId = arg_11_1
end

function var_0_0.clearLastEnterMainActId(arg_12_0)
	arg_12_0._lastEnterMainActId = nil
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0
