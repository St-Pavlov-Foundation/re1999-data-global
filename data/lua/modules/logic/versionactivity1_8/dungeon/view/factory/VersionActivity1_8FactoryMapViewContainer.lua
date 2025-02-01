module("modules.logic.versionactivity1_8.dungeon.view.factory.VersionActivity1_8FactoryMapViewContainer", package.seeall)

slot0 = class("VersionActivity1_8FactoryMapViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		VersionActivity1_8FactoryMapView.New(),
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
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_day_night)
end

return slot0
