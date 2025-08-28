module("modules.logic.sp01.enter.controller.VersionActivity2_9EnterController", package.seeall)

local var_0_0 = class("VersionActivity2_9EnterController", VersionActivityFixedEnterController)

function var_0_0.onInitFinish(arg_1_0)
	var_0_0.super.onInitFinish(arg_1_0)

	arg_1_0._lastEnterMainActId = nil
end

function var_0_0.openVersionActivityEnterView(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	arg_2_0.openEnterViewCb = arg_2_1
	arg_2_0.openEnterViewCbObj = arg_2_2

	local var_2_0 = arg_2_0:getShowMainActId()

	arg_2_0:recordLastEnterMainActId(var_2_0)

	local var_2_1 = {
		actId = var_2_0,
		activityIdListWithGroup = VersionActivity2_9Enum.EnterViewActIdListWithGroup,
		mainActIdList = VersionActivity2_9Enum.EnterViewMainActIdList,
		actId2AmbientDict = VersionActivity2_9Enum.ActId2Ambient,
		actId2OpenAudioDict = VersionActivity2_9Enum.ActId2OpenAudio,
		jumpActId = arg_2_3,
		isExitFight = arg_2_5,
		skipOpenAnim = arg_2_4,
		isDirectOpen = arg_2_4
	}
	local var_2_2

	if not arg_2_4 then
		var_2_2 = arg_2_0._internalOpenEnterView
	end

	local function var_2_3()
		arg_2_0:_internalOpenView(ViewName.VersionActivity2_9EnterView, var_2_0, var_2_2, arg_2_0, var_2_1, arg_2_0.openEnterViewCb, arg_2_0.openEnterViewCbObj)
	end

	if ActivityHelper.isOpen(VersionActivity2_9Enum.ActivityId.Dungeon2) then
		TaskRpc.instance:sendGetTaskInfoRequest({
			TaskEnum.TaskType.Odyssey
		})
		OdysseyRpc.instance:sendOdysseyGetInfoRequest()
	end

	if ActivityHelper.isOpen(VersionActivity2_9Enum.ActivityId.Outside) then
		AssassinOutSideRpc.instance:sendGetAssassinLibraryInfoRequest(VersionActivity2_9Enum.ActivityId.Outside, var_2_3)

		return
	end

	var_2_3()
end

function var_0_0.getShowMainActId(arg_4_0)
	if arg_4_0._lastEnterMainActId then
		return arg_4_0._lastEnterMainActId
	end

	local var_4_0 = VersionActivity2_9Enum.EnterViewMainActIdList[1]

	for iter_4_0, iter_4_1 in ipairs(VersionActivity2_9Enum.EnterViewMainActIdList) do
		if ActivityHelper.getActivityStatus(iter_4_1) == ActivityEnum.ActivityStatus.Normal then
			local var_4_1 = VersionActivity2_9Enum.actId2GuideId[iter_4_1]

			if var_4_1 and not GuideModel.instance:isGuideFinish(var_4_1) then
				break
			end

			var_4_0 = iter_4_1
		end
	end

	return var_4_0
end

function var_0_0.openSeasonStoreView(arg_5_0)
	local var_5_0 = Activity104Model.instance:getCurSeasonId()
	local var_5_1 = SeasonViewHelper.getViewName(var_5_0, Activity104Enum.ViewName.StoreView)
	local var_5_2 = Activity104Enum.SeasonStore[var_5_0]

	arg_5_0:_enterVersionActivityView(var_5_1, var_5_2, arg_5_0._openStoreView, arg_5_0)
end

function var_0_0._openStoreView(arg_6_0, arg_6_1, arg_6_2)
	Activity107Rpc.instance:sendGet107GoodsInfoRequest(arg_6_2, function()
		ViewMgr.instance:openView(arg_6_1, {
			actId = arg_6_2
		})
	end)
end

function var_0_0.openTaskView(arg_8_0)
	arg_8_0:_enterVersionActivityView(ViewName.VersionActivityTaskView, VersionActivity1_5Enum.ActivityId.Act113, arg_8_0._openTaskView, arg_8_0)
end

function var_0_0._openTaskView(arg_9_0)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.ActivityDungeon
	}, function()
		ViewMgr.instance:openView(ViewName.VersionActivityTaskView)
	end)
end

function var_0_0._enterVersionActivityView(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	local var_11_0, var_11_1, var_11_2 = ActivityHelper.getActivityStatusAndToast(arg_11_2)

	if ActivityEnum.ActivityStatus.Normal ~= ActivityEnum.ActivityStatus.Normal then
		if var_11_1 then
			GameFacade.showToast(var_11_1, var_11_2)
		end

		return
	end

	if arg_11_3 then
		arg_11_3(arg_11_4, arg_11_1, arg_11_2)

		return
	end

	ViewMgr.instance:openView(arg_11_1)
end

function var_0_0.recordLastEnterMainActId(arg_12_0, arg_12_1)
	arg_12_0._lastEnterMainActId = arg_12_1
end

function var_0_0.clearLastEnterMainActId(arg_13_0)
	arg_13_0._lastEnterMainActId = nil
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0
