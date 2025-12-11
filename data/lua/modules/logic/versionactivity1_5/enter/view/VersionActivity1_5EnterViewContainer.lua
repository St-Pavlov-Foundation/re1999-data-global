module("modules.logic.versionactivity1_5.enter.view.VersionActivity1_5EnterViewContainer", package.seeall)

local var_0_0 = class("VersionActivity1_5EnterViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		VersionActivity1_5EnterView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

function var_0_0.onContainerInit(arg_3_0)
	local var_3_0 = arg_3_0.viewParam.mainActIdList

	for iter_3_0 = #var_3_0, 1, -1 do
		if ActivityHelper.getActivityStatus(var_3_0[iter_3_0]) == ActivityEnum.ActivityStatus.Normal then
			ActivityStageHelper.recordActivityStage(arg_3_0.viewParam.activityIdListWithGroup[var_3_0[iter_3_0]])

			return
		end
	end

	ActivityStageHelper.recordActivityStage(arg_3_0.viewParam.activityIdListWithGroup[var_3_0[1]])
end

function var_0_0.onContainerClose(arg_4_0)
	if arg_4_0:isManualClose() and not ViewMgr.instance:isOpen(ViewName.MainView) then
		MainController.instance:dispatchEvent(MainEvent.ManuallyOpenMainView)
	end
end

return var_0_0
