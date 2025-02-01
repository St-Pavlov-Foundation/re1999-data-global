module("modules.logic.versionactivity1_8.enter.view.VersionActivity1_8EnterViewContainer", package.seeall)

slot0 = class("VersionActivity1_8EnterViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		VersionActivity1_8EnterView.New(),
		VersionActivity1_8EnterBgmView.New(),
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
			[#slot2 + 1] = V1a8_DungeonEnterView.New(),
			[#slot2 + 1] = ReactivityEnterview.New(),
			[#slot2 + 1] = V1a8_WeilaEnterView.New(),
			[#slot2 + 1] = V1a6_BossRush_EnterView.New(),
			[#slot2 + 1] = RoleStoryEnterView.New(),
			[#slot2 + 1] = V1a8_WindSongEnterView.New(),
			[#slot2 + 1] = V1a8_Season123EnterView.New()
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

	if VersionActivityEnterHelper.getTabIndex(slot0.viewParam.activitySettingList or {}, slot0.viewParam.jumpActId) ~= 1 then
		slot0.viewParam.defaultTabIds = {
			[2] = slot3
		}
	elseif not slot0.viewParam.isDirectOpen then
		slot0.viewParam.playVideo = true
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
