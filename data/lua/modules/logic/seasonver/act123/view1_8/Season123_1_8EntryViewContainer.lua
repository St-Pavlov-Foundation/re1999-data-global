module("modules.logic.seasonver.act123.view1_8.Season123_1_8EntryViewContainer", package.seeall)

slot0 = class("Season123_1_8EntryViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season123_1_8CheckCloseView.New(),
		Season123_1_8EntryView.New(),
		Season123_1_8EntryScene.New(),
		TabViewGroup.New(1, "top_left")
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			true
		})

		slot0._navigateButtonView:setHelpId(HelpEnum.HelpId.Season1_8MainViewHelp)

		return {
			slot0._navigateButtonView
		}
	end
end

function slot0.onContainerInit(slot0)
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_7Enum.ActivityId.Season)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_7Enum.ActivityId.Season
	})
end

return slot0
