module("modules.logic.versionactivity2_4.enter.view.VersionActivity2_4EnterViewContainer", package.seeall)

slot0 = class("VersionActivity2_4EnterViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		VersionActivity2_4EnterView.New(),
		VersionActivity2_4EnterBgmView.New(),
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
			[#slot2 + 1] = VersionActivity2_4DungeonEnterView.New(),
			[#slot2 + 1] = V2a4_PinballEnterView.New(),
			[#slot2 + 1] = VersionActivity2_4MusicEnterView.New(),
			[#slot2 + 1] = VersionActivity2_4WuErLiXiEnterView.New(),
			[#slot2 + 1] = ReactivityEnterview.New(),
			[#slot2 + 1] = VersionActivity2_4RougeEnterView.New(),
			[#slot2 + 1] = V2a4_Season166EnterView.New(),
			[#slot2 + 1] = RoleStoryEnterView.New(),
			[#slot2 + 1] = V1a6_BossRush_EnterView.New(),
			[#slot2 + 1] = ActivityWeekWalkDeepShowView.New(),
			[#slot2 + 1] = TowerMainEntryView.New()
		}

		return slot2
	end
end

function slot0.selectActTab(slot0, slot1, slot2)
	slot0.activityId = slot2

	if slot0.activityId == VersionActivity2_4Enum.ActivityId.Dungeon then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_4Dungeon.enterview_tab_switch)
	end

	slot0:dispatchEvent(ViewEvent.ToSwitchTab, 2, slot1)
end

function slot0.onContainerInit(slot0)
	if not slot0.viewParam then
		return
	end

	slot0.isFirstPlaySubViewAnim = true

	ActivityStageHelper.recordActivityStage(slot0.viewParam.activityIdList or {})

	slot0.activityId = slot0.viewParam.jumpActId
	slot2 = slot0.viewParam.activitySettingList or {}
	slot3 = VersionActivityEnterHelper.getTabIndex(slot2, slot0.activityId)
	slot5 = VersionActivityEnterHelper.getActId(slot2[slot3])

	if slot3 ~= 1 then
		slot0.viewParam.defaultTabIds = {
			[2] = slot3
		}
	elseif not slot0.viewParam.isDirectOpen and slot5 == VersionActivity2_4Enum.ActivityId.Dungeon then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_4Dungeon.play_ui_diqiu_open)
	end

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
