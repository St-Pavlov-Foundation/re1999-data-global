module("modules.logic.versionactivity1_5.sportsnews.view.SportsNewsViewContainer", package.seeall)

slot0 = class("SportsNewsViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, SportsNewsView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_BackBtns"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	slot0._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		false
	})

	return {
		slot0._navigateButtonView
	}
end

function slot0.onContainerInit(slot0)
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_5Enum.ActivityId.SportsNews)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_5Enum.ActivityId.SportsNews
	})
end

return slot0
