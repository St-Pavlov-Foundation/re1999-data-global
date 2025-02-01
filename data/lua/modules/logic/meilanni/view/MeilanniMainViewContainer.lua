module("modules.logic.meilanni.view.MeilanniMainViewContainer", package.seeall)

slot0 = class("MeilanniMainViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, MeilanniMainView.New())
	table.insert(slot1, TabViewGroup.New(1, "top_left"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	slot0._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		true
	}, HelpEnum.HelpId.VersionActivityMeiLanNi, slot0._closeCallback)

	return {
		slot0._navigateButtonView
	}
end

function slot0._closeCallback(slot0)
	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_carddisappear)
end

function slot0.onContainerClose(slot0)
end

function slot0.onContainerOpen(slot0)
	ActivityEnterMgr.instance:enterActivity(VersionActivityEnum.ActivityId.Act108)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivityEnum.ActivityId.Act108
	})
end

return slot0
