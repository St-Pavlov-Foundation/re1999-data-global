module("modules.logic.sp01.enter.view.VersionActivity2_9EnterViewContainer", package.seeall)

local var_0_0 = class("VersionActivity2_9EnterViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		VersionActivity2_9EnterView.New(),
		VersionActivity2_9EnterViewAnimComp.New(),
		VersionActivity2_9EnterViewBgmComp.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		}, nil, arg_2_0.customColseBtnCallBack, nil, nil, arg_2_0)
	}
end

function var_0_0.customColseBtnCallBack(arg_3_0)
	VersionActivity2_9EnterController.instance:clearLastEnterMainActId()
	arg_3_0:closeThis()
end

function var_0_0.onContainerInit(arg_4_0)
	local var_4_0 = arg_4_0.viewParam.mainActIdList

	for iter_4_0 = #var_4_0, 1, -1 do
		if ActivityHelper.getActivityStatus(var_4_0[iter_4_0]) == ActivityEnum.ActivityStatus.Normal then
			ActivityStageHelper.recordActivityStage(arg_4_0.viewParam.activityIdListWithGroup[var_4_0[iter_4_0]])

			return
		end
	end

	ActivityStageHelper.recordActivityStage(arg_4_0.viewParam.activityIdListWithGroup[var_4_0[1]])
end

function var_0_0.playOpenTransition(arg_5_0)
	arg_5_0:startViewOpenBlock()

	if arg_5_0.viewParam.skipOpenAnim then
		arg_5_0:onPlayOpenTransitionFinish()
	else
		TaskDispatcher.runDelay(arg_5_0.onPlayOpenTransitionFinish, arg_5_0, 1.1)
	end
end

function var_0_0.onContainerClose(arg_6_0)
	if arg_6_0:isManualClose() and not ViewMgr.instance:isOpen(ViewName.MainView) then
		MainController.instance:dispatchEvent(MainEvent.ManuallyOpenMainView)
	end
end

return var_0_0
