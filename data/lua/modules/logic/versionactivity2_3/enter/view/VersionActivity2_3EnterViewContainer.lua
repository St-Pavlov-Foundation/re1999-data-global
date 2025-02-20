module("modules.logic.versionactivity2_3.enter.view.VersionActivity2_3EnterViewContainer", package.seeall)

slot0 = class("VersionActivity2_3EnterViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		VersionActivity2_3EnterView.New(),
		VersionActivity2_3EnterBgmView.New(),
		TabViewGroup.New(1, "#go_topleft"),
		TabViewGroup.New(2, "#go_subview")
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			slot0._navigateButtonView
		}
	elseif slot1 == 2 then
		slot2 = {
			[#slot2 + 1] = VersionActivity2_3DungeonEnterView.New(),
			[#slot2 + 1] = VersionActivity2_3Act174EnterView.New(),
			[#slot2 + 1] = VersionActivity2_3DuDuGuEnterView.New(),
			[#slot2 + 1] = VersionActivity2_3ZhiXinQuanErEnterView.New(),
			[#slot2 + 1] = V2a3_Season123EnterView.New(),
			[#slot2 + 1] = V1a6_BossRush_EnterView.New(),
			[#slot2 + 1] = RoleStoryEnterView.New(),
			[#slot2 + 1] = ActivityWeekWalkDeepShowView.New(),
			[#slot2 + 1] = TowerMainEntryView.New()
		}

		return slot2
	end
end

function slot0.selectActTab(slot0, slot1, slot2)
	slot0.activityId = slot2

	slot0:dispatchEvent(ViewEvent.ToSwitchTab, 2, slot1)
end

function slot0.onContainerInit(slot0)
	if not slot0.viewParam then
		return
	end

	slot0.isFirstPlaySubViewAnim = true

	ActivityStageHelper.recordActivityStage(slot0.viewParam.activityIdList or {})

	slot0.activityId = slot0.viewParam.jumpActId

	if VersionActivityEnterHelper.getTabIndex(slot0.viewParam.activitySettingList or {}, slot0.activityId) ~= 1 then
		slot0.viewParam.defaultTabIds = {
			[2] = slot3
		}
	end

	slot5 = VersionActivityEnterHelper.getActId(slot2[slot3])

	ActivityEnterMgr.instance:enterActivity(slot5)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		slot5
	})
end

function slot0.onContainerClose(slot0)
	if slot0:isManualClose() and not ViewMgr.instance:isOpen(ViewName.MainView) then
		ViewMgr.instance:openView(ViewName.MainView)
	end
end

function slot0.getIsFirstPlaySubViewAnim(slot0)
	return slot0.isFirstPlaySubViewAnim
end

function slot0.markPlayedSubViewAnim(slot0)
	slot0.isFirstPlaySubViewAnim = false
end

return slot0
