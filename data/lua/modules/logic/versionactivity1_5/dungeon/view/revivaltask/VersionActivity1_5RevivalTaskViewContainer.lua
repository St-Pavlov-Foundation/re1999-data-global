module("modules.logic.versionactivity1_5.dungeon.view.revivaltask.VersionActivity1_5RevivalTaskViewContainer", package.seeall)

slot0 = class("VersionActivity1_5RevivalTaskViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0.exploreTipView = VersionActivity1_5ExploreTaskTipView.New()

	return {
		VersionActivity1_5RevivalTaskView.New(),
		VersionActivity1_5ExploreTaskView.New(),
		VersionActivity1_5HeroTaskView.New(),
		VersionActivity1_5RevivalTaskTipView.New(),
		slot0.exploreTipView,
		TabViewGroup.New(1, "#go_topleft")
	}
end

function slot0.buildTabViews(slot0, slot1)
	slot0._navigateButtonsView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	slot0._navigateButtonsView:setHelpId(HelpEnum.HelpId.Dungeon1_5TaskHelp)

	return {
		slot0._navigateButtonsView
	}
end

function slot0.onContainerInit(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_paiqian_open)
end

return slot0
