module("modules.logic.versionactivity1_7.enter.view.VersionActivity1_7EnterViewContainer", package.seeall)

slot0 = class("VersionActivity1_7EnterViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		VersionActivity1_7EnterView.New(),
		VersionActivity1_7EnterBgmView.New(),
		TabViewGroup.New(1, "#go_topleft"),
		TabViewGroup.New(2, "#go_subview")
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	elseif slot1 == 2 then
		return {
			V1a7_DungeonEnterView.New(),
			V1a7_IsoldeEnterView.New(),
			V1a7_MarcusEnterView.New(),
			V1a6_BossRush_EnterView.New(),
			ReactivityEnterview.New(),
			RoleStoryEnterView.New(),
			V1a7_Season123EnterView.New()
		}
	end
end

function slot0.selectActTab(slot0, slot1, slot2)
	slot0.activityId = slot2

	slot0:dispatchEvent(ViewEvent.ToSwitchTab, 2, slot1)
end

function slot0.onContainerInit(slot0)
	slot0.isFirstPlaySubViewAnim = true
	slot0.activityIdList = slot0.viewParam.activityIdList

	for slot4, slot5 in ipairs(slot0.activityIdList) do
		ActivityStageHelper.recordOneActivityStage(VersionActivityEnterHelper.getActId(slot5))
	end

	if VersionActivityEnterHelper.getTabIndex(slot0.activityIdList, slot0.viewParam.jumpActId) ~= 1 then
		slot0.viewParam.defaultTabIds = {
			[2] = slot1
		}
	else
		slot0.viewParam.playVideo = true
	end

	slot2 = VersionActivityEnterHelper.getActId(slot0.activityIdList[slot1])

	ActivityEnterMgr.instance:enterActivity(slot2)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		slot2
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
