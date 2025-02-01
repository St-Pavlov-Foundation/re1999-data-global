module("modules.logic.versionactivity1_5.enter.view.VersionActivity1_5EnterViewContainer", package.seeall)

slot0 = class("VersionActivity1_5EnterViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		VersionActivity1_5EnterView.New(),
		TabViewGroup.New(1, "#go_topleft")
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
	for slot5 = #slot0.viewParam.mainActIdList, 1, -1 do
		if ActivityHelper.getActivityStatus(slot1[slot5]) == ActivityEnum.ActivityStatus.Normal then
			ActivityStageHelper.recordActivityStage(slot0.viewParam.activityIdListWithGroup[slot1[slot5]])

			return
		end
	end

	ActivityStageHelper.recordActivityStage(slot0.viewParam.activityIdListWithGroup[slot1[1]])
end

function slot0.onContainerClose(slot0)
	if slot0:isManualClose() and not ViewMgr.instance:isOpen(ViewName.MainView) then
		ViewMgr.instance:openView(ViewName.MainView)
	end
end

return slot0
