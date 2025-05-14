module("modules.logic.versionactivity1_4.enter.view.VersionActivity1_4EnterViewContainer", package.seeall)

local var_0_0 = class("VersionActivity1_4EnterViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		VersionActivity1_4EnterView.New(),
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
	ActivityStageHelper.recordActivityStage(arg_3_0.viewParam.activityIdList)
end

function var_0_0.onContainerClose(arg_4_0)
	if arg_4_0:isManualClose() and not ViewMgr.instance:isOpen(ViewName.MainView) and not ViewMgr.instance:hasOpenFullView() then
		ViewMgr.instance:openView(ViewName.MainView)
	end
end

return var_0_0
