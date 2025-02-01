module("modules.logic.versionactivity1_2.enter.view.VersionActivity1_2EnterViewContainer", package.seeall)

slot0 = class("VersionActivity1_2EnterViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		VersionActivity1_2EnterView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function slot0.buildTabViews(slot0, slot1)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

function slot0.onContainerInit(slot0)
	ActivityStageHelper.recordActivityStage(slot0.viewParam.activityIdList)
end

function slot0.onContainerClose(slot0)
	if slot0:isManualClose() and not ViewMgr.instance:isOpen(ViewName.MainView) and not ViewMgr.instance:hasOpenFullView() then
		ViewMgr.instance:openView(ViewName.MainView)
	end
end

return slot0
