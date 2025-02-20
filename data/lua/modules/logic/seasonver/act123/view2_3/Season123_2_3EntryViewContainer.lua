module("modules.logic.seasonver.act123.view2_3.Season123_2_3EntryViewContainer", package.seeall)

slot0 = class("Season123_2_3EntryViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season123_2_3CheckCloseView.New(),
		Season123_2_3EntryView.New(),
		Season123_2_3EntryScene.New(),
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

		slot0._navigateButtonView:setHelpId(HelpEnum.HelpId.Season2_3MainViewHelp)

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
